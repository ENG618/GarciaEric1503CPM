package com.garciaericn.memoryvault.main;

import android.app.AlertDialog;
import android.app.Fragment;
import android.content.DialogInterface;
import android.os.Bundle;
import android.view.ActionMode;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.Toast;

import com.GarciaEric.networkcheck.NetworkCheck;
import com.garciaericn.memoryvault.R;
import com.garciaericn.memoryvault.data.Memory;
import com.garciaericn.memoryvault.data.MemoryAdapter;
import com.parse.DeleteCallback;
import com.parse.FindCallback;
import com.parse.ParseException;
import com.parse.ParseQuery;
import com.parse.ParseQueryAdapter;

import java.util.List;

/**
 * Full Sail University
 * Mobile Development BS
 * Created by ENG618-Mac on 3/5/15.
 */
public class MemoriesFragment extends Fragment implements AbsListView.MultiChoiceModeListener, AdapterView.OnItemClickListener {

    ListView memoriesListView;
    MemoryAdapter memoryAdapter;

    public MemoriesFragment() {
        // Mandatory empty constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setHasOptionsMenu(true);

        // Set up the Parse query to use in the adapter
        ParseQueryAdapter.QueryFactory<Memory> factory = new ParseQueryAdapter.QueryFactory<Memory>() {
            public ParseQuery<Memory> create() {
                ParseQuery<Memory> query = Memory.getLocalQuery();
                return query;
            }
        };

        memoryAdapter = new MemoryAdapter(getActivity(), factory);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_memories, container);

        memoriesListView = (ListView) view.findViewById(R.id.listView);
        memoriesListView.setAdapter(memoryAdapter);
        memoriesListView.setOnItemClickListener(this);
        memoriesListView.setChoiceMode(ListView.CHOICE_MODE_MULTIPLE_MODAL);
        memoriesListView.setMultiChoiceModeListener(this);

        return view;
    }

    private void refreshMemories() {
        NetworkCheck networkCheck = new NetworkCheck();
        if (networkCheck.check(getActivity())) { // Has network available
            Memory.getQuery().findInBackground(new FindCallback<Memory>() {
                @Override
                public void done(final List<Memory> memoryList, ParseException e) {
                    // Remove old cache
                    Memory.unpinAllInBackground(new DeleteCallback() {
                        @Override
                        public void done(ParseException e) {
                            // Save new cache
                            Memory.pinAllInBackground(Memory.MEMORY_TAG, memoryList);
                        }
                    });
                    memoryAdapter.loadObjects();
                }
            });
        } else { // No network connection
            AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
            builder.setTitle("No Available Network!!");
            builder.setMessage("Memories will by synced with cached data");
            builder.setPositiveButton("Okay", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    // Load from LocalDataStore
                    Memory.getLocalQuery().findInBackground(new FindCallback<Memory>() {
                        @Override
                        public void done(List<Memory> memoryList, ParseException e) {

                        }
                    });
                    memoryAdapter.loadObjects();
                }
            })
                    .create()
                    .show();

        }
    }

    @Override
    public void onStart() {
        super.onStart();
        refreshMemories();
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.action_sync: {
                refreshMemories();
                Toast.makeText(getActivity(), "Refreshed from fragment", Toast.LENGTH_SHORT).show();
                return true;
            }
        }
        return super.onOptionsItemSelected(item);
    }

    @Override
    public void onItemCheckedStateChanged(ActionMode mode, int position, long id, boolean checked) {
        // Here you can do something when items are selected/de-selected,
        // such as update the title in the CAB
    }

    @Override
    public boolean onCreateActionMode(ActionMode mode, Menu menu) {
        MenuInflater inflater = mode.getMenuInflater();
        inflater.inflate(R.menu.context_menu, menu);
        return true;
    }

    @Override
    public boolean onPrepareActionMode(ActionMode mode, Menu menu) {
        return false;
    }

    @Override
    public boolean onActionItemClicked(ActionMode mode, MenuItem item) {
        switch (item.getItemId()) {
            case R.id.action_delete:
                Toast.makeText(getActivity(), "Delete!", Toast.LENGTH_SHORT).show();
                // TODO: Delete item
                mode.finish(); // Action picked, so close the CAB
                return true;
        }
        return false;
    }

    @Override
    public void onDestroyActionMode(ActionMode mode) {
        // Here you can make any necessary updates to the activity when
        // the CAB is removed. By default, selected items are deselected/unchecked.
    }

    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        Memory memory = memoryAdapter.getItem(position);
            // Un-comment to delete item
            memory.deleteEventually(new DeleteCallback() {
                @Override
                public void done(ParseException e) {
                    // Memory was deleted
                    Toast.makeText(getActivity(), "Deleted memories have been synced", Toast.LENGTH_SHORT).show();
                }
            });
        refreshMemories();
    }
}
