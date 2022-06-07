//
//  DiceViewController.swift
//  MemeMe1
//
//  Created by RhaXiel on 4/6/22.
//

import UIKit

class DiceViewController: UIViewController {
    
    
    var firstValue: Int!
    var secondValue: Int!
    
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let firstValue = self.firstValue {
            self.firstLabel.text = "\(firstValue)"
        }else{
            self.firstLabel.text = nil
        }
        if let secondValue = self.secondValue {
            self.secondLabel.text = "\(secondValue)"
        }else{
            self.secondLabel.text = nil
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
