//
//  ViewController.swift
//  moviesApp
//
//  Created by BS1101 on 5/6/23.
//

import UIKit

class ViewController: UIViewController{
    
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    @IBOutlet weak var tableView: UITableView!
    public var data: [MovieTableCellViewModel] = []
    var viewModel = MainViewModel()
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
        tableView.register(UINib.init(nibName: "MoviesTableViewCell", bundle: Bundle(identifier: Bundle.main.bundlePath)), forCellReuseIdentifier: "MoviesTableViewCell")
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
                print(self.viewModel.movie)
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
            return viewModel.movie.count
        default:
            break
        }
        return viewModel.movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as? MoviesTableViewCell{
            switch segmentControl.selectedSegmentIndex{
            case 0:
                let movieInformation = viewModel.movie[indexPath.row]
                cell.movieDetailConfig(with: movieInformation)
                return cell
            case 1:
                let movieInformation = viewModel.movie[indexPath.row]
                cell.movieDetailConfig(with: movieInformation)
                return cell
            default:
                break
            }
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
}

