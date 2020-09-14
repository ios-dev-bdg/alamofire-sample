//
//  ViewController.swift
//  alamofire-sample
//
//  Created by IRFAN TRIHANDOKO on 08/09/20.
//  Copyright © 2020 IRFAN TRIHANDOKO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func requestAction(_ sender: UIButton) {
        switch sender.tag {
        case 1: // POST
            let sb = UIStoryboard(name: "Login", bundle: nil)
            let vc = sb.instantiateInitialViewController() as? LoginVC
            self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
        case 2: // MULTIPART
            let sb = UIStoryboard(name: "EditProfile", bundle: nil)
            let vc = sb.instantiateInitialViewController() as? EditProfileVC
            self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
        default: // GET
            let sb = UIStoryboard(name: "MovieList", bundle: nil)
            let vc = sb.instantiateInitialViewController() as? MovieListVC
            self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
        }
    }
}
