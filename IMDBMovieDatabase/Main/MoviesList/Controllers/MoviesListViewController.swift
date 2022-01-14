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
    
    var viewModel: MoviesListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavbar()
        self.setupTableView()
        
        
        self.viewModel = MoviesListViewModel(onListRetrieval: { [weak self] in
            self?.view.stopProgressAnim()
            self?.tableView.finishInfiniteScroll()
        })
        
        self.view.startProgressAnim()
        self.viewModel?.getMoviesLists(successCompletion: {[weak self] indices in
            self?.updateTableView(indices: indices)
        })
        
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
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterTapped))
    }
    
    private func setupTableView() {
        tableView.registerReusableCell(MovieTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    private func updateTableView(indices: [Int]) {
        var indexPaths: [IndexPath] = indices.map({return IndexPath(row: $0, section: 0)})
        
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: indexPaths, with: .automatic)
        self.tableView.endUpdates()
        self.tableView.finishInfiniteScroll()
    }
    
    @objc func filterTapped(sender: UIBarButtonItem) {
        // Function body goes here
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
