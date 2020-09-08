//
//  MovieListVC.swift
//  alamofire-sample
//
//  Created by IRFAN TRIHANDOKO on 17/03/20.
//  Copyright © 2020 IRFAN TRIHANDOKO. All rights reserved.
//

import UIKit

class MovieListVC: UIViewController {
    
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
        APIDataSource.getPopularMovie(type: "popular", onSuccess: { response in
            let data = DAOPopularMovieBaseClass(object: response)
            self.list = []
            for dt in data.results ?? [] {
                self.list?.append(MovieModel(date: dt.releaseDate, title: dt.title, backdrop: "\(APIConstant.moviesImageURL)\(dt.backdropPath ?? "")", overview: dt.overview))
            }
            self.tableView?.reloadData()
        }, onFailed: { message  in
            self.showAlert(title: "Perhatian!", message: message ?? "")
        })
    }
    
}

