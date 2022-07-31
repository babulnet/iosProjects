//
//  ErrorView.swift
//  SwiftUIPractice
//
//  Created by Babul Raj on 29/05/22.
//

import SwiftUI

struct ErrorView: View {
    var breedPresenter: CatPresenter
    
    var body: some View {
        Text(breedPresenter.error?.description ?? "")
       
        Button("Reload") {
            breedPresenter.getBreeds()
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(breedPresenter: CatPresenter.getErrorState())
    }
}
