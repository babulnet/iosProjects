//
//  ContentView.swift
//  SwiftUIlESSONSwITHniTHIN
//
//  Created by Babul Raj on 07/06/22.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var condition1 = true
}

struct SomeRandomStuff: Identifiable {
    var id = UUID()
    var rollNumber: Int
}

class RandomStuffProvider {
    static func randomStuffs() -> [SomeRandomStuff] {
        return [SomeRandomStuff(rollNumber: 1),SomeRandomStuff(rollNumber: 2),SomeRandomStuff(rollNumber: 3),SomeRandomStuff(rollNumber: 4)]
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State var showAlert = false
    @State var alertItem: SomeRandomStuff?
    @State var answer:Int = 0
    
    let gridItem = GridItem(.fixed(300))
    let gridItem1 = GridItem(.fixed(300))
    let gridItem2 = GridItem(.fixed(100))
    let gridItemFlexi = GridItem(.adaptive(minimum: 200))
    let layout = [GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        if viewModel.condition1 {
            VStack {
                Text("Helooo = \(answer)")
                Button("Click") {
                    
                }
            }
            
        } else {
            VStack {
                GridView
            }
        }
    }
    
    var GridView: some View {
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach (0..<90) { i in
                    VStack {
                        Capsule()
                            .frame(width: 120, height: 100)
                            .foregroundColor(.yellow)
                            .background(.red)
                        Text("capsule \(i)")
                        Button("tAP") {
                            alertItem = SomeRandomStuff(rollNumber: i)
                        }
                    }.alert(item: $alertItem) { item in
                        Alert(title: Text("Helooo \(item.rollNumber)"))
                    }
                }
            }
        }
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
                .previewDevice("iPhone 12 Pro Max")
         
    }
}
