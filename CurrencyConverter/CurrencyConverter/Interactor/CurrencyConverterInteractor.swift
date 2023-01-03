//
//  CurrencyConverteractor.swift
//  CurrencyConverter
//
//  Created by Babul Raj on 29/12/22.
//

import Foundation
import Combine
// https://openexchangerates.org/api/latest.json?app_id=37e60c4ce41f454dbce1efe06609d8e8&base=USD&symbols=INR%252CGBP&prettyprint=false&show_alternative=false' \

//https://openexchangerates.org/api/latest.json?app_id=37e60c4ce41f454dbce1efe06609d8e8&base=usd&prettyprint=false&show_alternative=false

//https://openexchangerates.org/api/currencies.json?prettyprint=false&show_alternative=false&show_inactive=false&app_id=37e60c4ce41f454dbce1efe06609d8e8
struct CurrencyRateNetworkModel: Codable {
    var base: String
    var timestamp: Double
    var rates = [String:Double]()
}

//"https://api.exchangerate.host/latest?base=USD&amount=1000
class CurrencyConverterInteractor {
 
    let url = "https://openexchangerates.org/api/"
    let appId = "37e60c4ce41f454dbce1efe06609d8e8"
    var urlSession = URLSession.shared
    var base:String
    var amount:Double
    private var timer = Timer.publish(every: 1800, on: RunLoop.main, in: .common).autoconnect()
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
    
    private func fetchCurrencyRate(completion: ((Bool) -> ())? = nil) {
        self.getCurrencyRate(for: self.base, amount: self.amount)
            .receive(on: RunLoop.main)
            .sink { error in
                print(error)
            } receiveValue: { model in
                print(model)
                self.storage.saveData(response: model)
                completion?(true)
            }.store(in: &self.anyCancellables)
    }
  
    private func getCurrencyRate(for currency:String, amount: Double) -> Future<CurrencyRateNetworkModel,Error> {
   // https://openexchangerates.org/api/latest.json?app_id=37e60c4ce41f454dbce1efe06609d8e8&base=usd&prettyprint=false&show_alternative=false
        return Future { [weak self] promise in
            let urlString = (self?.url ?? "") + "latest.json?" + "app_id=\(self?.appId ?? "")&base=\(currency)&amount=\(amount)"
            guard let url = URL(string: urlString) else {
                return promise(.failure(ApiError.badURL))
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error as? URLError {
                    let urlError = ApiError.url(error)
                    return promise(.failure(urlError))
                } else if let response = response as? HTTPURLResponse,!(200...299).contains(response.statusCode) {
                    promise(.failure(ApiError.badResponse(statusCode: response.statusCode)))
                } else if let data = data {
                    do {
                        let response = try JSONDecoder().decode(CurrencyRateNetworkModel.self, from: data)
                        //if let data = self?.transform(networkResponse: response) {
                            promise(.success(response))
                        //}
                    } catch {
                        let error =  ApiError.parsing(error as? DecodingError)
                        return promise(.failure(error))
                    }
                }
            }.resume()
        }
    }
    
    private func transform(_ response: CurrencyRateNetworkModel) -> CurrencyModel {
        return CurrencyModel(base: response.base, timestamp: response.timestamp,rates: response.rates)
    }
}

extension CurrencyConverterInteractor: CurrencyConverterInteractorProtocol {
    func getCountriesList(completion:@escaping (Result<[String:String],Error>) -> ()) {
        // https://openexchangerates.org/api/currencies.json?prettyprint=false&show_alternative=false&show_inactive=false&app_id=37e60c4ce41f454dbce1efe06609d8e8
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
    
    func getCurrencyRate(for currency: String, completion:@escaping (Result<CurrencyModel,Error>) -> ()) {
        if case .success(let model) = storage.getCurrencyRate(for: base, amount: amount) {
            completion(.success(transform(model)))
        } else {
            fetchCurrencyRate { _ in
                if case .success(let model) = self.storage.getCurrencyRate(for: currency, amount: self.amount) {
                    completion(.success(self.transform(model)))
                } else {
                    completion(.failure(StorageError.storageError))
                }
            }
        }
     }
}
