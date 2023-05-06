//
//  DayView.swift
//  SK Planner
//
//  Created by Sara Kim on 4/13/23.
//

import SwiftUI

struct DayView: View {
    @ObservedObject var viewModel: ViewModel
    var date: Date
    
    var body: some View {
        VStack {
            Text(date.formatted(.dateTime.weekday().day().month().year()))
                .font(.title2)
            
            List {
                if (noTasks()) {
                    Text("No tasks today!")
                        .foregroundColor(.gray)
                } else {
                    ForEach (viewModel.taskLists) { taskList in
                        if (tasksInTaskList(tasks: taskList.tasks)) {
                            Text(taskList.title)
                                .foregroundColor(taskList.color)
                            ForEach(taskList.tasks) { task in
                                if (task.dueDate.formatted(.dateTime.weekday().day().month().year()) == date.formatted(.dateTime.weekday().day().month().year())) {
                                    HStack {
                                        Divider()
                                        Text(task.name)
                                            .foregroundColor(taskList.color)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func noTasks() -> Bool {
        for taskList in viewModel.taskLists {
            for temp_task in taskList.tasks {
                if (temp_task.dueDate.formatted(.dateTime.weekday().day().month().year()) == date.formatted(.dateTime.weekday().day().month().year())) {
                    return false
                }
            }
        }
        return true
    }
    
    private func tasksInTaskList(tasks: [Task]) -> Bool {
        for task in tasks {
            if (task.dueDate.formatted(.dateTime.weekday().day().month().year()) == date.formatted(.dateTime.weekday().day().month().year())) {
                return true
            }
        }
        return false
    }
    
}

//struct DayView_Previews: PreviewProvider {
//    static var previews: some View {
//        DayView()
//    }
//}
