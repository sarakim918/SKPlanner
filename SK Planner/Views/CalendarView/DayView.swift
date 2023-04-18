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
            List {
                ForEach (viewModel.taskLists) { taskList in
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

//struct DayView_Previews: PreviewProvider {
//    static var previews: some View {
//        DayView()
//    }
//}
