//
//  MoviesListViewController.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/14/22.
//

import UIKit

class MoviesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavbar()
        
        tableView.registerReusableCell(MovieTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    private func setupNavbar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Movies"
    }
}

extension MoviesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        return cell
    }
    
    
}
