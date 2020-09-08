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
        case 1:
            let sb = UIStoryboard(name: "Login", bundle: nil)
            let vc = sb.instantiateInitialViewController() as? LoginVC
            self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
        case 2:
            break
        default: // GET
            let sb = UIStoryboard(name: "MovieList", bundle: nil)
            let vc = sb.instantiateInitialViewController() as? MovieListVC
            self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
        }
    }
}

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            alert.dismiss(animated: true, completion: nil)
        })
    }
    
}
