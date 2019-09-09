//
//  AppConstants.swift
//  SwiftNews
//
//  Created by Vineet Sansare on 9/7/19.
//  Copyright © 2019 Loblaw. All rights reserved.
//

import Foundation
import UIKit

class AppConstants: NSObject {
    
    //MARK: System Info    
    static let APP_VERSION:String=(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String);
    static let DEVICE_MODEL = UIDevice.current.model;
    static let DEVICE_SYSTEM_VERSION = UIDevice.current.systemVersion
    
    //MARK: Colors
    static let TRANSLUCENT_COLOR:UIColor=UIColor(red:0.0/255.0,green:0.0/255.0,blue:0.0/255.0,alpha:0.8); // Translucent Color
    static let COLOR_1:UIColor=UIColor(red:80.0/255.0,green:227.0/255.0,blue:194.0/255.0,alpha:1.0); // SimensColor - 1st Brand color
    
    //MARK: Fonts
    static let HELVETICA_NEUE = "HelveticaNeue"
    static let HELVETICA_NEUE_BOLD = "HelveticaNeue-Bold"
}

