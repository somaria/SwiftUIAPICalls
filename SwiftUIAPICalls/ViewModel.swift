//
//  ViewModel.swift
//  ViewModel
//
//  Created by admin on 14/8/21.
//

import Foundation
import SwiftUI


struct Course: Hashable, Codable {
  let name: String
  let image: String
}

class ViewModel: ObservableObject {
  
  @Published var courses: [Course] = []
  func fetch() {
    
    guard let url = URL(string: "https://iosacademy.io/api/v1/courses/") else { return }
    
    let task = URLSession.shared.dataTask(with: url) { data, _
      , error in
      guard let data = data, error == nil else { return }
      
      do {
        let courses = try JSONDecoder().decode([Course].self, from: data)
        
        print("course name")
        print(courses[0].name)
        
        DispatchQueue.main.async {
          self.courses = courses
        }
        
      } catch  {
        print(error)
      }
      
    }
    task.resume()
  }
}

