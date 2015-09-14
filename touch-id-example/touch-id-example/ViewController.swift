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
    
    func showPasswordAlert() {
        
        var passwordField: UITextField?
        
        var passwordAlert: UIAlertController = UIAlertController(title: "Title", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
        
        passwordAlert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Password";
            textField.secureTextEntry = true;
            
            //set the passwordField variable to the passed in textField.
            passwordField = textField;
        });
       
        passwordAlert.addAction(UIAlertAction(title: "Login", style: UIAlertActionStyle.Default, handler: { action in
            //print(action);
            //print(passwordField);
            print(passwordField?.text);
            
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

