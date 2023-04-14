//
//  MonthView.swift
//  SK Planner
//
//  Created by Sara Kim on 4/13/23.
//

import SwiftUI

struct MonthView: View {
    @State private var date: Date = .now {
        didSet {
            print("Whore 2")
        }
    }
    @State private var refresh = false
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        DatePicker((refresh ? "" : " "), selection: $date,
                   displayedComponents: [.date])
        .datePickerStyle(GraphicalDatePickerStyle())
        .labelsHidden()
        .frame(minWidth: 400, minHeight: 300, alignment: .center)
    }
}

//struct MonthView_Previews: PreviewProvider {
//    static var previews: some View {
//        MonthView()
//    }
//}
