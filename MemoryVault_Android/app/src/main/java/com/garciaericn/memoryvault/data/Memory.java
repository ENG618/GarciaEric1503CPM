package com.garciaericn.memoryvault.data;

import com.parse.ParseClassName;
import com.parse.ParseObject;
import com.parse.ParseQuery;

import java.util.Date;

/**
 * Full Sail University
 * Mobile Development BS
 * Created by ENG618-Mac on 3/4/15.
 */
@ParseClassName("Memories")
public class Memory extends ParseObject {
    public static final String MEMORIES = "Memories";
    public static final String MEMORY_TAG = "Local memories";

    private static final String TITLE = "Title";
    private static final String DATE = "Date";
    private static final String GUESTS = "Guests";
    private static final String NOTES = "Notes";

    public Memory() {
        // Required no arguments constructor
    }

    public Memory(String title, Date date, int guests, String notes) {
        setTitle(title);
        setDate(date);
        setGuests(guests);
        setNotes(notes);
    }

    public String getTitle() {
        return getString(TITLE);
    }

    public void setTitle(String title) {
        put(TITLE, title);
    }

    public Date getDate() {
        return getDate(DATE);
    }

    public void setDate(Date date) {
        put(DATE, date);
    }
    public int getGuests() {
        return getInt(GUESTS);
    }

    public void setGuests(int guests) {
        put(GUESTS, guests);
    }

    public String getNotes() {
        return getString(NOTES);
    }

    public void setNotes(String notes) {
        put(NOTES, notes);
    }

    public static ParseQuery<Memory> getQuery() {
        return ParseQuery.getQuery(Memory.class);
    }
}
