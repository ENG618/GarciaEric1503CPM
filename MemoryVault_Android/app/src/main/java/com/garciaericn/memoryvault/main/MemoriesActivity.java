package com.garciaericn.memoryvault.main;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;

import com.garciaericn.memoryvault.R;
import com.garciaericn.memoryvault.settings.SettingsActivity;

/**
 * Full Sail University
 * Mobile Development BS
 * Created by ENG618-Mac on 3/4/15.
 */
public class MemoriesActivity extends ActionBarActivity {

    private Toolbar toolbar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_memories);

        toolbar = (Toolbar) findViewById(R.id.app_bar);
        setSupportActionBar(toolbar);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.action_settings: {
                startActivity(new Intent(this, SettingsActivity.class));
                return true;
            }
            case R.id.action_add: {
                // TODO: Launch add memory activity
                return true;
            }
            case R.id.action_sync: {
                // Handle in fragment
                return false;
            }
        }
        return super.onOptionsItemSelected(item);
    }
}
