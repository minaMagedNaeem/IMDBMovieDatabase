//
//  MovieDetailsViewController.swift
//  IMDBMovieDatabase
//
//  Created by Mina Maged on 1/15/22.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addHeader()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let headerView = tableView.tableHeaderView else {
            return
        }
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        if headerView.frame.size.height != size.height {
            headerView.frame.size.height = size.height
            
            tableView.tableHeaderView = headerView
            
            tableView.layoutIfNeeded()
        }
    }
    
    func addHeader() {
        let header: MovieDetailsHeader = .fromNib()
        
        header.movie = movie
        
        tableView.tableHeaderView = header
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
