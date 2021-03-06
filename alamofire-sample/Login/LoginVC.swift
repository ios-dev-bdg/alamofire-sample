//
//  LoginVC.swift
//  alamofire-sample
//
//  Created by IRFAN TRIHANDOKO on 08/09/20.
//  Copyright © 2020 IRFAN TRIHANDOKO. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginVC: BaseVC {

    @IBOutlet weak var usernameTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Login"
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        self.showSpinner(onView: self.view)
        // Test => username: iOS_Dev, password: test1234
        self.requestLoginWithToken()
    }
}

extension LoginVC {
    
    func requestLoginWithToken() {
        APIDataSource.doGetToken(onSuccess: { 
            DispatchQueue.main.async {
                self.requestLogin()
            }
        }) { message in
            self.showAlert(title: "Warning!", message: message ?? "")
        }
    }
    
    func requestLogin() {
        APIDataSource.doLogin(username: self.usernameTf.text ?? "", password: self.passwordTf.text ?? "", onSuccess: { (response) in
            self.showAlert(title: "Success!", message: response)
        }) { message in
            self.showAlert(title: "Warning!", message: message ?? "")
        }
    }
    
}
