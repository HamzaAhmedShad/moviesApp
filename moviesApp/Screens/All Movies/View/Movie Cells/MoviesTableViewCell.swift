//
//  MoviesTableViewCell.swift
//  moviesApp
//
//  Created by BS1101 on 5/6/23.
//

import UIKit
import SDWebImage



class MoviesTableViewCell: UITableViewCell {
    
    
    
    var myMovie: Movie?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    func movieDetailConfig(with movie: Movie){
        if let Name = movie.name {
            nameLabel.text = Name
        } else {
            nameLabel.text = movie.title
        }
        dateLabel.text = movie.releaseDate
        scoreLabel.text = "\(movie.voteAverage)"
        movieImageView.sd_setImage(with: URL(string: Constant.API.imageServer + (movie.posterPath ?? "")))
        myMovie = movie
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
        if myMovie?.isfav == false{
            favBtn.configuration?.image = UIImage(systemName: "star.fill")
            if MainViewModel.inIsFav(movie: myMovie!)==false{
                MainViewModel.favMovie.append(myMovie!)
            }
            myMovie?.isfav = true
        }
        else if myMovie?.isfav == true{
            favBtn.configuration?.image = UIImage(systemName: "star")
            let removeIndex = MainViewModel.favMovie.firstIndex(where: {$0.name == myMovie?.name})
            MainViewModel.favMovie.remove(at: removeIndex!)
            myMovie?.isfav = false
        }
    }
}
