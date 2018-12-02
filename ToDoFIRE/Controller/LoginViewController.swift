//
//  ViewController.swift
//  ToDoFIRE
//
//  Created by Nugumanov Dmitry on 11/24/18.
//  Copyright © 2018 Nugumanov Dmitry. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {
    
    let segueID = "tasksSegue"
    
    @IBOutlet weak var warnLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        warnLabel.alpha = 0
        
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            if user != nil {
                self?.performSegue(withIdentifier: (self?.segueID)!, sender: nil)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextField.text = ""
        passwordTextField.text = ""
        
    }
    
    func displayWarninLable(with text: String) {
        warnLabel.text = text
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseInOut], animations: { [weak self] in
            self?.warnLabel.alpha = 1
        }) { [weak self] complete in
            self?.warnLabel.alpha = 0
        }
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            displayWarninLable(with: "Info is incorrect")
            return
        }
        
        Auth.auth().signIn(withEmail:  email, password: password, completion: { [weak self] (user, error) in
            if error != nil {
                 
                print(error as Any)
                self?.displayWarninLable(with: (error?.localizedDescription)!)
                return
            }
            if user != nil {
               
                self?.performSegue(withIdentifier: "tasksSegue", sender: self)
                return
            }
            self?.displayWarninLable(with: (error?.localizedDescription)!)
        })
    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "registerSegue", sender: nil)
        
//        guard let email = emailTextField.text, let password = emailTextField.text, email != "", password != "" else {
//
//            displayWarninLable(with: "Info is incorrect")
//            return
//        }
//
//
//        Auth.auth().createUser(withEmail: email, password: password, completion:  { (user, error) in
//            if error == nil {
//                if user != nil {
//
//                } else {
//                    print("User isn't created")
//                }
//            } else {
//                print(error!.localizedDescription)
//            }
//        })
    
    
    }
}

extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
