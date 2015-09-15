//
//  ViewController.swift
//  touch-id-example
//
//  Created by Nazar Lesiv on 9/13/15.
//  Copyright (c) 2015 Nazar Lesiv. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    let password: String? = "password";
    var loginAttempts: Int? = 0;
    
    @IBOutlet weak var tblNotes: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //call the authentcation method.
        authenticateUser();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginSuccess() {
        print("LOGGED IN SUCCESSFULLY");
    }
    
    func showPasswordAlert() {
        
        var passwordField: UITextField?;
        
        var passwordAlert: UIAlertController = UIAlertController(title: "Title", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
        
        passwordAlert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Password";
            textField.secureTextEntry = true;
            
            //set the passwordField variable to the passed in textField.
            passwordField = textField;
        });
       
        //set the Login button view and handler closure.
        passwordAlert.addAction(UIAlertAction(title: "Login", style: UIAlertActionStyle.Default, handler: { action in
            
            println(passwordField?.text);
            println(self.loginAttempts);
            
            //increment the login attempt.
            self.loginAttempts?++;
            
            //if the password value is not empty validate the password.
            if(passwordField != nil && passwordField?.text !== "") {
                //if the password matches call on the sucess method. 
                if(passwordField?.text == self.password) {
                    self.loginSuccess();
                    return;
                }
            }
            
            //If the user didnt enter a password, display the promt again. 
            self.showPasswordAlert();
            
            
        }));
        passwordAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { action in
            print(action);
        }));
        
        self.presentViewController(passwordAlert, animated: true, completion: nil)
        
    }
    
    func authenticateUser() {
        //create a new error object.
        var error: NSError?;
        
        //authentication method. 
        var reasonString = "Authentication is needed to access your notes.";
        
        // Create a auth context.
        let context: LAContext = LAContext();
        
        //check if the device can uses biometric scanner. 
        if(context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error)) {
            [context .evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success: Bool, evalPolicyError: NSError?) -> Void in
                if (success) {
                    
                    //call the appropriate method on valid login.
                    
                } else {
                    //Show a message if authentication failed. 
                    //Show a password modal as fallback. 
                    print(evalPolicyError?.localizedDescription)
                    
                    switch (evalPolicyError!.code) {
                    case LAError.SystemCancel.rawValue:
                        print("Authentication was cancelled by the system");
                    
                    case LAError.UserCancel.rawValue:
                        print("Authentication was cancelled by the user");
                        
                    case LAError.UserFallback.rawValue:
                        print("User Selected to enter custom password");
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            self.showPasswordAlert();
                        });
                        
                    default:
                        print("Authentication Failed");
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            self.showPasswordAlert();
                        });
                        
                    }
                }
            })]
        } else {
            //Show an error if the security policy cannot be evaluated. 
            switch (error!.code){
            case LAError.TouchIDNotEnrolled.rawValue:
                print("TouchID is not enrolled");
            
            case LAError.PasscodeNotSet.rawValue:
                print("A Passcoce has not been set");
                
            default:
                //in the case a touchIDNotAvailable case. 
                print("TouchID not available");
                
            }
            
            //optionally the error description can be displayed in the console. 
            print(error?.localizedDescription);
            
            //show the password modal. 
            self.showPasswordAlert();
        }
        
    }
    
    


}

