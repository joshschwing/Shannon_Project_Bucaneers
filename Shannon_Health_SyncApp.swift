//
//  Shannon_Health_SyncApp.swift
//  Shannon Health Sync
//
//  Created by Joshua Schwing on 9/30/23.
//

import SwiftUI
import Firebase

@main
struct Shannon_Health_SyncApp: App {
    
    
    /* this code is used to get firebase setup*/
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
