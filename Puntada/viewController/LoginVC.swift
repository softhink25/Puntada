//
//  LoginVC.swift
//  Puntada
//
//  Created by José Ibarra Martínez on 05/11/20.
//  Copyright © 2020 Softhink. All rights reserved.
//

import UIKit
import CryptoSwift
import SwiftyJSON 
import FBSDKLoginKit
import GoogleSignIn

class LoginVC: UIViewController,LoginButtonDelegate,GIDSignInDelegate  {
    @IBOutlet weak var btnGoogleLogin: GIDSignInButton!
    @IBOutlet weak var btnEntrar: UIButton!
    @IBOutlet weak var btnGoogleContainer: UIView!
    
    @IBAction func btnGoogleLoginAction(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
      if let error = error {
        if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
          print("The user has not signed in before or they have since signed out.")
        } else {
          print("\(error.localizedDescription)")
        }
        return
      } 
      // ...
    }

    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if error != nil {
            print("error")
        } else if ((result?.isCancelled) == true) {
            print("cancelled")
        } else {
            print("token: \(String(describing: result?.token?.tokenString))")
            print("user_id: \(String(describing: result?.token?.userID))")
            
        }
        
        if((AccessToken.current) != nil)
        {
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler:
                { (connection, result, error) -> Void in
                    if (error == nil)
                    {
                        //everything works print the user data
                        //                        print(result!)
                        if let data = result as? NSDictionary
                        {
                            let firstName  = data.object(forKey: "first_name") as! String
                            let lastName  = data.object(forKey: "last_name") as! String
                            let userId  = data.object(forKey: "id") as? String
                            let url:URL = URL(string: Constants.FB_LOGIN)! ;
                            if let email = data.object(forKey: "email") as? String
                            {
                                let parameters = [ "first_name": firstName, "last_name":lastName,"email":email,"id":userId as Any ] as [String : Any];
                                print(email)
                                RemoteRequest.jsonByRequestPost(requestUrl: url, parameters: parameters as [String : Any], completeHandler: { [self] (response) in
                                    if(response?["result"]["success"].bool ?? false){
                                        doLogin(response: response!);
                                    }
                                    }, errorHandler: nil, loadingMessage: "Cargando..", view: self.view, showDialogs: true)
                            }
                            else
                            {
                                 // If user have signup with mobile number you are not able to get their email address
                                print("We are unable to access Facebook account details, please use other sign in methods.")
                            }
                        }
                    }
            })
        }
    }
        func doLogin(response:JSON ){
            Utils.doLogin(response:response)
            self.performSegue(withIdentifier: "home", sender: nil)
             
        }
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    
    @IBOutlet weak var txtUsuario: UITextField!
    @IBOutlet weak var fbButtonContainer: UIView!
    
    @IBOutlet weak var txtContrasena: UITextField!
    @IBAction func btnEntrarAccion(_ sender: UIButton) {
        let url:URL = URL(string: Constants.LOGIN)! ;
        let pwd = txtContrasena!.text! as String;
        let parameters = [ "usu_clave": txtUsuario!.text!, "usu_contrasena":pwd.md5()  ] as [String : Any];
        RemoteRequest.jsonByRequestPost(requestUrl: url, parameters: parameters as [String : Any], completeHandler: { (response) in
            if(response?["result"]["success"].bool ?? false){
                self.doLogin(response: response!);
                }
            }, errorHandler: nil, loadingMessage: "Cargando..", view: self.view, showDialogs: true)
    }
    
    // Swift // // Add this to the header of your file, e.g. in ViewController.swift // Add this to the body class ViewController: UIViewController { override func viewDidLoad() { } }

    // Swift // // Extend the code sample from 6a. Add Facebook Login to Your Code // Add to your viewDidLoad method:
   
    override func viewDidLoad() {
        super.viewDidLoad()
         
        let loginButton = FBLoginButton()
        loginButton.center = fbButtonContainer.center;
        loginButton.layer.bounds = fbButtonContainer.layer.bounds;
        fbButtonContainer.addSubview(loginButton) 
        loginButton.permissions = ["public_profile", "email"]
        loginButton.delegate  = self;
        GIDSignIn.sharedInstance()?.presentingViewController = self
       
          // Automatically sign in the user.
          GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        Utils.shadowButton(boton: btnEntrar)
        Utils.shadowView(view: btnGoogleContainer);
        Utils.shadowView(view:  fbButtonContainer);
    }
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
      withError error: NSError!) {
        if (error == nil) {
          // Perform any operations on signed in user here.
          // ...
        } else {
          print("\(error.localizedDescription)")
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        let token:String = Utils.getData(key: "access_token") as? String ?? ""
        if(token != nil && token != ""){
            self.performSegue(withIdentifier: "home", sender: nil)
        }
    }
 
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "home"{

                let destView = segue.destination as! HomeViewController
        }
    }

}
