//
//  ContentView.swift
//  SwiftUIMilestone4
//
//  Created by Zachary Adams on 1/25/24.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    
    let columns = [GridItem(.adaptive(minimum: 150), spacing: 20)]
    var body: some View {
        NavigationStack {
            if viewModel.personList.count < 1 {
                PhotosPicker(selection: $viewModel.selectedItem) {
                    ContentUnavailableView("No People Added", systemImage: "photo.badge.plus", description: Text("Tap to import a person"))
                }
                .onChange(of: viewModel.selectedItem) {
                    Task {
                        await viewModel.getPhotoFromSelectedItem()
                    }
                }
            }else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20, content: {
                        ForEach(viewModel.personList, id: \.id) { person in
                            NavigationLink(value: person, label: {
                                PersonListView(person: person)
                            })
                            .buttonStyle(.plain)
                        }
                    })
                }
//                List(viewModel.personList, id: \.id) { person in
//                    NavigationLink(value: person,label: {
//                        Text("\(person.fullName)")
//                    }
//                )}
                .padding(.horizontal)
                .navigationTitle("Person List")
                .toolbar {
                    PhotosPicker(selection: $viewModel.selectedItem) {
                        Image(systemName: "plus")
                    }
                    .onChange(of: viewModel.selectedItem) {
                        Task {
                            await viewModel.getPhotoFromSelectedItem()
                        }
                    }
                }
                .navigationDestination(for: Person.self) { person in
                    EditView(person: person) { personToSave in
                        viewModel.addPerson(personToSave)
                    }
                }
            }
        }
        .sheet(item: $viewModel.personToAdd, content: { person in
            EditView(person: person) { personToSave in
                viewModel.addPerson(personToSave)
            }
        })
    }
}

#Preview {
    ContentView()
}
