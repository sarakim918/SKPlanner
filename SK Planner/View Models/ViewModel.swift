//
//  ViewModel.swift
//  SK Planner
//
//  Created by Sara Kim on 4/13/23.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Published var editMenuNeeded = false
    @Published var taskLists: [TaskList] = [] {
        didSet {
            print("Changes made")
        }
    }
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
}


extension Color: Identifiable {
    public var id: Color.ID {
        return Color.ID()
    }
        
    public struct ID: Hashable, Identifiable {
        public let id = UUID()
    }
}

