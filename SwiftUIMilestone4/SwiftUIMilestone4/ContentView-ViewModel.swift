//
//  ContentView-ViewModel.swift
//  SwiftUIMilestone4
//
//  Created by Zachary Adams on 1/25/24.
//

import SwiftUI
import PhotosUI

extension ContentView {
    @Observable
    class ViewModel {
        var selectedItem: PhotosPickerItem?
        var personToAdd: Person?
        private(set) var personList: [Person]
        
        private let savePath = URL.documentsDirectory.appending(path: "SavedItems")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                personList = try JSONDecoder().decode([Person].self, from: data)
            }catch {
                personList = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(personList)
                try data.write(to: savePath, options: [.atomic])
            }catch {
                print("Error saving data")
            }
        }
        
        func addPerson(_ person: Person) {
            if let savedPersonIndex = personList.firstIndex(where: { personInArray in
                person.id == personInArray.id
            }) {
                personList[savedPersonIndex] = person
            }else {
                personList.append(person)
            }
            
            save()
        }
        
        func getPhotoFromSelectedItem() async {
            do {
                guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
                selectedItem = nil
                personToAdd = Person(id: UUID(), imageData: imageData, firstName: "", lastName: "")
            }catch {
                
            }
        }
    }
}
