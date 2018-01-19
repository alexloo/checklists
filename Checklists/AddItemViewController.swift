//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Alex Loo on 1/16/18.
//  Copyright © 2018 BigCardinal. All rights reserved.
//

import Foundation
import UIKit

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        textField.becomeFirstResponder()
    }
    
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done() {
        print("Contents of textfield: \(textField.text!)")
        
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldString: String = textField.text!
        let swiftRange = Range(range, in: textField.text!)
        let newString: String = oldString.replacingCharacters(in: swiftRange!, with: string)
        
        doneBarButton.isEnabled = (newString.count > 0)
    
        return true
    }
}
