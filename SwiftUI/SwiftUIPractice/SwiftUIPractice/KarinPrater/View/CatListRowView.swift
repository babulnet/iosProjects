//
//  CatListRowView.swift
//  SwiftUIPractice
//
//  Created by Babul Raj on 29/05/22.
//

import SwiftUI

struct CatListRowView: View {
    var breed: Breed
    
    var body: some View {
        HStack(spacing: 20) {
            if let image = breed.image, let url = URL(string: image.url ?? "") {
                AsyncImage.init(url: url) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .padding(.horizontal,5)
                } placeholder: {
                    ProgressView()
                }
            } else {
                Color.red
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(breed.name)
                    .bold()
                Text(breed.description)
                    .font(.subheadline)
            }
        }
    }
}

struct CatListRowView_Previews: PreviewProvider {
    static var previews: some View {
        CatListRowView(breed: CatPresenter.getSuccessState().breeds.first!)
    }
}
