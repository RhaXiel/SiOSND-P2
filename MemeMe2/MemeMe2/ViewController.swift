//
//  ViewController.swift
//  MemeMe2
//
//  Created by RhaXiel on 5/6/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var characterCountLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.textField.delegate = self
    }
    
    /*
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return self.editingSwitch.isOn
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    */
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Figure out what the new text will be, if we return true
           var newText = textField.text! as NSString
           newText = newText.replacingCharacters(in: range, with: string) as NSString

           // hide the label if the newText will be an empty string
           self.characterCountLabel.isHidden = (newText.length == 0)

           // Write the length of newText into the label
           self.characterCountLabel.text = String(newText.length)

           // returning true gives the text field permission to change its text
           return true;

    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
            textField.text = ""
        }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            
            return true;
        }
    /*
    @IBAction func toggleTheTextEditor(_ sender: AnyObject) {
            
            if !(sender as! UISwitch).isOn {
                self.textField3.resignFirstResponder()
            }
        }
     */
}

