//
//  ContentView.swift
//  InfiniteScroll_Operations
//
//  Created by Babul Raj on 04/11/22.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var model:[Int] = Array(0..<10)
    
    func getData(index:Int) {
        model.append(contentsOf: Array((model.count - 1)..<model.count+9))
    }
    
    func shouldLoadData(id:Int) -> Bool {
       return (model.count - 3) == id
    }
}

struct ContentView: View {
    let gridItem = GridItem(.adaptive(minimum: 300))
   @StateObject var presenter = Presenter()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [gridItem,gridItem]) {
               // for (index,item) in presenter.users.enumerated() {
                ForEach (presenter.users.indices,id:\.self) {item in
                    VStack {
                        Text("\(presenter.users[item].login)")
                            .onAppear {
                                if presenter.shouldLoadData(id: item) {
                                    presenter.getData(index: presenter.users[item].id)
                                }
                            }
                        Text("id = \(presenter.users[item].id)")
                        Text("Number = \(item)")
                        
                        if let image = presenter.users[item].image {
                            Image(uiImage: image)
                                .resizable()
                        } else if let _ = presenter.getData(index: item) {
                          ProgressView()
                        }
                        
//                        if presenter.isItTrue(index: item) {
//                            AsyncImage(url: URL(string:presenter.users[item].avatar_url)!) { image in
//                                image.resizable()
//                            } placeholder: {
//                                ProgressView()
//                            }
//                        }

                            
                    }.frame(width:200,height: 300)
                        .background(.red)
                }
            }
            .onAppear {
                presenter.getData(index: 0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



