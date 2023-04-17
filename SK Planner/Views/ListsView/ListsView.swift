//
//  ListsView.swift
//  SK Planner
//
//  Created by Sara Kim on 4/13/23.
//

import SwiftUI

struct ListsView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.taskLists) { taskList in
                    NavigationLink {
                        TaskListView(taskList: taskList)
                    } label: {
                        Text(taskList.title)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button(action: toggleSidebar, label: { // 1
                        Image(systemName: "sidebar.leading")
                    })
                }
            }
        }
    }
    
    func toggleSidebar() { NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}

//struct ListsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListsView(items: ["stuffs", "stuffs2"])
//    }
//}
