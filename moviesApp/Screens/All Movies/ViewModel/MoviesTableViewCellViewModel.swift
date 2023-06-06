//
//  MoviesTableViewCellViewModel.swift
//  moviesApp
//
//  Created by BS1101 on 6/6/23.
//

import Foundation
class MovieTableCellViewModel{
    var id: Int
    var name: String
    var date: String
    var score: String
    var image: URL?
    
    init(movie: Movie){
        self.id = movie.id
        self.name = movie.name ?? movie.title ?? ""
        self.date = movie.releaseDate ?? movie.firstAirDate ?? ""
        self.score = "\(movie.voteAverage)/10"
        self.image = makeImageURL(movie.posterPath ?? "")
    }
    
    private func makeImageURL(_ imageCode:String) -> URL?{
        URL(string: "\(Constant.API.imageServer)\(imageCode)")
    }
}
