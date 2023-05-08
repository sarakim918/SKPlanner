//
//  TaskListView.swift
//  SK Planner
//
//  Created by Sara Kim on 4/13/23.
//

import SwiftUI

struct TaskListView: View {
    @State var taskListId: TaskList.ID?
    @ObservedObject var viewModel: ViewModel 
    @State var editListNeeded: Bool = true
    var listForEditID: TaskList.ID {
        viewModel.taskLists[taskListIndex].id
    }
    @State var taskForEditID: Task.ID!
    var taskListIndex: Int {
        for i in 0..<viewModel.taskLists.count {
            if taskListId == viewModel.taskLists[i].id {
                return i
            }
        }
        return 0
    }
    
    var body: some View {
        if (viewModel.taskLists.count > 0) {
            HStack {
                VStack {
                    HStack {
                        Text(viewModel.taskLists[taskListIndex].title)
                        Button(action: {
                            viewModel.editMenuNeeded = true
                            editListNeeded = true
                        }, label: { // 1
                            Text("Edit")
                                .foregroundColor(Color.green)
                        })
                        .frame(maxHeight: 30)
                    }
                    List {
                        ForEach (viewModel.taskLists[taskListIndex].tasks) { task in
                            HStack {
                                CheckableTask(taskID: task.id, viewModel: viewModel)
                                Spacer()
                                Text("Due " + getDateString(task: task))
                                Spacer()
                                    .frame(width: 20)
                                
                                Button(action: {
                                    viewModel.editMenuNeeded = true
                                    editListNeeded = false
                                    taskForEditID = task.id
                                }, label: { // 1
                                    Text("Edit")
                                        .foregroundColor(Color.green)
                                })
                                .frame(maxHeight: 30)
                            }
                        }
                        .onMove { indices, destination in
                            viewModel.taskLists[taskListIndex].tasks.move(fromOffsets: indices,
                                                                          toOffset: destination)
                        }
                    }
                    Button(action: addTask, label: { // 1
                        Image(systemName: "plus")
                    })
                    .frame(maxHeight: 30)
                }
                .frame(minWidth: 300, minHeight: 250)
                
                if (viewModel.editMenuNeeded) {
                    Divider()
                        .padding(.horizontal, -8)
                        .padding(.vertical, -8)
                    if (editListNeeded) {
                        EditListView(listID: listForEditID, viewModel: viewModel)
                            .frame(minWidth: 300, minHeight: 300)
                    } else {
                        EditTaskView(taskID: taskForEditID!, viewModel: viewModel)
                            .frame(minWidth: 300, minHeight: 300)
                    }
                }
            }
            .frame(minWidth: 400, minHeight: 300)
        }
    }
    
    func addTask() {
        let temp: Task = Task(name: "NEW Task", dueDate: Date.now)
        
        for i in 0..<viewModel.taskLists.count {
            if taskListId == viewModel.taskLists[i].id {
                viewModel.taskLists[i].tasks.append(temp)
            }
        }
    }
    
    private func getDateString (task: Task) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: task.dueDate)
    }
        
}

//struct TaskListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskListView()
//    }
//}
