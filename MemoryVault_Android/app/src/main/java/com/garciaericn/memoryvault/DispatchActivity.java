package com.garciaericn.memoryvault;

import com.garciaericn.memoryvault.main.MemoriesActivity;
import com.parse.ui.ParseLoginDispatchActivity;

/**
 * Full Sail University
 * Mobile Development BS
 * Created by ENG618-Mac on 3/4/15.
 */
public class DispatchActivity extends ParseLoginDispatchActivity {
    @Override
    protected Class<?> getTargetClass() {
        return MemoriesActivity.class; // Launch main memories activity
    }
}
