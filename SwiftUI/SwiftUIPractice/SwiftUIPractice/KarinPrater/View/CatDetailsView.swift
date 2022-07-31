//
//  CatDetailsView.swift
//  SwiftUIPractice
//
//  Created by Babul Raj on 29/05/22.
//

import SwiftUI

struct CatDetailsView: View {
    var breed: Breed
    var body: some View {
        VStack {
            if let image = breed.image, let url = URL(string: image.url ?? "") {
                AsyncImage.init(url: url) { image in
                    image.resizable()
                    .scaledToFit()
                   .frame(height: 300)
                   .clipped()
                } placeholder: {
                    ProgressView()
                }
            }
           
            VStack(alignment: .leading, spacing: 5) {
                Text(breed.name)
                    .bold()
                    .font(.title3)
                    .padding(.vertical,5)
                Text(breed.temperament)
                    .font(.subheadline)
                    .padding(.vertical,10)
                Text(breed.breedExplaination)
                    .font(.body)
                
                HStack {
                    Text("Energey Level")
                        .font(.body)
                    Spacer()
                    ForEach (1..<6)  { item in
                        let colour: Color = item < breed.energyLevel ? .blue:.gray
                        Image(systemName: "star.fill")
                            .foregroundColor(colour)
                    }
                }.padding(.vertical,15)
            }.padding(.horizontal,10)
        }
        
        Spacer()
    }
}

struct CatDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CatDetailsView(breed: CatPresenter.getSuccessState().breeds.first!)
    }
}
