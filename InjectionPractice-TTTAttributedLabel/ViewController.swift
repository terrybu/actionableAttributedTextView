//
//  ViewController.swift
//  InjectionPractice-TTTAttributedLabel
//
//  Created by Terry Bu on 11/9/15.
//  Copyright © 2015 Terry Bu. All rights reserved.
//

import UIKit
import TTTAttributedLabel

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Create an attributed string
        let myString = NSMutableAttributedString(string: "Swift attributed text")
        
        
        // Set an attribute on part of the string
        let myRange = NSRange(location: 0, length: 5) // range of "Swift"
        let myCustomAttribute = [ "MyCustomAttributeName": "some value"]
        myString.addAttributes(myCustomAttribute, range: myRange)
        myString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: myRange)
        
        myString.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFontOfSize(16.0), range: myRange)
        
        textView.attributedText = myString
        
        // Add tap gesture recognizer to Text View
        let tap = UITapGestureRecognizer(target: self, action: Selector("terryMethodHandleTap:"))
        tap.delegate = self
        textView.addGestureRecognizer(tap)
    }
    
    func terryMethodHandleTap(sender: UITapGestureRecognizer) {
        let myTextView = sender.view as! UITextView
        let layoutManager = myTextView.layoutManager
        
        // location of tap in myTextView coordinates and taking the inset into account
        var location = sender.locationInView(myTextView)
        location.x -= myTextView.textContainerInset.left;
        location.y -= myTextView.textContainerInset.top;
        
        // character index at tap location
        let characterIndex = layoutManager.characterIndexForPoint(location, inTextContainer: myTextView.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        // if index is valid then do something.
        if characterIndex < myTextView.textStorage.length {
            
            // print the character index
            print("character index: \(characterIndex)")
            
            // print the character at the index
            let myRange = NSRange(location: characterIndex, length: 1)
            let substring = (myTextView.attributedText.string as NSString).substringWithRange(myRange)
            print("character at index: \(substring)")
            
            // check if the tap location has a certain attribute
            let attributeName = "MyCustomAttributeName"
            let attributeValue = myTextView.attributedText.attribute(attributeName, atIndex: characterIndex, effectiveRange: nil) as? String
            if let value = attributeValue {
                print("You tapped on \(attributeName) and the value is: \(value)")
                let weirdView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
                weirdView.backgroundColor = UIColor.brownColor()
                view.addSubview(weirdView)
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

