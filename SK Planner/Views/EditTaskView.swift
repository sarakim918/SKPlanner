//
//  EditTaskView.swift
//  SK Planner
//
//  Created by Sara Kim on 5/7/23.
//

import SwiftUI

struct EditTaskView: View {
    @State var taskID: Task_local.ID
    @ObservedObject var viewModel: ViewModel 
    var listIndex: Int {
        for i in 0..<viewModel.taskLists.count {
            for j in 0..<viewModel.taskLists[i].tasks.count {
                if taskID == viewModel.taskLists[i].tasks[j].id {
                    return i
                }
            }
        }
        return -1
    }
    var taskIndex: Int {
        for i in 0..<viewModel.taskLists.count {
            for j in 0..<viewModel.taskLists[i].tasks.count {
                if taskID == viewModel.taskLists[i].tasks[j].id {
                    return j
                }
            }
        }
        return -1
    }
    
    var body: some View {
        if (listIndex != -1 && taskIndex != -1) {
            VStack {
                Text("Edit Task")
                Divider()
                    .padding(.horizontal, -8)
                    .padding(.vertical, -8)
                Spacer()
                    .frame(height: 20)
                HStack {
                    Spacer()
                        .frame(width: 20)
                    VStack {
                        HStack {
                            Text("Name: ")
                            Spacer()
                            TextField(viewModel.taskLists[listIndex].tasks[taskIndex].name, text: $viewModel.taskLists[listIndex].tasks[taskIndex].name)
                        }
                        HStack {
                            Text("Due Date: ")
                            Spacer()
                            DatePicker("", selection: $viewModel.taskLists[listIndex].tasks[taskIndex].dueDate, displayedComponents: .date)
                                .datePickerStyle(DefaultDatePickerStyle())
                        }
                        HStack {
                            Text("Completion Status: ")
                            Spacer()
                                .frame(width: 20)
                            /*
                             CITATION: [6]
                             https://developer.apple.com/documentation/swiftui/toggle
                             */
                            Toggle("Done?", isOn: $viewModel.taskLists[listIndex].tasks[taskIndex].completed)
                            Spacer()
                        }
                        HStack {
                            Text("List: ")
                            Spacer()
                            Menu("Select an Option") {
                                ForEach (viewModel.taskLists) { list in
                                    Button(list.title) {
                                        for i in 0..<viewModel.taskLists.count {
                                            if viewModel.taskLists[i].id == list.id {
                                                viewModel.taskLists[i].tasks.append(viewModel.taskLists[listIndex].tasks[taskIndex])
                                                viewModel.taskLists[listIndex].tasks.remove(at: taskIndex)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Spacer()
                        .frame(width: 20)
                }
                Spacer()
                    .frame(height: 20)
                HStack {
                    Button(action: {
                        viewModel.editMenuNeeded = false
                    }, label: {
                        Text("Save")
                    })
                    Spacer()
                        .frame(width: 20)
                    Button(action: {
                        viewModel.editMenuNeeded = false
                        for i in 0..<viewModel.taskLists.count {
                            for j in 0..<viewModel.taskLists[i].tasks.count {
                                if taskID == viewModel.taskLists[i].tasks[j].id {
                                    viewModel.taskLists[i].tasks.remove(at: j)
                                    break
                                }
                            }
                        }
                    }, label: {
                        Text("Delete")
                            .foregroundColor(.red)
                    })
                }
            }
        }
    }
}
//
//struct EditTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditTaskView()
//    }
//}
