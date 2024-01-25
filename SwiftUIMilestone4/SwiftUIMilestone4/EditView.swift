//
//  EditView.swift
//  SwiftUIMilestone4
//
//  Created by Zachary Adams on 1/25/24.
//

import SwiftUI


struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @State private var viewModel: ViewModel
    var onSave: (Person) -> Void
    
    init(person: Person, onSave: @escaping (Person) -> Void) {
        _viewModel = State(initialValue: ViewModel(person: person))
        self.onSave = onSave
    }
    var body: some View {
        VStack {
            Form {
                Image(uiImage: viewModel.person.image)
                    .resizable()
                    .scaledToFit()
                TextField("First Name", text: $viewModel.person.firstName)
                TextField("Last Name", text: $viewModel.person.lastName)
                Button("Save") {
                    onSave(viewModel.person)
                    dismiss()
                }
            }
            .navigationTitle("\(viewModel.person.firstName) \(viewModel.person.lastName)")
        }
    }
}

#Preview {
    EditView(person: .example) { _ in
        
    }
}
