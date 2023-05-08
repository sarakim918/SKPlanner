//
//  CalendarView.swift
//  SK Planner
//
//  Created by Sara Kim on 4/13/23.
//

import SwiftUI

/*
 CITATION: [1]
 https://developer.apple.com/documentation/foundation/calendar
 */


struct CalendarView: View {
    
    @ObservedObject var viewModel: ViewModel
    @State var selectedDate: Date = Date()
    var selectedDateToday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(selectedDate)
    }
    let calendar = Calendar.current
    
    // main body
    var body: some View {
        HSplitView {
            dayBody
                .frame(minWidth: 200, minHeight: 300)
            calendarBody
                .frame(minWidth: 270, minHeight: 200)
        }
    }
    
    // MARK: -- calendar view body
    var calendarBody: some View {
        VStack {
            // Month Heading and buttons
            HStack {
                Text(getMonthString())
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    selectedDate = Date.now
                }) {
                    Text("Today")
                }
                Button(action: {
                    selectedDate = calendar.date(byAdding: .month, value: -1, to: selectedDate)!
                }) {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 12))
                }
                Button(action: {
                    selectedDate = calendar.date(byAdding: .month, value: 1, to: selectedDate)!
                }) {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 12))
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            Divider()
            
            // calendar grid
            VStack(spacing: 5) {
                // day names
                HStack(spacing: 10) {
                    ForEach(0..<7) { i in
                        ZStack {
                            Circle()
                                .foregroundColor(.clear)
                            Text(getDayOfWeekString(i))
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                // fill weeks with days
                /*
                 CITATION: [4]
                 https://www.hackingwithswift.com/quick-start/swiftui/how-to-fix-initializer-init-rowcontent-requires-that-sometype-conform-to-identifiable
                 added the id: \.self to fix identifiable issue
                 */
                ForEach(getDayMatrix(), id: \.self) { week in
                    HStack(spacing: 10) {
                        ForEach(week, id: \.self) { day in
                            Button(action: {
                                selectedDate = day.date
                            }) {
                                ZStack {
                                    /*
                                     CITATION: [5]
                                     https://stackoverflow.com/questions/24577087/comparing-nsdates-without-time-component
                                     compare dates without time component (was giving me a bug)
                                     */
                                    Circle()
                                        .foregroundColor((calendar.compare(day.date, to: selectedDate, toGranularity: .day) == .orderedSame && day.number != 0) ? .white : .clear)
                                    if (day.number != 0) {
                                        Text(String(day.number))
                                            .foregroundColor(day.today ? .green : .primary)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
            .padding(.top, 20)
            .padding(.bottom, 20)
            .padding(.horizontal, 20)
        }
    }

    // MARK: --Functions for calendarBody
    // day data type declaration
    struct Day: Hashable {
        let number: Int
        let date: Date
        
        var today: Bool {
            let calendar = Calendar.current
            return calendar.isDateInToday(date)
        }
    }
    
    // Format Month for header
    func getMonthString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: selectedDate)
    }

    // Format days of week for column names
    func getDayOfWeekString(_ index: Int) -> String {
        switch (index) {
        case 0:
            return "Sun"
        case 1:
            return "Mon"
        case 2:
            return "Tue"
        case 3:
            return "Wed"
        case 4:
            return "Thu"
        case 5:
            return "Fri"
        case 6:
            return "Sat"
        default:
            return "?"
        }
    }

    // returns a 2D array of Days in the month
    func getDayMatrix() -> [[Day]] {
        
        let firstDayOfMonth = calendar.date(from: DateComponents(year: calendar.component(.year, from: selectedDate), month: calendar.component(.month, from: selectedDate), day: 1))!
        let lastDayOfMonth = calendar.date(byAdding: .month, value: 1, to: firstDayOfMonth)!
        let daysInMonth = calendar.dateComponents([.day], from: firstDayOfMonth, to: lastDayOfMonth).day!
        let offset = (calendar.component(.weekday, from: firstDayOfMonth) - 1) % 7
        
        var days: [[Day]] = []
        var row: [Day] = []
        
        print(firstDayOfMonth)
        
        for i in 0..<42 {
            if (i < offset) {
                row.append(Day(number: 0, date: firstDayOfMonth))
            } else if (i < offset + daysInMonth) {
                let date = calendar.date(byAdding: .day, value: i - offset, to: firstDayOfMonth)!
                row.append(Day(number: i - offset + 1, date: date))
                if row.count == 7 {
                    days.append(row)
                    row = []
                }
            } else {
                row.append(Day(number: 0, date: firstDayOfMonth))
                if row.count == 7 {
                    days.append(row)
                    row = []
                }
            }
        }
        return days
    }
    
    
    
    
    
    // MARK: --day view body
    var dayBody: some View {
        VStack {
            HStack {
                Spacer()
                    .frame(width: 15)
                Button(action: {
                    selectedDate = calendar.date(byAdding: .day, value: -1, to: selectedDate)!
                }) {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 12))
                }
                Spacer()
                VStack {
                    Text(selectedDateToday ? "TODAY" : getDayString())
                        .foregroundColor(.black)
                        .bold()
                    Text(getWeekdayString())
                        .foregroundColor(.gray)
                }
                Spacer()
                Button(action: {
                    selectedDate = calendar.date(byAdding: .day, value: 1, to: selectedDate)!
                }) {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 12))
                }
                Spacer()
                    .frame(width: 15)
            }
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
                                if (task.dueDate.formatted(.dateTime.weekday().day().month().year()) == selectedDate.formatted(.dateTime.weekday().day().month().year())) {
                                    CheckableTask(task: task)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: --Functions for dayBody
    // returns boolean indicating if there are no tasks in ANY of the lists
    private func noTasks() -> Bool {
        for taskList in viewModel.taskLists {
            for temp_task in taskList.tasks {
                if (temp_task.dueDate.formatted(.dateTime.weekday().day().month().year()) == selectedDate.formatted(.dateTime.weekday().day().month().year())) {
                    return false
                }
            }
        }
        return true
    }
    
    // returns boolean indicating if there are no tasks in a given list
    private func tasksInTaskList(tasks: [Task]) -> Bool {
        for task in tasks {
            if (task.dueDate.formatted(.dateTime.weekday().day().month().year()) == selectedDate.formatted(.dateTime.weekday().day().month().year())) {
                return true
            }
        }
        return false
    }
    
    // date formatter for the day
    private func getDayString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: selectedDate)
    }
    
    // date formatter for the weekday
    private func getWeekdayString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: selectedDate)
    }

}


//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView()
//    }
//}

