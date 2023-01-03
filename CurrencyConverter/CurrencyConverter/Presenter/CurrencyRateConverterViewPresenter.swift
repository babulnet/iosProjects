//
//  CurrencyRateConverterViewPresenter.swift
//  CurrencyConverter
//
//  Created by Babul Raj on 29/12/22.
//

import Foundation
import Combine
import SwiftUI

class CurrencyRateConverterViewPresenter: ObservableObject, ConverterViewDataProvider {
    
    @Published var convertItemModel: ConverterViewModel = ConverterViewModel(title: "Select a currency to convert", subTitle: "Amount", itemsToConvert: [], convertedResult: [])
    @Published var isLoading = false
    var interactor: CurrencyConverterInteractorProtocol = CurrencyConverterInteractor()

    private var anyCancellables:[AnyCancellable] = []
    private  var currencyModel:CurrencyModel?
    private var currencyDic:[String:String] = [:]
    
    func start() {
        self.getCountriesList { result in
            switch result {
            case true:
                self.getData()
            case false:
                self.isLoading = false
                print("error")
            }
        }
    }
    
    func convert(value: String?, amount: String)  {
        guard let value = value,let currency = getCurrencyCode(string: value), let currencyModel = currencyModel, let rate = currencyModel.rates[currency] else {return}
        currencyModel.rates.forEach({ item in
            self.currencyModel?.rates[item.key] = (item.value/rate) * (Double(amount) ?? 1.0)
        })
        
        self.convertItemModel.convertedResult = self.currencyModel?.rates.map {"\($0)  - \(String(format: "%0.1f", $1))"}.sorted(by: <) ?? []
    }
    
    private func getData() {
        interactor.getCurrencyRate(for: "") { result in
            switch result {
            case .success(let model):
                self.currencyModel = model
                DispatchQueue.main.async {
                    self.convertItemModel.convertedResult = model.rates.map {"\($0)  - \($1)"}
                }
                print(model.base)
            case .failure(let error):
                print(error)
            }
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
    
    private func getCountriesList(_ completion:((Bool)->())? = nil) {
        interactor.getCountriesList(completion: { result in
            switch result {
            case .success(let dict):
                DispatchQueue.main.async {
                    self.convertItemModel.itemsToConvert = dict.map { "\($0) - \($1)" }.sorted()
                    completion?(true)
                }
            case .failure(let error):
                completion?(false)
                print(error)
            }
        })
    }
    
    private func getCurrencyCode(string: String) -> String? {
        return string.components(separatedBy: "-").first?.trimmingCharacters(in: .whitespaces)
    }
}
