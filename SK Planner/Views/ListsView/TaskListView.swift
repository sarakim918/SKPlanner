//
//  TaskListView.swift
//  SK Planner
//
//  Created by Sara Kim on 4/13/23.
//

import SwiftUI

struct TaskListView: View {
    @State var taskList: TaskList
    
    var body: some View {
        Text(taskList.title)
        List {
            ForEach (taskList.tasks) { task in
                HStack {
                    Text(task.name)
                    Divider()
                    Text("Due " + task.dueDate.formatted(.dateTime.day().month()))
                }
            }
            .onMove { indices, destination in
                taskList.tasks.move(fromOffsets: indices,
                        toOffset: destination)
            }
        }
        Button(action: addList, label: { // 1
            Image(systemName: "plus.app")
        })
        .frame(maxHeight: 30)
    }
    
    func addList() {
        var temp: Task = Task(name: "Another Task", dueDate: Date.now, subtasks: [])
        taskList.tasks.append(temp)
    }
}

//struct TaskListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskListView()
//    }
//}
