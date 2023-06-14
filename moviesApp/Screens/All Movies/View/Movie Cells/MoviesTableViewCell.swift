//
//  MoviesTableViewCell.swift
//  moviesApp
//
//  Created by BS1101 on 5/6/23.
//

import UIKit
import SDWebImage

protocol favDelegate: AnyObject{
    func didTapFavBTN(in cell: MoviesTableViewCell)
}

class MoviesTableViewCell: UITableViewCell {
    
    weak var delegate: favDelegate?
    var movie: Movie?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    
    func movieDetailConfig(with movie: Movie){
        self.movie = movie
        if let Name = movie.name {
            nameLabel.text = Name
        } else {
            nameLabel.text = movie.title
        }
        dateLabel.text = movie.releaseDate
        scoreLabel.text = "\(movie.voteAverage)"
        movieImageView.sd_setImage(with: URL(string: Constant.API.imageServer + (movie.posterPath ?? "")))
        if movie.isfav ?? false {
            favBtn.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favBtn.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
    }
    
    
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
    
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
    
            // Configure the view for the selected state
        }
    
    @IBAction func favBtnPressed(_ sender: Any) {
        if let movie = movie {
            delegate?.didTapFavBTN(in: self)
            
            if movie.isfav ?? false {
                favBtn.setImage(UIImage(systemName: "star.fill"), for: .normal)
            } else {
                favBtn.setImage(UIImage(systemName: "star"), for: .normal)
            }
            
        }
    }
}
