package com.garciaericn.memoryvault.addMemory;

import android.app.Activity;
import android.app.DatePickerDialog;
import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.TextView;

import com.GarciaEric.networkcheck.NetworkCheck;
import com.garciaericn.memoryvault.R;
import com.garciaericn.memoryvault.data.Memory;

import java.util.Calendar;
import java.util.Date;

/**
 * Full Sail University
 * Mobile Development BS
 * Created by ENG618-Mac on 3/6/15.
 */
public class AddMemoryFragment extends Fragment implements View.OnClickListener, DatePickerDialog.OnDateSetListener {

    private AddMemoryInteractionListener mListener;
    private TextView displayDateTV;
    private EditText titleET;
    private EditText guestsET;
    private EditText notesET;

    private int year;
    private int month;
    private int day;

    private Memory memory;
    private Date date;

    public AddMemoryFragment() {
        // Manda
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setHasOptionsMenu(true);

        Calendar today = Calendar.getInstance();
        year = today.get(Calendar.YEAR);
        month = today.get(Calendar.MONTH);
        day = today.get(Calendar.DAY_OF_MONTH);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_add_memory, container, false);

        displayDateTV = (TextView) view.findViewById(R.id.add_date_tv);
        displayDateTV.setOnClickListener(this);
        if (displayDateTV != null) {
            updateDate();
        }
        titleET = (EditText) view.findViewById(R.id.add_title_et);
        guestsET = (EditText) view.findViewById(R.id.add_guests_et);
        notesET = (EditText) view.findViewById(R.id.add_notes_et);

        return view;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.action_save: {
                saveMemory();
                return true;
            }
        }
        return super.onOptionsItemSelected(item);
    }

    @Override
    public void onAttach(Activity activity) {
        super.onAttach(activity);
        try {
            mListener = (AddMemoryInteractionListener) activity;
        } catch (ClassCastException e) {
            throw new ClassCastException(activity.toString() + " must implement AddMemoryInteractionListener");
        }
    }

    @Override
    public void onDetach() {
        super.onDetach();
        mListener = null;
    }

    @Override
    public void onDateSet(DatePicker view, int year, int monthOfYear, int dayOfMonth) {
        this.year = year;
        this.month = monthOfYear;
        this.day = dayOfMonth;
        updateDate();
    }

    public Date getDate() {
        date = new Date(year, month, day);
        return date;
    }

    private void updateDate() {
        displayDateTV.setText(new StringBuilder()
                .append(month + 1).append("/")
                .append(day).append("/")
                .append(year));
    }

    private void saveMemory() {

        // Validate input
        String titleString = titleET.getText().toString();
        if (titleString.isEmpty()) {
            mListener.showAlertDialog("Please enter a Title");
            return;
        }
        int numGuests;
        try {
            numGuests = Integer.parseInt(guestsET.getText().toString());
        } catch (NumberFormatException e) {
            mListener.showAlertDialog("Please enter number of guests");
            return;
        }

        NetworkCheck networkCheck = new NetworkCheck();
        if (networkCheck.check(getActivity())) {

            String notesString = notesET.getText().toString();

            memory = new Memory();
            memory.setTitle(titleString);
            memory.setGuests(numGuests);
            if (!notesString.isEmpty()) {
                memory.setNotes(notesString);
            }
            memory.setDate(getDate());
            memory.saveInBackground();

            mListener.memorySaved();
        } else {
            // No network
            mListener.showAlertDialog("No network connection!! \n" +
                    "Memory will be saved locally until network available");

            String notesString = notesET.getText().toString();

            memory = new Memory();
            memory.setTitle(titleString);
            memory.setGuests(numGuests);
            if (!notesString.isEmpty()) {
                memory.setNotes(notesString);
            }
            memory.setDate(getDate());
            memory.saveEventually();

            mListener.memorySaved();
        }

    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.add_date_tv: {
                new DatePickerDialog(getActivity(), this, year, month, day).show();
                break;
            }
        }
    }

    public interface AddMemoryInteractionListener {
        public void showAlertDialog(String message);

        public void memorySaved();
    }
}
