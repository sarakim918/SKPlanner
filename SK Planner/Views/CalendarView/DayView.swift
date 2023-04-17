//
//  DayView.swift
//  SK Planner
//
//  Created by Sara Kim on 4/13/23.
//

import SwiftUI

struct DayView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text("Date: " + viewModel.date.formatted())
            Text("Today \n(default to today, \nshow the day that's highlighted on the calendar")
        }
    }
}

//struct DayView_Previews: PreviewProvider {
//    static var previews: some View {
//        DayView()
//    }
//}
