//
//  ContentView.swift
//  SwiftUI-SC
//
//  Created by Babul Raj on 18/03/22.
//

import SwiftUI

struct ContentView: View {
    
    let modelList = ModelList.modelList
   
    var body: some View {
        
        NavigationView {
            List (modelList, id: \.id) { item in
                NavigationLink {
                    DetailView(model: item)
                } label: {
                    HStack {
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 90)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            Text(item.title)
                                .font(.headline)
                                .fontWeight(.medium)
                            Text(item.sellPrice)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(.green)
                        }
                    }
                    
                }.navigationTitle("Mock Test").font(.subheadline)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
