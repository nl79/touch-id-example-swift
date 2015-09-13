//
//  EditNoteViewController.swift
//  touch-id-example
//
//  Created by Nazar Lesiv on 9/13/15.
//  Copyright (c) 2015 Nazar Lesiv. All rights reserved.
//

import UIKit

class EditNoteViewController: UIViewController {
    
    @IBOutlet weak var txtNoteTitle: UITextField!
    
    @IBOutlet weak var tvNoteBody: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
