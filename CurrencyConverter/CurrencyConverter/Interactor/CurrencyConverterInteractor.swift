//
//  CurrencyConverteractor.swift
//  CurrencyConverter
//
//  Created by Babul Raj on 29/12/22.
//

import Foundation
import Combine

struct CurrencyRateNetworkModel: Codable {
    var base: String
    var timestamp: Double
    var rates = [String:Double]()
}

class CurrencyConverterInteractor {
 
    let url = "https://openexchangerates.org/api/"
    let appId = "37e60c4ce41f454dbce1efe06609d8e8"
    var urlSession = URLSession.shared
    var base:String
    var amount:Double
    private var timer = Timer.publish(every: 10, on: RunLoop.main, in: .common).autoconnect()
    private var anyCancellables:[AnyCancellable] = []
    var storage:LocalStorageProtocol = LocalStorage()
   
    init(base: String = "USD",amount: Double = 1) {
        self.base = base
        self.amount = amount
        self.startTimer()
    }
    
    private func startTimer() {
        timer.sink { error in
            print(error)
        } receiveValue: { _ in
            self.fetchCurrencyRate()
        }
        .store(in: &anyCancellables)
    }
    
    private func fetchCurrencyRate(completion: ((Result<Bool,Error>) -> ())? = nil) {
        self.getCurrencyRate(for: base, amount: amount, completion: { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.storage.saveData(response: model)
                    completion?(.success(true))
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        })
    }
  
    private func getCurrencyRate(for currency:String, amount: Double, completion: @escaping (Result<CurrencyRateNetworkModel,Error>) -> ()) {
   // https://openexchangerates.org/api/latest.json?app_id=37e60c4ce41f454dbce1efe06609d8e8&base=usd&prettyprint=false&show_alternative=false
            let urlString = (self.url) + "latest.json?" + "app_id=\(self.appId)&base=\(currency)&amount=\(amount)"
            guard let url = URL(string: urlString) else {
                completion(.failure(ApiError.badURL))
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error as? URLError {
                    let urlError = ApiError.url(error)
                    completion(.failure(urlError))
                    return
                } else if let response = response as? HTTPURLResponse,!(200...299).contains(response.statusCode) {
                    completion(.failure(ApiError.badResponse(statusCode: response.statusCode)))
                } else if let data = data {
                    do {
                        let response = try JSONDecoder().decode(CurrencyRateNetworkModel.self, from: data)
                        //if let data = self?.transform(networkResponse: response) {
                        completion(.success(response))
                        //}
                    } catch {
                        let error =  ApiError.parsing(error as? DecodingError)
                        completion(.failure(error))
                    }
                }
            }.resume()
    }
    
    private func transform(_ response: CurrencyRateNetworkModel) -> CurrencyModel {
        return CurrencyModel(base: response.base, timestamp: response.timestamp,rates: response.rates)
    }
}

extension CurrencyConverterInteractor: CurrencyConverterInteractorProtocol {
    func getCountriesList(completion:@escaping (Result<[String:String],Error>) -> ()) {
        let urlString = (self.url) + "currencies.json?" + "app_id=\(self.appId)"
        guard let url = URL(string: urlString) else {
            completion(.failure(ApiError.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error as? URLError {
                let urlError = ApiError.url(error)
                completion(.failure(urlError))
            } else if let response = response as? HTTPURLResponse,!(200...299).contains(response.statusCode) {
                completion(.failure(ApiError.badResponse(statusCode: response.statusCode)))
            } else if let data = data {
                do {
                    let response = try JSONDecoder().decode([String:String].self, from: data)
                    completion(.success(response))
                } catch {
                    let error =  ApiError.parsing(error as? DecodingError)
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getCurrencyRate(for currency: String, completion:@escaping (Result<CurrencyModel,Error>) -> ()) {
        if case .success(let model) = storage.getCurrencyRate(for: base, amount: amount) {
            completion(.success(transform(model)))
        } else {
            fetchCurrencyRate { _ in
                if case .success(let model) = self.storage.getCurrencyRate(for: self.base, amount: self.amount) {
                    completion(.success(self.transform(model)))
                } else {
                    completion(.failure(StorageError.storageError))
                }
            }
        }
     }
}
