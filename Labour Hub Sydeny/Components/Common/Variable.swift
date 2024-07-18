//
//  Reusable.swift
//  Labour Hub Sydeny
//
//  Created by mac on 30/03/23.
//


import UIKit

var globalUserName          =       k.userDefault.value(forKey: "user_name")
var globalUserImage         =       k.userDefault.value(forKey: "user_image")

var localTimeZoneIdentifier: String { return
    TimeZone.current.identifier }

struct selectedItems
{
    var containArray: [ResClientProjectDetail] = []
    var isSelected: Bool!
    
    init(containArray: [ResClientProjectDetail], isSelected: Bool!) {
        self.containArray = containArray
        self.isSelected = isSelected
    }
}
