//
//  RatingControl.swift
//  MyFoodTracker
//
//  Created by Adela Gao on 1/10/16.
//  Copyright © 2016 Adela Gao. All rights reserved.
//

import UIKit

class RatingControl: UIView {

// MARK: Properties
    var rating = 0
    var ratingButtons = [UIButton]()
    var spacing = 5
    var stars = 5
    
// MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        for _ in 0..<stars{
            let button = UIButton()
            button.backgroundColor = UIColor.redColor()
            button.addTarget(self, action: "ratingButtonPressed:", forControlEvents: .TouchDown)
            ratingButtons += [button]
            addSubview(button)
            
        }
        
    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize + spacing) * stars
        return CGSize(width: width, height: buttonSize)
    }
    
    override func layoutSubviews() {
        // Set the button's width and height to a square the size of the frame's height.

        let buttonSize = Int(frame.size.height)
        
        var buttonFrame = CGRect (x: 0, y: 0, width: buttonSize, height: buttonSize)
        for (index, button) in ratingButtons.enumerate(){
            //The enumerate() method returns a collection that contains elements in the ratingButtons array paired with their indexes. This is a collection of tuples—groupings of values—and in this case, each tuple contains an index and a button.
            buttonFrame.origin.x = CGFloat(index*(buttonSize+5))
            button.frame = buttonFrame
        }
    }
    
    // MARK: Button Action
    
    func ratingButtonPressed(button: UIButton){
        if (button.backgroundColor == UIColor.redColor()){
            button.backgroundColor = UIColor.greenColor()
        } else {
            button.backgroundColor = UIColor.redColor()
        }
        
        
    }
}
