//
//  CheckableTask.swift
//  SK Planner
//
//  Created by Sara Kim on 5/7/23.
//

import SwiftUI

struct CheckableTask: View {
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
        if (taskIndex != -1) {
            HStack {
                Button(action: {
                    if (viewModel.taskLists[listIndex].tasks[taskIndex].completed) {
                        viewModel.taskLists[listIndex].tasks[taskIndex].completed = false
                    } else {
                        viewModel.taskLists[listIndex].tasks[taskIndex].completed = true
                    }
                }, label: {
                    if (viewModel.taskLists[listIndex].tasks[taskIndex].completed) {
                        Image(systemName: "checkmark.square.fill")
                            .font(.system(size: 12))
                    } else {
                        Image(systemName: "square")
                            .font(.system(size: 12))
                    }
                })
                .buttonStyle(PlainButtonStyle())
                Text(viewModel.taskLists[listIndex].tasks[taskIndex].name)
                    .foregroundColor(viewModel.taskLists[listIndex].tasks[taskIndex].completed ? .gray : .black)
                    .strikethrough(viewModel.taskLists[listIndex].tasks[taskIndex].completed, color: .gray)
            }
        }
    }
}

//struct CheckableTask_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckableTask()
//    }
//}
