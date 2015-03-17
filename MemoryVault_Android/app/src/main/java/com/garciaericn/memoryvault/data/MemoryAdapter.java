package com.garciaericn.memoryvault.data;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.garciaericn.memoryvault.R;
import com.parse.ParseQuery;
import com.parse.ParseQueryAdapter;

/**
 * Full Sail University
 * Mobile Development BS
 * Created by ENG618-Mac on 3/6/15.
 */
public class MemoryAdapter extends ParseQueryAdapter<Memory> {

    public MemoryAdapter(Context context, QueryFactory<Memory> queryFactory) {
        super(context, queryFactory);
    }

    @Override
    public View getItemView(Memory object, View v, ViewGroup parent) {
        if (v == null) {
            v = View.inflate(getContext(), R.layout.memory_item, null);
        }
        super.getItemView(object, v, parent);

        TextView titleTV = (TextView) v.findViewById(R.id.item_title);
        titleTV.setText(object.getTitle());

        TextView dateTV = (TextView) v.findViewById(R.id.item_date);
        dateTV.setText(object.getDateString());

        TextView guestsTV = (TextView) v.findViewById(R.id.item_guests);
        guestsTV.setText(String.valueOf(object.getGuests()));

        return v;
    }
}
