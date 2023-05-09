//
//  ViewModel.swift
//  SK Planner
//
//  Created by Sara Kim on 4/13/23.
//

import Foundation
import SwiftUI

@MainActor
class ViewModel: ObservableObject {
    @Published var editMenuNeeded = false
    @Published var taskLists: [TaskList] = [] 
    var date: Date = .now
    
    
    let colors: [Color] = [Color.pink, Color.red, Color.orange, Color.yellow, Color.green, Color.cyan, Color.blue, Color.indigo, Color.purple, Color.brown]
    let color_names: [String] = ["Pink", "Red", "Orange", "Yellow", "Green", "Cyan", "Blue", "Indigo", "Purple", "Brown"]
    var color_index = 0 {
        didSet {
            if color_index >= colors.count {
                color_index = 0
            }
        }
    }
    
    func getColorString (color: Color) -> String {
        switch (color) {
        case .pink:
            return "Pink"
        case .red:
            return "Red"
        case .orange:
            return "Orange"
        case .yellow:
            return "Yellow"
        case .green:
            return "Green"
        case .cyan:
            return "Cyan"
        case .blue:
            return "Blue"
        case .indigo:
            return "Indigo"
        case .purple:
            return "Purple"
        case .brown:
            return "Brown"
        default:
            return ""
        }
    }
    
    /*
     CITATION: Persisting Data [4]
     Trying to implement saving of app state
     */
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("taskLists.data")
    }
    
    func load() async throws {
        let task = Task<[TaskList], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let dailyScrums = try JSONDecoder().decode([TaskList].self, from: data)
            return dailyScrums
        }
        let scrums = try await task.value
        self.taskLists = scrums
    }
    
    func save(taskLists: [TaskList]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(taskLists)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}


extension Color: Identifiable {
    public var id: Color.ID {
        return Color.ID()
    }
        
    public struct ID: Hashable, Identifiable {
        public let id = UUID()
    }
}

