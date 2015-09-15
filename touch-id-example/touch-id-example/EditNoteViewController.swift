//
//  EditNoteViewController.swift
//  touch-id-example
//
//  Created by Nazar Lesiv on 9/13/15.
//  Copyright (c) 2015 Nazar Lesiv. All rights reserved.
//

import UIKit

protocol EditNoteViewControllerDelegate {
    func noteWasSaved();
}

class EditNoteViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtNoteTitle: UITextField!
    
    @IBOutlet weak var tvNoteBody: UITextView!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var delegate: EditNoteViewControllerDelegate?;
    
    var indexOfEditedNote: Int!; 

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.txtNoteTitle.becomeFirstResponder();
        
        txtNoteTitle.delegate = self;
    }
    
    override func viewDidAppear(animated: Bool) {
        if(indexOfEditedNote != nil) {
            editNote();
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //Resign the textfield from first responder. 
        textField.resignFirstResponder();
        
        //Make the textview the first responder. 
        tvNoteBody.becomeFirstResponder();
        
        return true;
    }
    
    func editNote() {
        //Load All notes. 
        var notesArray: NSArray = NSArray(contentsOfFile: appDelegate.getPathOfDataFile())!;
        
        //get the dictionary at the specified index. 
        let noteDict: Dictionary = notesArray.objectAtIndex(indexOfEditedNote) as! Dictionary<String, String>;
        
        //set the textfield text. 
        txtNoteTitle.text = noteDict["title"];
        
        //Set the textview text. 
        tvNoteBody.text = noteDict["body"];
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveNote(sender: AnyObject) {
        
        //check if the textNoteTitle is empty.
        if self.txtNoteTitle.text.isEmpty {
            println("No Title for the note was typed.");
            return; 
        }
        
        //Create a dictionary with the note data. 
        var noteDict = ["title": self.txtNoteTitle.text, "body":self.tvNoteBody.text];
        
        //Declare a NSMutableArray object. 
        var dataArray: NSMutableArray;
        
        //If the notes data file exists, then load its contentts and add the new. 
        if (appDelegate.checkIfDataFileExists()) {
            //load any existing notes. 
            dataArray = NSMutableArray(contentsOfFile: appDelegate.getPathOfDataFile())!;
            
            //Add the dictionary to the array. 
            //dataArray.addObject(noteDict);
            //check if editing a note or not. 
            if(indexOfEditedNote == nil) {
                // Add the dictionary to the array. 
                dataArray.addObject(noteDict);
            } else {
                //replace the existing dictionary in the array. 
                dataArray.replaceObjectAtIndex(indexOfEditedNote, withObject: noteDict); 
            }
        } else {
            // Create a new mutable array and add the noteDict object it. 
            dataArray = NSMutableArray(object: noteDict);
        }
        
        //Save the array contets to file. 
        dataArray.writeToFile(appDelegate.getPathOfDataFile(), atomically: true);
        
        //Notify the delegate class that the note has been saved. 
        delegate?.noteWasSaved(); 
        
        //pop the view controller. 
        self.navigationController!.popViewControllerAnimated(true);
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
