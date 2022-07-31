//
//  Interactor.swift
//  SwiftUIPractice
//
//  Created by Babul Raj on 29/05/22.
//

import Foundation
enum ApiError: Error {
    case badURL,
    url(URLError?),
    badResponse(statusCode:Int),
    parsingError(DecodingError?),
    unknown
    
    var description: String {
        //info for debugging
        switch self {
        case .unknown: return "unknown error"
        case .badURL: return "invalid URL"
        case .url(let error):
            return error?.localizedDescription ?? "url session error"
        case .parsingError(let error):
            return "parsing error \(error?.localizedDescription ?? "")"
        case .badResponse(statusCode: let statusCode):
            return "bad response with status code \(statusCode)"
        }
    }
    
    var localizedDescription: String {
        switch self {
        case .badURL, .parsingError, .unknown:
            return "Sorry, something went wrong."
        case .badResponse(_):
            return "Sorry, the connection to our server failed."
        case .url(let error):
            return error?.localizedDescription ?? "Something went wrong."
        }
    }
}

protocol InteractorProtocol {
    func fetchBreed(url: String, completion: @escaping (Result<[Breed], ApiError>) -> ())
}

class Interactor: InteractorProtocol {
    func fetchBreed(url: String, completion: @escaping (Result<[Breed], ApiError>) -> ()) {
        
    }
    
    func fetchModel<T:Decodable>(url: String, completion: @escaping (Result<[T], ApiError>) -> ()) {
        guard let url = URL(string: url) else {
            completion(.failure(ApiError.badURL))
            return
        }
        
        let request = URLRequest(url: url)
       
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error as? URLError {
                DispatchQueue.main.async {
                    completion(.failure(ApiError.url(error)))
                }
            } else if let response = response as? HTTPURLResponse, !(200...209).contains(response.statusCode) {
                DispatchQueue.main.async {
                    completion(.failure(ApiError.badResponse(statusCode: response.statusCode)))
                }
            } else if let data = data {
                do {
                    let response = try JSONDecoder().decode([T].self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(response))
                        
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(ApiError.parsingError(error as? DecodingError)))
                    }
                }
            }
        }
        dataTask.resume()
    }
}
