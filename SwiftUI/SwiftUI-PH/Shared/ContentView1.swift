//
//  ContentView1.swift
//  SwiftUI-Lesson
//
//  Created by Babul Raj on 18/03/22.
//

import Foundation
import SwiftUI

enum LoadingState {
    case loading,success,failure
}

struct LoadingView: View {
    var body: some View {
        Text("Loading")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success")
    }
}

struct FailureView: View {
    var body: some View {
        Text("failed")
    }
}

class Presenter: ObservableObject {
   @Published var list: [Data] = []
    
    func getData() -> [Data] {
        for i in (0...100) {
            let data = Data(value: i)
            list.append(data)
        }
        
        return list
    }
}

struct Data: Identifiable {
    var id = UUID()
    var value: Int
}


struct ContentView1: View {
    var presenter: Presenter
    let arry = Array(1...100).map { item in
        return "item - \(item)"
    }
    
   // let gridItem = GridItem(.adaptive(minimum: 10, maximum: 100))
   // let layout = [GridItem(.flexible())]
    
    //let layout = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    
   // let layout = [GridItem(.adaptive(minimum: 80))]
    // fill the screenWith Stuff and only thing I care is minimum width is 80
    
    let layout = [GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(arry, id: (\.self)) {itm in
                    VStack {
                        Capsule()
                            .frame(width: 80, height: 30)
                            .foregroundColor(.blue)
                        Text("\(itm)")
                    }
                }
            }
        }
    }

   
//    var body: some View {
//        NavigationView {
//            List(arry, id: \.self) { item in
//                Text("\(item)")
//            }.navigationTitle("Numbers").font(.body)
//        }
//    }
}

struct ContentView_Previews1: PreviewProvider {
    static var previews: some View {
        ContentView1(presenter: Presenter())
    }
}
