//
//  MovieCell.swift
//  alamofire-sample
//
//  Created by IRFAN TRIHANDOKO on 23/03/20.
//  Copyright © 2020 IRFAN TRIHANDOKO. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

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
    
    func setupData(data: DAOMovieResults?) {
        self.backdropImg.setLoad(isLoad: true, style: .large)
        self.backdropImg.sd_setImage(with: URL(string: "\(APIConstant.MOVIE_IMAGE_URL)\(data?.backdropPath ?? "")")) { (img, err, cache, url) in
            self.backdropImg.setLoad(isLoad: false, style: .large)
            if err == nil {
                self.backdropImg.image = img
            } else {
                self.backdropImg.image = nil
                self.backdropImg.backgroundColor = UIColor.lightGray
            }
        }
        self.titleLbl.text = data?.title ?? ""
        self.descLbl.text = data?.overview ?? ""
        self.dateLbl.text = data?.releaseDate ?? ""
    }

}
