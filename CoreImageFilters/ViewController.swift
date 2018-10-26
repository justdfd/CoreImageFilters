//
//  ViewController.swift
//  CoreImageFilters
//
//  Created by Dave Dombrowski on 10/26/18.
//  Copyright © 2018 justDFD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // creates a [String] of all available filters
    // - if you want to restrict to a single category, replace nil with the category name
    // - on an iPad running iOS 12.0.1, 207 filters returned
    
    var ciFilterList = CIFilter.filterNames(inCategories: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // simple query for filter list
        
        print("=======")
        print("List of available filters")
        print("-------")
        for ciFilterName in ciFilterList {
            print(ciFilterName)
        }
        print("-------")
        print("Total: " + String(ciFilterList.count))
        
        // hard-coded example of getting attributes for an existing filter
        
        let filterName = "CIZoomBlur"
        let filter = CIFilter(name: filterName)
        print("=======")
        print("Filter Name: " + filterName)
         let inputKeys = filter?.inputKeys
        if inputKeys?.count == 0 {
            print("-------")
           print("No input attributes.")
        } else {
            for inputKey in inputKeys! {
                print("-------")
                print("Input Key: " + inputKey)
                if  let attribute = filter?.attributes[inputKey] as? [String: AnyObject],
                    let attributeClass = attribute[kCIAttributeClass] as? String,
                    let attributeDisplayName = attribute["CIAttributeDisplayName"] as? String {
                    print("Display name: " + attributeDisplayName)
                    print("Attrbute type: " + attributeClass)
                    switch attributeClass {
                    case "NSNumber":
                        let minimumValue = (attribute[kCIAttributeSliderMin] as! NSNumber).floatValue
                        let maximumValue = (attribute[kCIAttributeSliderMax] as! NSNumber).floatValue
                        let defaultValue = (attribute[kCIAttributeDefault] as! NSNumber).floatValue
                        print("Default value: " + String(defaultValue))
                        print("Minimum value: " + String(minimumValue))
                        print("Maximum value: " + String(maximumValue))
                    case "CIColor":
                        let defaultValue = attribute[kCIAttributeDefault] as! CIColor
                        print(defaultValue)
                    case "CIVector":
                        let defaultValue = attribute[kCIAttributeDefault] as! CIVector
                        print(defaultValue)
                    default:
                        // if you wish, just dump the variable attribute to look at everything!
                        print("No code to parse an attribute of type: " + attributeClass)
                        break
                    }
                }
            }
        }
        print("=======")
    }
}

