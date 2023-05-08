//
//  CheckableTask.swift
//  SK Planner
//
//  Created by Sara Kim on 5/7/23.
//

import SwiftUI

struct CheckableTask: View {
    @State var task: Task
    
    var body: some View {
        HStack {
            Divider()
            Button(action: {
                if (task.completed) {
                    task.completed = false
                } else {
                    task.completed = true
                }
            }, label: {
                if (task.completed) {
                    Image(systemName: "checkmark.square.fill")
                        .font(.system(size: 12))
                } else {
                    Image(systemName: "square")
                        .font(.system(size: 12))
                }
            })
            .buttonStyle(PlainButtonStyle())
            Text(task.name)
                .foregroundColor(task.completed ? .gray : .black)
                .strikethrough(task.completed, color: .gray)
        }
    }
}

//struct CheckableTask_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckableTask()
//    }
//}
