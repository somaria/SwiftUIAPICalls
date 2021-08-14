//
//  ContentView.swift
//  SwiftUIAPICalls
//
//  Created by admin on 14/8/21.
//

import SwiftUI

struct URLImage: View {
  
  let urlString: String
  
  @State var data: Data?
  
  private func fetchData() {
    guard let url = URL(string: urlString) else { return }
    
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
      
      guard let data = data else { return }
      
      self.data = data
      
    }
    task.resume()
  }
  
  var body: some View {
    if let data = data, let uiImage = UIImage(data: data) {
      Image(uiImage: uiImage)
        .resizable()
        .frame(width: 130, height: 70)
        .background(Color.gray)
    } else {
      Image("")
        .resizable()
        .frame(width: 130, height: 70)
        .background(Color.gray)
        .onAppear {
          fetchData()
        }
    }
  }
}


struct ContentView: View {
  
  @StateObject var viewModel = ViewModel()
  
  var body: some View {
    NavigationView {
      List {
        ForEach(viewModel.courses, id:\.self) {course in
          HStack {
            URLImage(urlString: course.image)
          
            Text(course.name)
          }
        }
      }
      .navigationTitle("Courses")
      .onAppear {
        viewModel.fetch()
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
