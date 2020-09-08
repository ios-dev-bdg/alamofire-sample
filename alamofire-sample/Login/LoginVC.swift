//
//  LoginVC.swift
//  alamofire-sample
//
//  Created by IRFAN TRIHANDOKO on 08/09/20.
//  Copyright © 2020 IRFAN TRIHANDOKO. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginVC: UIViewController {

    @IBOutlet weak var usernameTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    var requestToken: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Login"
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        // Test => username: iOS_Dev, password: test1234
        self.requestLoginWithToken()
    }
    

}

extension LoginVC {
    
    func requestLoginWithToken() {
        APIDataSource.doGetToken(onSuccess: { (response) in
            self.requestToken = JSON(response)["request_token"].stringValue
            DispatchQueue.main.async {
                self.requestLogin()
            }
        }) { message in
            self.showAlert(title: "Warning!", message: message ?? "")
        }
    }
    
    func requestLogin() {
        APIDataSource.doLogin(username: self.usernameTf.text ?? "", password: self.passwordTf.text ?? "", requestToken: self.requestToken ?? "", onSuccess: { (response) in
            self.showAlert(title: "Information", message: "Login Successfully!")
        }) { message in
            self.showAlert(title: "Warning!", message: message ?? "")
        }
    }
    
}
