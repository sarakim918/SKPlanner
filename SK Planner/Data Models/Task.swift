//
//  Task.swift
//  SK Planner
//
//  Created by Sara Kim on 4/13/23.
//

import Foundation

struct Task: Identifiable {
    let id = Task.ID()
    var name: String
    var dueDate: Date
    var completed: Bool = false {
        didSet {
            print("completed set to: \(String(completed))")
        }
    }
    
    struct ID: Hashable, Identifiable {
        let id = UUID()
    }
}
