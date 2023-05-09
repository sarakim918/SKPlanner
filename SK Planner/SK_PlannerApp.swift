//
//  SK_PlannerApp.swift
//  SK Planner
//
//  Created by Sara Kim on 4/12/23.
//

import SwiftUI

@main
struct SK_PlannerApp: App {
    @StateObject var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel) {
                Task {
                    do {
                        try await viewModel.save(taskLists: viewModel.taskLists)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .task {
                do {
                    try await viewModel.load()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
        .commands {
            ListMenuCommands()
        }
    }
}
