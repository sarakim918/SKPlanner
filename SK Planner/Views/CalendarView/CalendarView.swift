//
//  CalendarView.swift
//  SK Planner
//
//  Created by Sara Kim on 4/13/23.
//

import SwiftUI

struct CalendarView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var date: Date = .now {
        didSet {
            print("date was set in calendarView")
        }
    }
    
    var body: some View {
        HSplitView {
            DayView(viewModel: viewModel, date: date)
                .frame(minWidth: 200, minHeight: 300)
            DatePicker("Calendar", selection: $date,
                       displayedComponents: [.date])
            .datePickerStyle(GraphicalDatePickerStyle())
            .labelsHidden()
            .frame(minWidth: 400, minHeight: 300, alignment: .center)
        }
    }
}

//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView()
//    }
//}
