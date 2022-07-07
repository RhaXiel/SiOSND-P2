//
//  MemeDetailViewController.swift
//  MemeMev1
//
//  Created by RhaXiel on 6/7/22.
//

import UIKit

class MemeDetailViewController: UIViewController {

        var meme: Meme! = nil
     
        @IBOutlet weak var memeImage: UIImageView!
        @IBOutlet weak var editButton: UINavigationBar!
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            memeImage.image = meme.memedImage
        }
        
       
        @IBAction func cancelAction(_ sender: AnyObject) {
            dismiss(animated: true, completion: nil)
        }
        
        override var prefersStatusBarHidden : Bool {
            return true
        }
    
}
