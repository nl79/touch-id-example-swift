//
//  EditNoteViewController.swift
//  touch-id-example
//
//  Created by Nazar Lesiv on 9/13/15.
//  Copyright (c) 2015 Nazar Lesiv. All rights reserved.
//

import UIKit

class EditNoteViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtNoteTitle: UITextField!
    
    @IBOutlet weak var tvNoteBody: UITextView!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.txtNoteTitle.becomeFirstResponder();
        
        txtNoteTitle.delegate = self;
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //Resign the textfield from first responder. 
        textField.resignFirstResponder();
        
        //Make the textview the first responder. 
        tvNoteBody.becomeFirstResponder();
        
        return true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveNote(sender: AnyObject) {
        if self.txtNoteTitle.text.isEmpty {
            println("No Title for the note was typed.");
            return; 
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
