package com.garciaericn.memoryvault.settings;

import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;

import com.garciaericn.memoryvault.R;

/**
 * Full Sail University
 * Mobile Development BS
 * Created by ENG618-Mac on 3/5/15.
 */
public class SettingsActivity extends ActionBarActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_settings);

        getFragmentManager().beginTransaction()
                .replace(R.id.settings_container, new SettingsFragment())
                .commit();
    }
}
