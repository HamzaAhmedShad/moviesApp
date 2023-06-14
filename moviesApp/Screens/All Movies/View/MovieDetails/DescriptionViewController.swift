//
//  DescriptionViewController.swift
//  moviesApp
//
//  Created by BS1101 on 12/6/23.
//

import UIKit
protocol DescriptionViewControllerDelegate: AnyObject{
    func didToggleFavorite(movie: Movie)
}
class DescriptionViewController: UIViewController {
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var fvrtBtn: UIButton!
    
    var viewModel = MainViewModel.shared
    weak var delegate: DescriptionViewControllerDelegate?
    
    var movie: Movie?
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        // Do any additional setup after loading the view.
    }
    func configView() {
        if let movie = movie {
            movieTitle.text = movie.name ?? movie.title
            movieDescription.text = movie.overview
            moviePoster.sd_setImage(with: URL(string: Constant.API.imageServer + (movie.posterPath ?? "")))
            updateFavoriteButton()
        }
    }
    
    @IBAction func fvrtBtnPressed(_ sender: Any) {
        if let movie = movie{
            delegate?.didToggleFavorite(movie: movie)
            self.updateFavoriteButton()
        }
    }
    private func updateFavoriteButton(){
        if let movie = movie{
            if viewModel.isInFavorites(movie: movie) {
                fvrtBtn.setImage(UIImage(systemName: "star.fill"), for: .normal)
            } else {
                fvrtBtn.setImage(UIImage(systemName: "star"), for: .normal)
            }
        }
    }
}
