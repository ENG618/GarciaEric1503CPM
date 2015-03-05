package com.garciaericn.memoryvault.settings;

import android.content.Intent;
import android.os.Bundle;
import android.preference.Preference;
import android.preference.PreferenceFragment;
import android.widget.Toast;

import com.garciaericn.memoryvault.DispatchActivity;
import com.garciaericn.memoryvault.R;
import com.parse.ParseUser;

/**
 * Full Sail University
 * Mobile Development BS
 * Created by ENG618-Mac on 3/5/15.
 */
public class SettingsFragment extends PreferenceFragment implements Preference.OnPreferenceClickListener {

    // Preference keys
    public static final String LOG_OUT = "LOG_OUT";

    public SettingsFragment() {
        // Mandatory empty constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        addPreferencesFromResource(R.xml.settings);

        findPreference(LOG_OUT).setOnPreferenceClickListener(this);
    }

    @SuppressWarnings("UnusedDeclaration")
    @Override
    public boolean onPreferenceClick(Preference preference) {
        switch (preference.getKey()) {
            case (LOG_OUT): {
                ParseUser.logOut();
                ParseUser currentUser = ParseUser.getCurrentUser(); // this will now be null

                Toast.makeText(getActivity(), "You have been logged out", Toast.LENGTH_SHORT).show();

                startActivity(new Intent(getActivity(), DispatchActivity.class));
                return true;
            }
        }
        return false;
    }
}
