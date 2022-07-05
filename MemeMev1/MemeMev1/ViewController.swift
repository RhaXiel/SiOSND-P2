//
//  ViewController.swift
//  MemeMev1
//
//  Created by RhaXiel on 5/6/22.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var topText: UITextField!
    
    @IBOutlet weak var bottomText: UITextField!
    
    @IBOutlet weak var topBar: UIToolbar!
    
    @IBOutlet weak var bottomBar: UIToolbar!
    
    var image: UIImage!
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black ,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: Float(-4),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.topText.delegate = self
        self.bottomText.delegate = self
        
        initializeText(self.topText, "TOP")
        initializeText(self.bottomText, "BOTTOM")
        
        subscribeToKeyboardNotifications()
        
    }
    
    func initializeText(_ textField: UITextField, _ text: String){
        textField.defaultTextAttributes = self.memeTextAttributes
        textField.textAlignment = NSTextAlignment.center
        textField.text = text
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        pickAnImage(self, .photoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        pickAnImage(self, .camera)
    }
    
    func pickAnImage(_ delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate, _ sourceType: UIImagePickerController.SourceType){
        let pickerController = UIImagePickerController()
        pickerController.delegate = delegate
        pickerController.sourceType = sourceType
        present(pickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            imagePickerView.image = image
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if bottomText.isFirstResponder {
            
            view.frame.origin.y = getKeyboardHeight(notification) * (-1)
        }
        
    }
    @objc func keyboardWillHide(_ notification:Notification) {
        if bottomText.isFirstResponder {
            view.frame.origin.y = 0.0
        }
        
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:))    , name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func save(memedImage : UIImage) {
        // Create the meme
        _ = Meme(topText: self.topText.text!, bottomText: self.bottomText.text!, originalImage: self.imagePickerView.image!, memedImage: generateMemedImage())
    }
    
    func generateMemedImage() -> UIImage {
        
        topBar.isHidden = true
        bottomBar.isHidden = true
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        topBar.isHidden = false
        bottomBar.isHidden = false
        
        return memedImage
    }
    
    
    @IBAction func share(_ sender: Any) {
        let memedImage = generateMemedImage()
        let activitycontorller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        present(activitycontorller, animated: true, completion: nil)
        activitycontorller.completionWithItemsHandler = { activity , success , item , error -> Void in
            if success{
                self.save(memedImage: memedImage)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}

