package com.garciaericn.memoryvault.main;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Toast;

import com.garciaericn.memoryvault.R;
import com.garciaericn.memoryvault.addMemory.MemoryActivity;
import com.garciaericn.memoryvault.data.Memory;
import com.garciaericn.memoryvault.settings.SettingsActivity;

/**
 * Full Sail University
 * Mobile Development BS
 * Created by ENG618-Mac on 3/4/15.
 */
public class MemoriesActivity extends ActionBarActivity implements MemoriesFragment.MemoriesInteractionListener{

    private static final int ADD_MEMORY_RC = 100;
    private static final int EDIT_MEMORY_RC = 101;
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
                Intent addIntent = new Intent(this, MemoryActivity.class);
                startActivityForResult(addIntent, ADD_MEMORY_RC);
                return true;
            }
            case R.id.action_sync: {
                // Handle in fragment
                return false;
            }
        }
        return super.onOptionsItemSelected(item);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == ADD_MEMORY_RC) {
            if (resultCode == RESULT_OK) {
                // TODO: Get extras and save new memory
                showToast("Save successful");
            } else if (resultCode == RESULT_CANCELED) {
                showToast("No memory added");
            } else {
                showToast("Memory not saved");
            }
        } else if (requestCode == EDIT_MEMORY_RC) {
            if (resultCode == RESULT_OK) {
                showToast("Memory updated");
            } else {
                showToast("Memory not updated");
            }
        }
    }

    private void showToast(String message) {
        Toast.makeText(this, message, Toast.LENGTH_SHORT).show();
    }

    @Override
    public void editMemory(Memory memory) {
        Intent editIntent = new Intent(this, MemoryActivity.class);
        editIntent.putExtra(Memory.MEMORY_TAG, memory.getObjectId());
        startActivityForResult(editIntent, EDIT_MEMORY_RC);
    }
}
