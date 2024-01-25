//
//  PersonListView.swift
//  SwiftUIMilestone4
//
//  Created by Zachary Adams on 1/25/24.
//

import SwiftUI

struct PersonListView: View {
    var person: Person
    var body: some View {
        VStack {
            Image(uiImage: person.image)
                .resizable()
                .frame(height: 100)
            
            VStack {
                Text(person.fullName)
            }
            .padding(.vertical)
            
        }
        .frame(maxWidth: .infinity)
        .clipShape(.rect(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .inset(by: 0)
                .stroke(lineWidth: 1)
        }
    }
}

#Preview {
    PersonListView(person: .example)
}
