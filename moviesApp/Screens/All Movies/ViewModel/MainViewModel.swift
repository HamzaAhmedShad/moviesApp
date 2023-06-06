//
//  MainViewModel.swift
//  moviesApp
//
//  Created by BS1101 on 6/6/23.
//

import Foundation
final class MainViewModel{
    var movie: [Movie] = []
    var eventHandler: ((_ event: Event) ->Void)?
    
    func fetchMovies(){
        self.eventHandler?(.loading)
        APIManager.shared.fetchMovies { response in
            self.eventHandler?(.stopLoading)
            switch response{
            case .success(let movies):
                self.movie = movies
                self.eventHandler?(.dataLoaded)
                print(movies)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
}
extension MainViewModel{
    enum Event{
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}