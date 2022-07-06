//
//  MemeTableViewController.swift
//  MemeMev1
//
//  Created by RhaXiel on 5/7/22.
//

import Foundation
import UIKit

class MemeTableViewController: UITableViewController, UIViewControllerTransitioningDelegate {
    
    
    var memes: [Meme]!{
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    ///Optimized
    //var memes: [Meme] {
    //       return (UIApplication.shared.delegate as! AppDelegate).memes
    //   }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let meme = memes[(indexPath as NSIndexPath).row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell", for: indexPath) as! MemeTableViewCell
        cell.memeLabel.text = "\(meme.topText) ... \(meme.bottomText)" //Posibble null values?
        cell.memeImageView.image = meme.memedImage
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        //detailViewController.meme = memes[(indexPath as NSIndexPath).row]
        detailViewController.topText.text = self.memes[(indexPath as NSIndexPath).row].topText
        detailViewController.bottomText.text = self.memes[(indexPath as NSIndexPath).row].bottomText
        detailViewController.image = self.memes[(indexPath as NSIndexPath).row].originalImage
        navigationController!.pushViewController(detailViewController, animated: true)
    }
    
    // MARK: Push details VC
    /*
    override var prefersStatusBarHidden : Bool {
        return true
    }
     */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
