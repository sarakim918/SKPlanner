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
    let calendar = Calendar.current
    
    // main body
    var body: some View {
        HSplitView {
            DayView(viewModel: viewModel, date: selectedDate)
                .frame(minWidth: 200, minHeight: 300)
            calendarBody
                .frame(minWidth: 270, minHeight: 200)
        }
    }
    
    // calendar
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
                    Image(systemName: "chevron.left")
                        .font(.system(size: 12))
                }
                Button(action: {
                    selectedDate = calendar.date(byAdding: .month, value: 1, to: selectedDate)!
                }) {
                    Image(systemName: "chevron.right")
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
                ForEach(getDayMatrix(), id: \.self) { week in
                    HStack(spacing: 10) {
                        ForEach(week, id: \.self) { day in
                            Button(action: {
                                selectedDate = day.date
                            }) {
                                ZStack {
                                    Circle()
                                        .foregroundColor((day.date == selectedDate && day.number != 0) ? .white : .clear)
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
        
        let startDate = calendar.date(from: DateComponents(year: calendar.component(.year, from: selectedDate), month: calendar.component(.month, from: selectedDate), day: 1))!
        let endDate = calendar.date(byAdding: .month, value: 1, to: startDate)!
        let numberOfDays = calendar.dateComponents([.day], from: startDate, to: endDate).day!
        let firstWeekdayOfMonth = calendar.component(.weekday, from: startDate)
        let offset = (firstWeekdayOfMonth - 1) % 7
        
        var days: [[Day]] = []
        var row: [Day] = []
        
        for i in 0..<42 {
            if (i < offset) {
                row.append(Day(number: 0, date: startDate))
            } else if (i < offset + numberOfDays) {
                let date = calendar.date(byAdding: .day, value: i - offset, to: startDate)!
                row.append(Day(number: i - offset + 1, date: date))
                if row.count == 7 {
                    days.append(row)
                    row = []
                }
            } else {
                row.append(Day(number: 0, date: startDate))
                if row.count == 7 {
                    days.append(row)
                    row = []
                }
            }
        }
        return days
    }

}



struct Day: Hashable {
    let number: Int
    let date: Date
    
    var today: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(date)
    }
    
}


//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView()
//    }
//}

