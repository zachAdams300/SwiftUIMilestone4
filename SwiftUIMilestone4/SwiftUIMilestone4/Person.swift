//
//  Person.swift
//  SwiftUIMilestone4
//
//  Created by Zachary Adams on 1/25/24.
//

import Foundation
import UIKit

struct Person: Codable, Comparable, Identifiable, Hashable {
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.lastName < rhs.firstName
    }
    
    var id: UUID
    var imageData: Data
    var firstName: String
    var lastName: String
    
    var image: UIImage {
        return UIImage(data: imageData) ?? UIImage(systemName: "photo.badge.plus")!
    }
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    #if DEBUG
    static let example = Person(id: UUID(), imageData: UIImage(systemName: "photo.badge.plus")!.jpegData(compressionQuality: 1)!
, firstName: "Bob", lastName: "Test")
    #endif
    
}
