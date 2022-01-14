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
    
    var viewModel: MoviesListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavbar()
        self.setupTableView()
        
        
        self.viewModel = MoviesListViewModel(onListRetrieval: { [weak self] in
            self?.view.stopProgressAnim()
            self?.tableView.finishInfiniteScroll()
        })
        
        self.getMovies()
        
        self.tableView.addInfiniteScroll {[weak self] (tableView) -> Void in
            if (self?.viewModel?.canFetchMorePages ?? false) {
                self?.viewModel?.getMoviesLists(successCompletion: {[weak self] indices in
                    self?.updateTableView(indices: indices)
                })
            }else{
                self?.tableView.finishInfiniteScroll()
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    private func setupNavbar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Movies"
        
        let favouritesButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterTapped))
        self.navigationItem.rightBarButtonItem = favouritesButton
        self.favouritesButton = favouritesButton
    }
    
    private func setupTableView() {
        tableView.registerReusableCell(MovieTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    private func updateTableView(indices: [Int]) {
        let indexPaths: [IndexPath] = indices.map({return IndexPath(row: $0, section: 0)})
        
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: indexPaths, with: .automatic)
        self.tableView.endUpdates()
        self.tableView.finishInfiniteScroll()
    }
    
    private func getMovies() {
        self.setFailureView(show: false)
        self.view.startProgressAnim()
        self.viewModel?.getMoviesLists(successCompletion: {[weak self] indices in
            self?.updateTableView(indices: indices)
        }, failureCompletion: { [weak self] in
            self?.setFailureView(show: true)
        })
    }
    
    func setFailureView(show: Bool) {
        
        if show {
            let fetchFailedView = FailureView.instanceFromNib()
            fetchFailedView.completion = { [weak self] in self?.getMovies()}
            self.tableView.backgroundView = fetchFailedView
        } else {
            self.tableView.backgroundView = nil
        }
    }
    
    @objc func filterTapped(sender: UIBarButtonItem) {
        
    }
}

extension MoviesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.moviesList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.movie = self.viewModel?.moviesList[indexPath.row]
        return cell
    }
    
    
}
