package com.garciaericn.memoryvault.main;

import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.garciaericn.memoryvault.R;

/**
 * Full Sail University
 * Mobile Development BS
 * Created by ENG618-Mac on 3/5/15.
 */
public class MemoriesFragment extends Fragment {



    public MemoriesFragment() {
        // Mandatory empty constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.fragment_memories, container, false);

        // TODO: Set up view here...

        return view;
    }
}
