//
//  SwiftUIView.swift
//  SwiftUI-SC
//
//  Created by Babul Raj on 20/03/22.
//

import SwiftUI

struct CatRootView: View {
    @StateObject var breeder = BreedFetcher()
    
    var body: some View {
        if breeder.isLoading {
           LoadingView()
        } else if let _ = breeder.errorMessage {
            ErrorView(breedFetcher: breeder)
        } else {
            CatListRow(breedFetcher: breeder)
        }
    }
}

struct CatRootView_Previews: PreviewProvider {
    static var previews: some View {
        CatRootView()
    }
}
