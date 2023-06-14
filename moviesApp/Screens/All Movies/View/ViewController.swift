//
//  ViewController.swift
//  moviesApp
//
//  Created by BS1101 on 5/6/23.
//

import UIKit


class ViewController: UIViewController, favDelegate, DescriptionViewControllerDelegate{
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    //    public var data: [MovieTableCellViewModel] = []
    var viewModel = MainViewModel.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configuration()
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
}

extension ViewController{
    func configuration(){
        tableView.register(UINib.init(nibName: "MoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "MoviesTableViewCell")
//        Bundle(identifier: Bundle.main.bundlePath) this goes in the bundle
        initViewModel()
        observeEvent()
        tableView.delegate = self
        tableView.dataSource = self
    }
    func initViewModel(){
        viewModel.fetchMovies()
    }
    func observeEvent(){
        viewModel.eventHandler = { [weak self] event in
            guard let self else {return}
            switch event{
            case .loading: print("Movies Loading")
            case .stopLoading: print("Stop Loading")
            case .dataLoaded:
                //                print(viewModel.movie)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .error(let error): print(error as Any)
            }
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentControl.selectedSegmentIndex{
        case 0:
            return viewModel.movie.count
        case 1:
            return viewModel.favMovie.count
        default:
            break
        }
        return viewModel.movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as? MoviesTableViewCell {
                    cell.delegate = self
        
                    switch segmentControl.selectedSegmentIndex {
                    case 0:
                        let movieInformation = viewModel.movie[indexPath.row]
                        cell.movieDetailConfig(with: movieInformation)
                        cell.favBtn.setImage(viewModel.isInFavorites(movie: movieInformation) ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
                        return cell
                    case 1:
                        let movieInformation = viewModel.favMovie[indexPath.row]
                        cell.movieDetailConfig(with: movieInformation)
                        cell.favBtn.setImage(UIImage(systemName: "star.fill"), for: .normal)
        
                        return cell
        
                    default:
                        return UITableViewCell()
                    }
                }
        
                return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                if let cell = tableView.cellForRow(at: indexPath) as? MoviesTableViewCell {
                    if let selectedMovie = cell.movie {
                        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DescriptionViewController") as? DescriptionViewController{
                            vc.movie = selectedMovie
                            vc.delegate = self
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
                tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func didTapFavBTN(in cell: MoviesTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            switch segmentControl.selectedSegmentIndex {
            case 0:
                let movieInformation = viewModel.movie[indexPath.row]
                viewModel.toggleFavorite(movie: movieInformation)
                cell.favBtn.setImage(viewModel.isInFavorites(movie: movieInformation) ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
                
            case 1:
                let movieInformation = viewModel.favMovie[indexPath.row]
                viewModel.toggleFavorite(movie: movieInformation)
                cell.favBtn.setImage(UIImage(systemName: "star.fill"), for: .normal)
                
                
            default:
                break
            }
            tableView.reloadData()
        }
    }
    func didToggleFavorite(movie: Movie) {
        viewModel.toggleFavorite(movie: movie)
        tableView.reloadData()
    }
}

