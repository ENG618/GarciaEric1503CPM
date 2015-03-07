package com.garciaericn.memoryvault.main;

import android.app.Fragment;
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

import com.garciaericn.memoryvault.R;
import com.garciaericn.memoryvault.data.Memory;
import com.garciaericn.memoryvault.data.MemoryAdapter;
import com.parse.DeleteCallback;
import com.parse.FindCallback;
import com.parse.ParseException;

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
        memoryAdapter = new MemoryAdapter(getActivity());
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
        Memory.getQuery().findInBackground(new FindCallback<Memory>() {
            @Override
            public void done(List<Memory> memoryList, ParseException e) {
                memoryAdapter.loadObjects();
            }
        });
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
        memory.deleteInBackground(new DeleteCallback() {
            @Override
            public void done(ParseException e) {
                refreshMemories();
            }
        });
        Toast.makeText(getActivity(), memory.toString() + " was deleted", Toast.LENGTH_SHORT).show();
    }
}
