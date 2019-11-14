//
//  SignUpViewController.swift
//  Mamafua
//
//  Created by macbook on 13/11/2019.
//  Copyright © 2019 Arusey. All rights reserved.
//

import UIKit
import TinyConstraints


class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    
    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var password: UITextField!
    
    
    @IBOutlet weak var emailError: UILabel!
    
    @IBOutlet weak var passwordError: UILabel!
    
    
    
    @IBAction func signUpAction(_ sender: Any) {
        validate()
        
        
        if firstName.text == "" || lastName.text  == "" || email.text == "" || password.text == "" {
            let alertController = UIAlertController(title: "Enter credentials", message: "Please ensure you have inserted all your credentials", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present (alertController, animated: true, completion: nil)
        }
        
        let user = User(firstName: firstName.text!, lastName: lastName.text!, email: email.text!, password: password.text!)
        
        
        let postRequest = APIRequest(endpoint: "register")
        
        postRequest.save(user, completion: { result in
            
            switch result {
            case .success(let user):
                print("User has been successfully signed up: \(String(describing: user.firstName))")
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Success", message: "SignUp successful", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
                        self.performSegue(withIdentifier: "signupToHome", sender: self)
                    })
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)

                }

            case .failure(let error):
                print("An error occured \(error.localizedDescription)")
                DispatchQueue.main.async {
                    
                    let alertController = UIAlertController(title: "Error", message: "An error occured while signing up please check your credentials and try again", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)

                }
             
                
            }
        })
    
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    fileprivate func setupView() {
        passwordError.isHidden = true
        emailError.isHidden = true
    }
    
    func validate() {
        do {
            _ = try email.validatedText(validationType: ValidatorType.email)
            _ = try password.validatedText(validationType: ValidatorType.password)
        } catch(let error) {
            showAlert(for: (error as! ValidationError).message)
        }
    }
    
    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    

}
