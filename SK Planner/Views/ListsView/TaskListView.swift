//
//  TaskListView.swift
//  SK Planner
//
//  Created by Sara Kim on 4/13/23.
//

import SwiftUI

struct TaskListView: View {
    var taskList: TaskList
    
    var body: some View {
        Text(taskList.title)
        List {
            ForEach (taskList.tasks) { task in
                Text(task.name)
                //TextField("", text: task.name)
            }
//            .onMove { indices, destination in
//                taskList.tasks.move(fromOffsets: indices,
//                        toOffset: destination)
//            }
        }
    }
}

//struct TaskListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskListView()
//    }
//}
