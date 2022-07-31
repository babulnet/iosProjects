//
//  CatList.swift
//  SwiftUI-SC
//
//  Created by Babul Raj on 19/03/22.
//

import SwiftUI

struct CatListRow: View {
    @State var searchText: String = ""
    @ObservedObject var breedFetcher: BreedFetcher
    
    var filterdBreedArray: [Breed] {
        if searchText.isEmpty {
            return breedFetcher.breeds
        } else {
            return breedFetcher.breeds.filter { breed in
                breed.name.contains(searchText)
            }
        }
    }
   
    var body: some View {
        NavigationView {
            List(filterdBreedArray) { breed in
                NavigationLink {
                    CatDetailsView(breed: breed)
                } label: {
                    CatRowView(breed: breed)
                }
            }.listStyle(.plain)
            .navigationTitle("My Cat List")
            .toolbar {
                Button {
                    breedFetcher.getData()
                } label: {
                    Text("Reload")
                }
            }
        }.searchable(text: $searchText)
    }
}

struct CatListRow_Previews: PreviewProvider {
    static var previews: some View {
        CatListRow(breedFetcher: BreedFetcher())
            .previewDevice("iPhone 11 Pro")
    }
}
