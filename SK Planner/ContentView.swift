//
//  ContentView.swift
//  SK Planner
//
//  Created by Sara Kim on 4/12/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            ListsView(viewModel: viewModel)
                .frame(minWidth: 600, minHeight: 200)
            CalendarView(viewModel: viewModel)
                .frame(minWidth: 600, minHeight: 300)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
