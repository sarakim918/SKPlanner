//
//  EditMenuView.swift
//  SK Planner
//
//  Created by Sara Kim on 5/7/23.
//

import SwiftUI

struct EditListView: View {
    @State var listID: TaskList.ID
    @ObservedObject var viewModel: ViewModel
    var listIndex: Int {
        for i in 0..<viewModel.taskLists.count {
            if listID == viewModel.taskLists[i].id {
                    return i
            }
        }
        return 0
    }
    
    var body: some View {
        VStack {
            Text("Edit List")
            Divider()
                .padding(.horizontal, -8)
                .padding(.vertical, -8)
            Spacer()
                .frame(height: 20)
            HStack {
                Spacer()
                    .frame(width: 20)
                VStack {
                    HStack {
                        Text("Name: ")
                        Spacer()
                        TextField(viewModel.taskLists[listIndex].title, text: $viewModel.taskLists[listIndex].title)
                    }
                    HStack {
                        Text("Color: ")
                        Spacer()
                        Menu("Select an Option") {
                            ForEach (viewModel.colors) { color in
                                Button(action: {
                                    viewModel.taskLists[listIndex].color = color
                                }, label: {
                                    Text(viewModel.getColorString(color: color))
                                        .foregroundColor(color)
                                })
                            }
                        }
                    }
                }
                Spacer()
                    .frame(width: 20)
            }
            Spacer()
                .frame(height: 20)
            HStack {
                Button(action: {
                    viewModel.editMenuNeeded = false
                }, label: {
                    Text("Save")
                })
                Spacer()
                    .frame(width: 20)
                Button(action: {
                    viewModel.editMenuNeeded = false
                    for i in 0..<viewModel.taskLists.count {
                        if listID == viewModel.taskLists[i].id {
                            viewModel.taskLists.remove(at: i)
                            break
                        }
                    }
                }, label: {
                    Text("Delete")
                        .foregroundColor(.red)
                })
            }
        }
    }
}

//struct EditListView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditListView()
//    }
//}
