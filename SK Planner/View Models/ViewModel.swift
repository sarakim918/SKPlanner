//
//  ViewModel.swift
//  SK Planner
//
//  Created by Sara Kim on 4/13/23.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Published var taskLists: [TaskList] = [] {
        didSet {
            print("Task Lists updated")
        }
    }
    var date: Date = .now {
        didSet {
            print("date set in ViewModel")
        }
    }
    
    
    let colors: [Color] = [Color.pink, Color.red, Color.orange, Color.yellow, Color.green, Color.cyan, Color.blue, Color.indigo, Color.purple, Color.brown]
    var color_index = 0 {
        didSet {
            if color_index >= colors.count {
                color_index = 0
            }
        }
    }
    
    let dates: [Date] = [Date.now.addingTimeInterval(86400), Date.now, Date.now.addingTimeInterval(-86400)]
    
    
    init() {
        for j in 0..<4 {
            let rand = Int.random(in: 1..<8)
            var tasks: [Task] = []
            for i in 0..<rand {
                let tempTask = Task(name: "Task "+String(i+1), dueDate: dates[Int.random(in: 1..<3)], subtasks: [])
                tasks.append(tempTask)
            }
            let tempTaskList = TaskList(title: "List "+String(j+1), tasks: tasks, color: colors[color_index])
            color_index+=1
            taskLists.append(tempTaskList)
        }
    }
}


