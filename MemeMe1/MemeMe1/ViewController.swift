//
//  ViewController.swift
//  MemeMe1
//
//  Created by RhaXiel on 1/6/22.
//

import UIKit

class ViewController: UIViewController {
    
    //var count = 0
    //var label: UILabel!
    
    var count = 0
    @IBOutlet var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*
        //Label
        let label = UILabel()
        label.frame = CGRect(x: 150, y: 150, width: 60, height: 60)
        label.text = "0"
        view.addSubview(label)
        self.label = label
        
        //Button --ControlObject
        let button = UIButton()
        button.frame = CGRect(x: 150, y: 250, width: 60, height: 60)
        //button.displa = "Button"
        button.setTitle("Click", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        view.addSubview(button)
        
        button.addTarget(self, action: #selector(ViewController.incrementCount), for: .touchUpInside)
         */
        
    }
    /*
    @objc func incrementCount(){
        self.count += 1
        self.label.text = "\(self.count)"
    }
     */
    @IBAction func incrementCount(){
        self.count += 1
        self.label.text = "\(self.count)"
    }
    
    @IBAction func experimentActivityViewController(sender: UIButton){
        let image = UIImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        present(controller, animated: true)
    }
    @IBAction func experimentImagePicker(sender: UIButton){
        let nextController = UIImagePickerController()
        present(nextController, animated: true, completion: nil)
        
        present(nextController, animated: true)
    }
    @IBAction func experimentAlert(sender: UIButton){
        let controller = UIAlertController()
        
        controller.title = "Test alert"
        controller.message = "This is a test"
        
        let okAction = UIAlertAction(title: "Ok", style: .default){action in self.dismiss(animated: true)
            
        }
        
        controller.addAction(okAction)
        
        present(controller, animated: true)
        //dismiss(animated: true)
    }
    
    @IBAction func rollDice(){
        /*
        let controller: DiceViewController
        controller = storyboard?.instantiateViewController(withIdentifier: "DiceViewController") as! DiceViewController
        
        controller.firstValue = 1
        controller.secondValue = 2
        
        present(controller, animated: true)
         */
        performSegue(withIdentifier: "rollDice", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! DiceViewController
        
        controller.firstValue = 1
        controller.secondValue = 2
        
        
    }
}

