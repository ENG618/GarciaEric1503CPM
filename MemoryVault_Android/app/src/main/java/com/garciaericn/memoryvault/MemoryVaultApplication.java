package com.garciaericn.memoryvault;

import android.app.Application;

import com.parse.Parse;
import com.parse.ParseACL;

/**
 * Full Sail University
 * Mobile Development BS
 * Created by ENG618-Mac on 3/3/15.
 */
public class MemoryVaultApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();

        // Enable Local Datastore.
        Parse.enableLocalDatastore(this);

        Parse.initialize(this, "MiZYFPmMpo5lE7mkch6IGYHHd3hYaFz1UOXTMSI0", "yzcLFEPJEjua3oIWOjInSq5KRSbIZvsVoEkgFbgm");
        ParseACL.setDefaultACL(new ParseACL(), true);

    }
}
