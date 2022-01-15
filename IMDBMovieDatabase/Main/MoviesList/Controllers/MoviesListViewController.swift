//
//  MoviesListViewController.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/14/22.
//

import UIKit
import UIScrollView_InfiniteScroll

class MoviesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    weak var favouritesButton: UIBarButtonItem!
    let refreshControl = UIRefreshControl()
    
    var viewModel: MoviesListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = MoviesListViewModel(onListRetrieval: { [weak self] in
            self?.view.stopProgressAnim()
            self?.refreshControl.endRefreshing()
            self?.tableView.finishInfiniteScroll()
            self?.tableView.reloadData()
            self?.favouritesButton.title = self?.getFilterButtonTitle()
        })
        
        self.setupNavbar()
        self.setupTableView()
        
        self.startGettingMovies()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func filterTapped(sender: UIBarButtonItem) {
        self.viewModel?.toggleFavourites()
        
        favouritesButton.title = getFilterButtonTitle()
    }
    
    private func setupNavbar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Movies"
        
        let favouritesButton = UIBarButtonItem(title: getFilterButtonTitle(), style: .plain, target: self, action: #selector(filterTapped))
        self.navigationItem.rightBarButtonItem = favouritesButton
        self.favouritesButton = favouritesButton
    }
    
    private func getFilterButtonTitle() -> String {
        return self.viewModel?.isShowingFavourites == true ? "Show All" : "Show Favourites"
    }
    
    private func setupTableView() {
        tableView.registerReusableCell(MovieTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        self.tableView.addInfiniteScroll {[weak self] (tableView) -> Void in
            if (self?.viewModel?.canFetchMorePages ?? false) {
                self?.viewModel?.getMoviesLists()
            }else{
                self?.tableView.finishInfiniteScroll()
            }
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.startGettingMovies()
    }
    
    private func startGettingMovies() {
        self.favouritesButton.isEnabled = false
        self.setFailureView(show: false)
        self.view.startProgressAnim()
        self.viewModel?.getMoviesLists(firstRun: true, successCompletion: {[weak self] in
            self?.favouritesButton.isEnabled = true
        }, failureCompletion: { [weak self] in
            self?.setFailureView(show: true)
        })
    }
    
    private func setFailureView(show: Bool) {
        if show {
            let fetchFailedView = FailureView.instanceFromNib()
            fetchFailedView.completion = { [weak self] in self?.startGettingMovies()}
            self.tableView.backgroundView = fetchFailedView
        } else {
            self.tableView.backgroundView = nil
        }
    }
    
    private func toggleMovieFavourite(movieId: Int) {
        self.viewModel?.toggleMovieFavourite(for: movieId, completion: {[weak self] (index) in
            let indexPath = IndexPath(item: index, section: 0)
            self?.tableView.reloadRows(at: [indexPath], with: .automatic)
        })
    }
}

extension MoviesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.shownMoviesList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.movie = self.viewModel?.shownMoviesList[indexPath.row]
        
        cell.onPressFavourites = { [weak self] (movieId) in
            self?.toggleMovieFavourite(movieId: movieId)
        }
        
        return cell
    }
    
    
}
