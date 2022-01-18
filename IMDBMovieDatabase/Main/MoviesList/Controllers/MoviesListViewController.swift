//
//  MoviesListViewController.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/14/22.
//

import UIKit
import UIScrollView_InfiniteScroll

class MoviesListViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Global Variables
    weak var favouritesButton: UIBarButtonItem!
    let refreshControl = UIRefreshControl()
    
    var viewModel: MoviesListViewModel
    
    weak var coordinator: Coordinator?
    
    // MARK: - LifeCycle Methods
    init(coordinator: Coordinator, viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.onListRetrieval = { [weak self] in
            self?.view.stopProgressAnim()
            self?.refreshControl.endRefreshing()
            self?.tableView.finishInfiniteScroll()
            self?.tableView.reloadData()
            self?.favouritesButton.title = self?.getFilterButtonTitle()
        }
        
        self.setupNavbar()
        self.setupTableView()
        
        self.startGettingMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    //MARK: - Public methods
    @objc func filterTapped(sender: UIBarButtonItem) {
        self.viewModel.toggleFavourites()
        favouritesButton.title = getFilterButtonTitle()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.startGettingMovies()
    }
    
    //MARK: - Private Methods
    private func setupNavbar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Movies"
        
        let favouritesButton = UIBarButtonItem(title: getFilterButtonTitle(), style: .plain, target: self, action: #selector(filterTapped))
        self.navigationItem.rightBarButtonItem = favouritesButton
        self.favouritesButton = favouritesButton
    }
    
    private func getFilterButtonTitle() -> String {
        return self.viewModel.isShowingFavourites == true ? "Show All" : "Show Favourites"
    }
    
    private func setupTableView() {
        tableView.registerReusableCell(MovieTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        self.tableView.addInfiniteScroll {[weak self] (tableView) -> Void in
            if (self?.viewModel.canFetchMorePages ?? false) {
                self?.viewModel.getMoviesLists()
            }else{
                self?.tableView.finishInfiniteScroll()
            }
        }
    }
    
    private func startGettingMovies() {
        self.favouritesButton.isEnabled = false
        self.setFailureView(show: false)
        self.view.startProgressAnim()
        self.viewModel.getMoviesLists(firstRun: true, successCompletion: {[weak self] in
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
        self.viewModel.toggleMovieFavourite(for: movieId, completion: {[weak self] (index) in
            let indexPath = IndexPath(item: index, section: 0)
            self?.tableView.reloadRows(at: [indexPath], with: .automatic)
        })
    }
}

// MARK: - Extension for UITableViewDataSource & UITableViewDelegate
extension MoviesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.moviesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        
        cell.movie = self.viewModel.movie(for: indexPath.row)
        
        cell.onPressFavourites = { [weak self] (movieId) in
            self?.toggleMovieFavourite(movieId: movieId)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        coordinator?.showDetails(of: self.viewModel.movie(for: indexPath.row))
    }
}
