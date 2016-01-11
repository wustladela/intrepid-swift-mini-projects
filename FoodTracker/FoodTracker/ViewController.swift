//
//  ViewController.swift
//  FoodTracker
//
//  Created by Adela Gao on 1/10/16.
//  Copyright © 2016 Adela Gao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var mealInput: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBAction func mealButton(sender: UIButton) {
        updateUI()
        mealInput.resignFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mealInput.delegate = self
    }
    // MARK: UIImagePickerControllerDelegate
    // The first of these, imagePickerControllerDidCancel(_:), gets called when a user taps the image picker’s Cancel button. This method gives you a chance to dismiss the UIImagePickerController (and optionally, do any necessary cleanup). Implement imagePickerControllerDidCancel(_:) to do that.
    
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        mealInput.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        photoImageView.image = selectedImage
        dismissViewControllerAnimated(true) { () -> Void in
            print ("finished picker!")
        }
    }
    
    // help: how do I keep the original aspect ratio of the image?
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true) { () -> Void in
            print("canceled picker!")
        }

    }


    // MARK: Actions
    
    func updateUI(){
        mealNameLabel.text = mealInput.text
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

