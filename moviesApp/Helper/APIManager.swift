//
//  APIManager.swift
//  moviesApp
//
//  Created by BS1101 on 5/6/23.
//

import UIKit
//Singleton design pattern and no inhertitance
enum DataError: Error{
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}
typealias Handler = (Result<[Movie],DataError>)-> Void
final class APIManager{
    static let shared = APIManager()
    private init() {}
    
    func fetchMovies(completion: @escaping Handler){
        guard let url = URL(string: Constant.API.infoServer) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else{
                completion(.failure(.invalidResponse))
                return
            }
            do{
                let movies = try? JSONDecoder().decode(movieModel.self, from: data )
                completion(.success(movies?.results ?? [Movie]()))
            }
//            catch{
//                completion(.failure(.network(error)))
//            }
            
            
        }.resume()
    }
}
