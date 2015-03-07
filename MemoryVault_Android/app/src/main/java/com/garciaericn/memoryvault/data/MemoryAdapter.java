package com.garciaericn.memoryvault.data;

import android.app.Activity;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;

import com.garciaericn.memoryvault.R;

import java.util.List;

/**
 * Full Sail University
 * Mobile Development BS
 * Created by ENG618-Mac on 3/6/15.
 */
public class MemoryAdapter extends ArrayAdapter<Memory> {

    private List<Memory> objects;
    private Context context;

    public MemoryAdapter(Context context, int resource, List<Memory> objects) {
        super(context, resource, objects);
        this.context = context;
        this.objects = objects;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        LayoutInflater inflater = (LayoutInflater) context.getSystemService(Activity.LAYOUT_INFLATER_SERVICE);

        View view = inflater.inflate(R.layout.memory_item, null);

        // TODO: Setup view

        return view;
    }
}
