//
//  ErrorView.swift
//  SwiftUI-SC
//
//  Created by Babul Raj on 20/03/22.
//

import SwiftUI

struct ErrorView: View {
    @ObservedObject var breedFetcher: BreedFetcher
   
    var body: some View {
        VStack {
            Text("😿").font(.system(size: 80))
            Text(breedFetcher.errorMessage ?? "").font(.subheadline)
            Button {
                breedFetcher.getData()
            } label: {
                Text("Try again")
            }

        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(breedFetcher: BreedFetcher())
    }
}
