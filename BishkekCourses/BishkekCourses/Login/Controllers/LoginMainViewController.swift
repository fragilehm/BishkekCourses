//
//  LoginMainViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 3/2/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
import GoogleSignIn
class LoginMainViewController: UIViewController {
    var dict : [String : AnyObject]!
    
    @IBOutlet weak var fbLoginView: UIView! {
        didSet {
            fbLoginView.isUserInteractionEnabled = true
            let gesture = UITapGestureRecognizer(target: self, action: #selector(fbLoginButtonClicked))
            fbLoginView.addGestureRecognizer(gesture)
        }
    }
    @IBOutlet weak var googleLoginView: UIView!  {
        didSet {
            googleLoginView.isUserInteractionEnabled = true
            let gesture = UITapGestureRecognizer(target: self, action: #selector(googleLoginButtonClicked))
            googleLoginView.addGestureRecognizer(gesture)
        }
    }
    @IBOutlet weak var signUpWithEmail: UIButton! {
        didSet {
            signUpWithEmail.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        if let accessToken = FBSDKAccessToken.current() {
            getFBUserData()
        }
       
    }
    @objc func fbLoginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .email], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                self.getFBUserData()
            }
        }
    }
    
    //function is fetching the user data
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    print(result!)
                    print(self.dict)
                }
            })

        }
    }
    
}
extension LoginMainViewController: GIDSignInDelegate, GIDSignInUIDelegate {

    @objc func googleLoginButtonClicked() {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate=self
        GIDSignIn.sharedInstance().signIn()
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            print(fullName)
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            GIDSignIn.sharedInstance().signOut()

        }
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        print("disconnect")
    }
}
