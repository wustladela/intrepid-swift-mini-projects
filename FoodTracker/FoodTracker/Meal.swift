//
//  Meal.swift
//  MyFoodTracker from FoodTracker at https://developer.apple.com/library/ios/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Lesson10.html#//apple_ref/doc/uid/TP40015214-CH14-SW1
//
//  Created by Adela Gao on 1/10/16.
//  Copyright © 2016 Adela Gao. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding {
    // MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Archiving Paths
    // Outside of the Meal class, you’ll access the path using the syntax Meal.ArchiveURL.path!
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")
    
    // MARK: PropertyKey notes
    //the behavior in the Meal class to save and load the meal.
    //Using the NSCoding approach, the Meal class is in charge of --storing and loading each of its properties--. 
    // It needs to save its data by assigning the value of each property to a particular key, and load the data by looking up the information associated with that key.
    // A key is simply a string value. You choose your own keys based on what makes the most sense in your app. For example, you might use the key “name” to store the value of the name property.
    // To make it clear which coding key corresponds to each piece of data, create a structure to store the key strings.
    
    // MARK: Types
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let ratingKey = "rating"
    }
    
    // MARK: Notes for initializers
    // Recall that an initializer is a method that prepares an instance of a class for use, which involves setting an initial value for each property and performing any other setup or initialization.
    // this designated initializer has to call its superclass's initializer???..."A designated initializer fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain."
    //"Classes tend to have very few designated initializers, and it is quite common for a class to have only one. Designated initializers are “funnel” points through which initialization takes place, and through which the initialization process continues up the superclass chain. Every class must have at least one designated initializer. "
    
    // MARK: Initialization
    init? (name: String, photo: UIImage?, rating: Int){
        self.name = name
        self.photo = photo
        self.rating = rating
        super.init()
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeInteger(rating, forKey: PropertyKey.ratingKey)
        
    }
    // implement the initializer to decode the encoded data.
    required convenience init?(coder aDecoder: NSCoder) {
        // using the forced type cast operator (as!) because if the object can’t be cast as a String, or if it’s nil, something has gone wrong and the error should cause a crash at runtime.
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        let rating = aDecoder.decodeIntegerForKey(PropertyKey.ratingKey)
        self.init(name: name, photo: photo, rating: rating)
    }
    
    
}