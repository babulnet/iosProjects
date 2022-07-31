//
//  CatDetailsView.swift
//  SwiftUI-SC
//
//  Created by Babul Raj on 20/03/22.
//

import SwiftUI

struct CatDetailsView: View {
    var breed: Breed
    var body: some View {
        VStack {
            Text(breed.name)
        }
    }
}

struct CatDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CatDetailsView(breed: BreedFetcher.getSampleBreed())
    }
}
