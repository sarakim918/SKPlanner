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
                            TaskListView(taskListId: taskList.id, viewModel: viewModel)
                                .frame(minWidth: 600)
                        } label: {
                            Text(taskList.title)
                        }
                        .listRowBackground(taskList.color)
                    }
                    .onMove { indices, destination in
                        viewModel.taskLists.move(fromOffsets: indices,
                                            toOffset: destination)
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
                    Image(systemName: "plus")
                })
                .frame(maxHeight: 30)
            }
        }
        .toolbarBackground(Color.gray, for: .windowToolbar)
        .onTapGesture {
            viewModel.editMenuNeeded = false
        }
        
    }
    
    func toggleSidebar() { NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
    
    func addList() {
        let temp: TaskList = TaskList(title: "NEW List", tasks: [], color: viewModel.colors[viewModel.color_index])
        viewModel.color_index += 1
        viewModel.taskLists.append(temp)
    }
}

//struct ListsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListsView(items: ["stuffs", "stuffs2"])
//    }
//}
