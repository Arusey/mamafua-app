//
//  LoginViewController.swift
//  Mamafua
//
//  Created by macbook on 17/11/2019.
//  Copyright © 2019 Arusey. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    

    @IBAction func loginAction(_ sender: Any) {
        
        if email.text == "" || password.text == "" {
            let alertController = UIAlertController(title: "Enter credentials", message: "Please ensure you have inserted all your credentials", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present (alertController, animated: true, completion: nil)
        }
        
        let loginUser = AuthUser(email: email.text!, password: password.text!)
        
        let loginRequest = LoginRequest(endpoint: "login")
        
        loginRequest.loginUser(loginUser, completion: {
            result in
            switch result {
            case .success(let loginUser):
                print("User has been successfully logged in \(String(describing: loginUser.email))")
                
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Success", message: "Login successful", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: {
                        (_) in
                        self.performSegue(withIdentifier: "loginToHome", sender: self)
                    })
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                
                
            case .failure(let error):
                print("An authentication error occurred \(error)")
                
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }

            }
        })
        

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    



}
