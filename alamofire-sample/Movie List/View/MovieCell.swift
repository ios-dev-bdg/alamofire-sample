//
//  MovieCell.swift
//  alamofire-sample
//
//  Created by IRFAN TRIHANDOKO on 23/03/20.
//  Copyright © 2020 IRFAN TRIHANDOKO. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class MovieCell: UITableViewCell {

    @IBOutlet weak var backdropImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setupData(data: MovieModel?) {
        backdropImg.kf.setImage(with: URL(string: data?.backdrop ?? ""))
        titleLbl.text = data?.title ?? ""
        descLbl.text = data?.overview ?? ""
        dateLbl.text = data?.date ?? ""
    }

}
