//
//  TaskList.swift
//  SK Planner
//
//  Created by Sara Kim on 4/13/23.
//

import Foundation

struct TaskList: Identifiable {
    let id = TaskList.ID()
    
    var title: String
    var tasks: [Task]
    
    struct ID: Hashable, Identifiable {
        let id = UUID()
    }
}
