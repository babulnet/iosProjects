//
//  APIService.swift
//  SwiftUI-SC
//
//  Created by Babul Raj on 20/03/22.
//

import Foundation
protocol APIServiceProtocol {
    func fetchBreed(url: URL?, completion: @escaping(Result<[Breed],ApiError>)->())
}

class APIService: APIServiceProtocol {
    fileprivate func handleResponse<T: Decodable> (_ error: Error?, _ response: URLResponse?, _ data: Data?, completion: @escaping(Result<T,ApiError>)->()) {
        if let error = error as? URLError {
            let urlError = ApiError.url(error)
            completion(.failure(urlError))
        } else if  let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
            completion(Result.failure(ApiError.badResponse(statusCode: response.statusCode)))
        } else if let data = data {
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(.parsing(error as? DecodingError)))
            }
        }
    }
    
    func fetchRequest<T: Decodable>(request: URLRequest?, url: URL?, completion: @escaping(Result<T,ApiError>)->()) {
        if let request = request {
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                self.handleResponse(error, response, data, completion: completion)
            }
            
            task.resume()
        } else if let url = url {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                self.handleResponse(error, response, data, completion: completion)
            }
            
            task.resume()
        }
    }
    
    func fetchBreed(url: URL?, completion: @escaping(Result<[Breed],ApiError>)->()) {
        guard let url = url  else {
            completion(.failure(ApiError.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error as? URLError {
                completion(Result.failure(ApiError.url(error)))
            }else if  let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(ApiError.badResponse(statusCode: response.statusCode)))
            }else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let breeds = try decoder.decode([Breed].self, from: data)
                    completion(Result.success(breeds))
                    
                }catch {
                    completion(Result.failure(ApiError.parsing(error as? DecodingError)))
                }
            }
        }.resume()
    }
}
