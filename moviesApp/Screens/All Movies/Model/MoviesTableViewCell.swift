//
//  MoviesTableViewCell.swift
//  moviesApp
//
//  Created by BS1101 on 5/6/23.
//

import UIKit
import SDWebImage



class MoviesTableViewCell: UITableViewCell {
    
    
    
    
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var starView: UIImageView!
    
    func movieDetailConfig(with movie: Movie){
        if let Name = movie.name {
            nameLabel.text = Name
        } else {
            nameLabel.text = movie.title
        }
        dateLabel.text = movie.releaseDate
        scoreLabel.text = "\(movie.voteAverage)"
        movieImageView.sd_setImage(with: URL(string: Constant.API.imageServer + (movie.posterPath ?? "")))
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
