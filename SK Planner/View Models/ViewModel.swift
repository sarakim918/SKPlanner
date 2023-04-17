//
//  ViewModel.swift
//  SK Planner
//
//  Created by Sara Kim on 4/13/23.
//

import Foundation

class ViewModel: ObservableObject {
    var taskLists: [TaskList] = []
    var date: Date {
        didSet {
            print("WHORE")
        }
    }
    
    init() {
        for j in 0..<4 {
            let rand = Int.random(in: 1..<8)
            var tasks: [Task] = []
            for i in 0..<rand {
                let tempTask = Task(name: "Task "+String(i+1), dueDate: Date.now, subtasks: [])
                tasks.append(tempTask)
            }
            let tempTaskList = TaskList(title: "List "+String(j+1), tasks: tasks)
            taskLists.append(tempTaskList)
        }
        date = .now
    }
}


