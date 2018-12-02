//
//  TestViewController.swift
//  ToDoFIRE
//
//  Created by Nugumanov Dmitry on 11/26/18.
//  Copyright © 2018 Nugumanov Dmitry. All rights reserved.
//

import Foundation
import Firebase

class RegisterViewController: UIViewController {
    
    var ref: DatabaseReference!
    let worker = NetWorker()
    
    @IBOutlet weak var emailImageView: UIImageView!
    @IBOutlet weak var passwordImageView: UIImageView!
    @IBOutlet weak var nameImageView: UIImageView!
    @IBOutlet weak var emailBackgroundView: UIView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customSetupElement()
        ref = Database.database().reference(withPath: "users")
    }
    
    func customSetupElement() {
        emailImageView.image = UIImage(named: "email")
        passwordImageView.image = UIImage(named: "password")
        emailBackgroundView.backgroundColor = #colorLiteral(red: 0.001135697382, green: 0.6097245069, blue: 0.6944784843, alpha: 1)
    }
    
    func showAlert(_ text: String) {
        let alertController = UIAlertController(title: "Warning", message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(action)
        showDetailViewController(alertController, sender: nil)
    }
    
    // Registration User
    @IBAction func continueTapped(_ sender: UIButton) {
        check()
    }
    
    // cancellation of registration and return to the previous screen
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // Validation of input data for matching string fields
    func check() {
        guard let userEmail = emailTextField.text, let userPassword = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text, confirmPassword != "", userPassword != "", userEmail != "" else {
            showAlert( "Fill in all the fields")
            print("test")
            return
        }
        guard userPassword == confirmPassword else {
            showAlert("Passwords do not match")
            return
        }
        
        // Function Result Working with API Service
        worker.checkEmail(email: userEmail) { (answer, error) in
            if let answer = answer {
                print(answer)
                DispatchQueue.main.async {
                    if answer != true {
                        DispatchQueue.main.async {
                            self.showAlert("This is email does not exist")
                        }
                    } else {
                        Auth.auth().createUser(withEmail: userEmail, password: userPassword, completion: { [weak self] (user, error) in
                            guard error == nil, user != nil else {
                                print(error!.localizedDescription)
                                return
                            }
                            let userRef = self?.ref.child((user?.user.uid)!)
                            userRef?.setValue(["user": user?.user.email])
                        })
                        // Возврат на главное окно после регистрации
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
            
        }
    }
}


