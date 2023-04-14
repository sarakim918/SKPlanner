//
//  SK_PlannerApp.swift
//  SK Planner
//
//  Created by Sara Kim on 4/12/23.
//

import SwiftUI

@main
struct SK_PlannerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands {
            ListMenuCommands()
        }
    }
}
