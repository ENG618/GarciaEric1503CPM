package com.garciaericn.memoryvault.addMemory;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.DatePickerDialog;
import android.app.Fragment;
import android.content.DialogInterface;
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
public class MemoryFragment extends Fragment implements View.OnClickListener, DatePickerDialog.OnDateSetListener {

    private AddMemoryInteractionListener mListener;
    private TextView displayDateTV;
    private EditText titleET;
    private EditText guestsET;
    private EditText notesET;

    private int year;
    private int month;
    private int day;

//    private Memory memory;
    private Date date;

    public MemoryFragment() {
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
        View view = inflater.inflate(R.layout.fragment_memory, container, false);

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

        NetworkCheck networkCheck = new NetworkCheck();
        if (networkCheck.check(getActivity())) { // Has network connection.
            Memory memory = createMemory();
            if (memory != null) {
                memory.saveInBackground();
            }
            mListener.memorySaved();
        } else { // No network
            if (validateData()) {
                AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
                builder.setTitle("No Available Network!!");
                builder.setMessage("Memory will be saved locally, and synced once a network is available");
                builder.setPositiveButton("Okay", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        Memory memory = createMemory();
                        if (memory != null) {
                            memory.saveEventually();
                        }
                        mListener.memorySaved();
                    }
                })
                .create()
                .show();
            }
        }
    }

    private boolean validateData() {
        // Validate input
        if (titleET.getText().toString().isEmpty()) {
            mListener.showAlertDialog("Please enter a Title");
            return false;
        }
        try {
            Integer.parseInt(guestsET.getText().toString());
        } catch (NumberFormatException e) {
            mListener.showAlertDialog("Please enter number of guests");
            return false;
        }
        return true;
    }

    private Memory createMemory() {
        // Obtain values
        String titleString = titleET.getText().toString();
        int numGuests;
        String notesString = notesET.getText().toString();


        // Validate input
        if (titleString.isEmpty()) {
            mListener.showAlertDialog("Please enter a Title");
            return null;
        }
        try {
            numGuests = Integer.parseInt(guestsET.getText().toString());
        } catch (NumberFormatException e) {
            mListener.showAlertDialog("Please enter number of guests");
            return null;
        }
        Memory memory = new Memory();
        memory.setTitle(titleString);
        memory.setGuests(numGuests);
        if (!notesString.isEmpty()) {
            memory.setNotes(notesString);
        }
        memory.setDate(getDate());

        return memory;
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
