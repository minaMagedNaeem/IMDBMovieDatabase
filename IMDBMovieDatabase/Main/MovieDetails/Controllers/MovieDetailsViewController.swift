//
//  MovieDetailsViewController.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/15/22.
//

import UIKit
import Toaster

class MovieDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Global Variables
    
    var viewModel: MovieDetailsViewModel
    
    var header: MovieDetailsHeader?
    
    weak var coordinator: Coordinator?
    
    // MARK: - Lifecycle Methods
    init(coordinator: Coordinator, viewModel: MovieDetailsViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.viewModel.movie.originalTitle
        
        self.viewModel.onListRetrieval = { [weak self] in
            self?.view.stopProgressAnim()
            self?.tableView.finishInfiniteScroll()
            self?.tableView.reloadData()
        }
        
        addHeader()
        setupTableView()
        
        self.startGettingReviews()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layoutHeader()
    }
    
    // MARK: - Private Methods
    private func addHeader() {
        let header: MovieDetailsHeader = .fromNib()
        
        header.movie = self.viewModel.movie
        
        header.onRating = {[weak self] rate in
            self?.didRate(rate: rate)
        }
        
        header.onPressAddToFavourites = {[weak self] in
            self?.addToFavouritesPressed()
        }
        
        tableView.tableHeaderView = header
        
        header.translatesAutoresizingMaskIntoConstraints = false
        header.widthAnchor.constraint(equalTo: self.tableView.widthAnchor, multiplier: 1.0).isActive = true
        
        self.header = header
    }
    
    private func layoutHeader() {
        guard let headerView = tableView.tableHeaderView else {return }
        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        print(size)
        print(headerView.frame.size.height)
        if headerView.frame.size.height != size.height {
            headerView.frame.size.height = size.height
            tableView.tableHeaderView = headerView
            tableView.layoutIfNeeded()
        }
    }
    
    private func setupTableView() {
        tableView.registerReusableCell(ReviewsTableViewCell.self)
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        self.tableView.addInfiniteScroll {[weak self] (tableView) -> Void in
            if (self?.viewModel.canFetchMorePages ?? false) {
                self?.viewModel.getReviewsLists()
            }else{
                self?.tableView.finishInfiniteScroll()
            }
        }
    }
    
    private func startGettingReviews() {
        self.view.startProgressAnim()
        self.viewModel.getReviewsLists()
    }
    
    private func addToFavouritesPressed() {
        self.viewModel.toggleMovieFavourite()
        self.header?.movie = self.viewModel.movie
    }
    
    private func didRate(rate: Int) {
        self.viewModel.rateMovie(rate: rate, completion: { (success) in
            if success {
                Toast(text: "Rated successfully!", duration: Delay.long).show()
            } else {
                Toast(text: "Failed to rate", duration: Delay.long).show()
            }
        })
    }
}

// MARK: - Extension for UITableViewDataSource
extension MovieDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.reviewsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReviewsTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.review = self.viewModel.review(for: indexPath.row)
        
        return cell
    }
}
