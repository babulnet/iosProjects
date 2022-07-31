//
//  Presenter.swift
//  SwiftUIPractice
//
//  Created by Babul Raj on 29/05/22.
//

import Foundation

class CatPresenter: ObservableObject {
    let url = "https://api.thecatapi.com/v1/breeds"
    var interactor: InteractorProtocol = Interactor()
    @Published var breeds: [Breed] = []
    @Published var error: ApiError?
    @Published var isLoading: Bool = false
    
    func getBreeds() {
        isLoading = true
        self.error = nil
        Interactor().fetchModel(url: url) { [weak self] (result: Result<[Breed],ApiError>) in
            self?.isLoading = false
          
            switch result {
            case .success(let breeds):
                self?.breeds = breeds
            case .failure(let error):
                self?.error = error
            }
        }
     }
    
    static func getSuccessState() -> CatPresenter {
        let pre = CatPresenter()
        pre.breeds = [Breed.example1(),Breed.example2()]
        return pre
    }
    
    static func getErrorState() -> CatPresenter {
        let pre = CatPresenter()
        pre.error = ApiError.badResponse(statusCode: 300)
        return pre
    }
}
