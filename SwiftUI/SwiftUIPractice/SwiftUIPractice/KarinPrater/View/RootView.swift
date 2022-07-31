//
//  RootView.swift
//  SwiftUIPractice
//
//  Created by Babul Raj on 29/05/22.
//

import SwiftUI

struct RootView: View {
    @StateObject var presenter: CatPresenter
   
    var body: some View {
        if presenter.isLoading {
            LoadingView()
        } else if  presenter.breeds.count  > 0 {
            CatListView(presenter: presenter)
        } else if let _ = self.presenter.error {
            ErrorView(breedPresenter: presenter)
        } else {
            VStack {
                Button("get cats") {
                    presenter.getBreeds()
                }.padding()
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(presenter: CatPresenter())
    }
}
