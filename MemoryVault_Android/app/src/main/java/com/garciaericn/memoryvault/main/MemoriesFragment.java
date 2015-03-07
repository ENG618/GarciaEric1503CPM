package com.garciaericn.memoryvault.main;

import android.os.Bundle;
import android.view.MenuItem;
import android.widget.Toast;

import com.garciaericn.memoryvault.R;
import com.garciaericn.memoryvault.data.Memory;
import com.garciaericn.memoryvault.data.MemoryAdapter;
import com.parse.FindCallback;
import com.parse.ParseException;
import com.parse.ParseQueryAdapter;

import java.util.ArrayList;
import java.util.List;

/**
 * Full Sail University
 * Mobile Development BS
 * Created by ENG618-Mac on 3/5/15.
 */
public class MemoriesFragment extends android.app.ListFragment {

    ArrayList<Memory> memoriesArrayList;
    MemoryAdapter memoryAdapter;

    public MemoriesFragment() {
        // Mandatory empty constructor
    }

    public static MemoriesFragment newInstance() {
        return new MemoriesFragment();
    }


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setHasOptionsMenu(true);
        if (memoriesArrayList == null) {
            memoriesArrayList = new ArrayList<>();
        }

        memoryAdapter = new MemoryAdapter(getActivity());
        setListAdapter(memoryAdapter);
        refreshMemories();
    }

    private void refreshMemories() {
        Memory.getQuery().findInBackground(new FindCallback<Memory>() {
            @Override
            public void done(List<Memory> memoryList, ParseException e) {
                memoriesArrayList = (ArrayList<Memory>) memoryList;
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
}
