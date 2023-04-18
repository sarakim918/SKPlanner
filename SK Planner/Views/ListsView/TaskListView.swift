//
//  TaskListView.swift
//  SK Planner
//
//  Created by Sara Kim on 4/13/23.
//

import SwiftUI

struct TaskListView: View {
    @State var taskList: TaskList
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack {
            Text(taskList.title)
            Button(action: {
                for i in 0..<viewModel.taskLists.count {
                    if taskList.id == viewModel.taskLists[i].id {
                        viewModel.taskLists.remove(at: i)
                        break
                    }
                }
            }, label: { // 1
                Text("Delete")
                    .foregroundColor(Color.red)
            })
            .frame(maxHeight: 30)
        }
        List {
            ForEach (taskList.tasks) { task in
                HStack {
                    Text(task.name)
                    Divider()
                    Text("Due " + task.dueDate.formatted(.dateTime.day().month()))
                    Divider()
                    Button(action: {
                        for i in 0..<taskList.tasks.count {
                            if task.id == taskList.tasks[i].id {
                                taskList.tasks.remove(at: i)
                                break
                            }
                        }
                    }, label: { // 1
                        Text("Delete")
                            .foregroundColor(Color.red)
                    })
                    .frame(maxHeight: 30)
                }
            }
            .onMove { indices, destination in
                taskList.tasks.move(fromOffsets: indices,
                        toOffset: destination)
            }
        }
        Button(action: addTask, label: { // 1
            Image(systemName: "plus.app")
        })
        .frame(maxHeight: 30)
    }
    
    func addTask() {
        let temp: Task = Task(name: "Another Task", dueDate: Date.now, subtasks: [])
        taskList.tasks.append(temp)
    }
}

//struct TaskListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskListView()
//    }
//}
