//
//  EditView-ViewModel.swift
//  SwiftUIMilestone4
//
//  Created by Zachary Adams on 1/25/24.
//

import Foundation

extension EditView {
    @Observable
    class ViewModel {
        var person: Person
        
        init(person: Person) {
            self.person = person
        }
    }
}
