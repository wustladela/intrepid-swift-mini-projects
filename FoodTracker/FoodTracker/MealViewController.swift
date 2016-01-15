//
//  ViewController.swift
//  FoodTracker
//
//  Created by Adela Gao on 1/10/16.
//  Copyright © 2016 Adela Gao. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
        
    }
    @IBOutlet weak var mealInput: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBAction func mealButton(sender: UIButton) {
        updateUI()
        mealInput.resignFirstResponder()
    }
    /*
    This value is either passed by `MealTableViewController` in `prepareForSegue(_:sender:)`
    or constructed as part of adding a new meal.
    */
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        mealInput.delegate = self
        checkValidMealName()
        
        // load existing meal data if it exists
        if let meal = meal{
            navigationItem.title = meal.name
            mealInput.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        
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
        }
    }
    
    // help: how do I keep the original aspect ratio of the image?
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true) { () -> Void in
        }

    }

    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = self.mealInput.text ?? ""
            let photo = self.photoImageView.image
            let rating = self.ratingControl.rating
             
            // Set the meal to be passed to MealTableViewController after the unwind segue.
            meal = Meal(name: name, photo: photo, rating: rating)
            
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
    
    func textFieldDidBeginEditing(textField: UITextField) {
        saveButton.enabled = false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidMealName()
        navigationItem.title = mealInput.text
    }
    
    func checkValidMealName() {
        let text = mealInput.text ?? ""
        saveButton.enabled = isValidMealName(text)
    }
    
    func isValidMealName(text: String) -> Bool {
        return !text.isEmpty
    }
    
    //tap gestures - tap anywhere to finish editing
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.locationInView(view)
        if !CGRectContainsPoint(mealInput.frame, touchLocation) && mealInput.isFirstResponder() {
            mealInput.resignFirstResponder()
        }
        super.touchesBegan(touches, withEvent: event)
    }
    
}

