//
//  Task_local.swift
//  SK Planner
//
//  Created by Sara Kim on 4/13/23.
//

import Foundation

struct Task_local: Identifiable, Codable {
    var id = Task_local.ID()
    var name: String
    var dueDate: Date
    var completed: Bool = false 
    
    struct ID: Hashable, Identifiable, Codable {
        var id = UUID()
    }
}
