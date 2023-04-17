//
//  Subtask.swift
//  SK Planner
//
//  Created by Sara Kim on 4/17/23.
//

import Foundation

struct Subtask: Identifiable {
    let id = Task.ID()
    var name: String
    
    struct ID: Hashable, Identifiable {
        let id = UUID()
    }
}
