//
//  MovieListVC.swift
//  alamofire-sample
//
//  Created by IRFAN TRIHANDOKO on 17/03/20.
//  Copyright © 2020 IRFAN TRIHANDOKO. All rights reserved.
//

import UIKit

class MovieListVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView?
    var list: [MovieModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
        getPopularMovie()
    }
}

extension MovieListVC: UITableViewDelegate, UITableViewDataSource {
    
    func configureView() {
        self.title = "Movie List"
        tableView?.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell
        cell?.setupData(data: list?[indexPath.row])
        return cell ?? UITableViewCell()
    }
}

extension MovieListVC {
    
    func getPopularMovie() {
        self.showSpinner(onView: self.view)
        APIDataSource.getPopularMovieCodable(type: "popular", onSuccess: { response in
            self.removeSpinner()
            self.list = response
            self.tableView?.reloadData()
        }, onFailed: { message  in
            self.removeSpinner()
            self.showAlert(title: "Warning!", message: message ?? "")
        })
    }
    
}

