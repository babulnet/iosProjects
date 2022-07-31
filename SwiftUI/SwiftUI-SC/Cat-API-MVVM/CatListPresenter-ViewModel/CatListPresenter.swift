//
//  CatListPresenter.swift
//  SwiftUI-SC
//
//  Created by Babul Raj on 20/03/22.
//

import Foundation

class BreedFetcher: ObservableObject {
    @Published var breeds: [Breed] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
   
    var service: APIServiceProtocol
    
    init(service: APIServiceProtocol = APIService()) {
        self.service = service
        self.getData()
    }
    
    let url = URL(string: "https://api.thecatapi.com/v1/breeds")
   
    func getData() {
        self.isLoading = true
        self.errorMessage = nil
        service.fetchBreed(url: url, completion: { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let breeds):
                    self.breeds = breeds
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        })
    }
    
        // Mocks for preview
    
    static func getSampleBreeds() -> [Breed] {
        return [Breed.example1(),Breed.example2()]
    }
    
    static func getSampleBreed() -> Breed {
        return Breed.example1()
    }
}
