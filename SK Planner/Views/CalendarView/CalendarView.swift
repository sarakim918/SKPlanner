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
            print("Whore 2")
        }
    }
    
    var body: some View {
        HSplitView {
            VStack {
                if (date == Date.now) {
                    Text("TODAY")
                } else {
                    Text(date.formatted(.dateTime.weekday().day().month().year()))
                }
                
            }
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
