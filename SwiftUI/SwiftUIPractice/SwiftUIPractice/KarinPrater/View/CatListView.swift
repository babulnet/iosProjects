//
//  CatListView.swift
//  SwiftUIPractice
//
//  Created by Babul Raj on 28/05/22.
//

import SwiftUI

struct CatListView: View {
    @ObservedObject var presenter: CatPresenter
    @State var searchText: String = ""
    
    var filteredBreeds: [Breed] {
        if searchText.isEmpty {
            return self.presenter.breeds
        } else {
            let arr = self.presenter.breeds.filter { item in
                item.name.contains(searchText)
            }
            
            return arr
        }
    }
   
    var body: some View {
        NavigationView {
            
            List(filteredBreeds) { breed in
                NavigationLink(destination: CatDetailsView(breed: breed)) {
                    CatListRowView(breed: breed)
                }
            }.navigationTitle("Select your Breed")
                .searchable(text: $searchText)
        }
    }
}

struct CatListView_Previews: PreviewProvider {
    static var previews: some View {
        CatListView(presenter: CatPresenter.getSuccessState())
    }
}
