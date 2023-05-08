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
            VStack {
                List {
                    ForEach(viewModel.taskLists) { taskList in
                        NavigationLink {
                            TaskListView(taskList: taskList, viewModel: viewModel)
                        } label: {
                            Text(taskList.title)
                        }
                        .listRowBackground(taskList.color)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        Button(action: toggleSidebar, label: { // 1
                            Image(systemName: "sidebar.leading")
                        })
                    }
                }
                Button(action: addList, label: { // 1
                    Image(systemName: "plus.app")
                })
                .frame(maxHeight: 30)
            }
        }
        .toolbarBackground(Color.gray, for: .windowToolbar)
        
    }
    
    func toggleSidebar() { NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
    
    func addList() {
        let temp: TaskList = TaskList(title: "Another List", tasks: [], color: viewModel.colors[viewModel.color_index])
        viewModel.color_index += 1
        viewModel.taskLists.append(temp)
    }
}

//struct ListsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListsView(items: ["stuffs", "stuffs2"])
//    }
//}
