//
//  CatRowView.swift
//  SwiftUI-SC
//
//  Created by Babul Raj on 20/03/22.
//

import SwiftUI

struct CatRowView: View {
    var breed: Breed
    
    var body: some View {
        HStack(spacing: 5) {
            if let image = breed.image, let string = image.url, let url = URL(string: string) {
                AsyncImage.init(url: url) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width:100,height:100)
                        .clipped()

                } placeholder: {
                    ProgressView().frame(width: 100, height: 100)
                }

            } else {
                Color.green.frame(width: 100, height: 100)
            }
            
            VStack(alignment: .leading) {
                Text(breed.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                Text(breed.breedExplaination)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .lineLimit(3)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct CatRowView_Previews: PreviewProvider {
    static var previews: some View {
        CatRowView(breed: BreedFetcher.getSampleBreed())
    }
}
