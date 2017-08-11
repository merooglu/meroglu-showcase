//
//  ViewController.swift
//  meroglu-showcase
//
//  Created by Mehmet Eroğlu on 19.07.2017.
//  Copyright © 2017 Mehmet Eroğlu. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let loginButton = FBSDKLoginButton()
//        view.addSubview(loginButton)
//        
//        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
//        
//        loginButton.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaults.standard.string(forKey: KEY_UID) != nil {
            self.performSegue(withIdentifier: SEGUE_LOGGED_IN, sender: nil)
        }
    }
    
    @IBAction func fbButtonPressed(sender: UIButton!){
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self.parent) { (result, error) in
            if error != nil {
                print("Facebook login failede. Error \(String(describing: error))")
            }else if (result?.isCancelled)! {
                print("Facebook Login Cancelled.")
            }else {
                let accessToken = FBSDKAccessToken.current().tokenString
                print("Successfully logged in with facebook. \(String(describing: accessToken))")
                
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
              
                Auth.auth().signIn(with: credential, completion: { (user, error) in
                    if error != nil {
                        print("Login failed \(String(describing: error))")
                    }else {
                        print("Logged in. \(String(describing: user))")
                        
                        let userData = ["provider": credential.provider]
                        DataService.ds.createFirebaseUser(uid: user!.uid, user: userData)
                        
                        UserDefaults.standard.set(user?.uid, forKey: KEY_UID)
                        self.performSegue(withIdentifier: SEGUE_LOGGED_IN, sender: nil)
                    }
                })
            }
        }
    }
    
    
    
    
    @IBAction func attemptLogin(sender: UIButton!) {
        if let email = emailTextField.text, emailTextField.text != "", let pwd = passwordTextField.text, pwd != "" {
            
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error != nil {
                    print(error)
                    
                    let code = (error! as NSError).code
                    if code == STATUS_ACCOUNT_NONEXİST {
                        Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                            
                            if error != nil {
                                self.showErrorAlert(title: "Could Not Create Account", msg: "Problem creating account. Please try something else")
                            }else {
                                UserDefaults.standard.set(user!.uid, forKey: KEY_UID)
                                
                                let userData = ["provider": "email"]
                                DataService.ds.createFirebaseUser(uid: user!.uid, user: userData)
                                
                                self.performSegue(withIdentifier: SEGUE_LOGGED_IN, sender: nil)
                            }
                        })
                    }else {
                        self.showErrorAlert(title: "Could Not Log In", msg: "Please check your email and password.")
                    }
                }else {
                    self.performSegue(withIdentifier: SEGUE_LOGGED_IN, sender: nil)
                }
            })
            
        }else {
            showErrorAlert(title: "Email and Password Required", msg: "You must enter an email and a password")
        }
    }
    
    
    
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    // facebook login button delegate functions , FBSDKLoginButtonDelegate
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
        print("Succesfully logged in with facebook")
    }

}

