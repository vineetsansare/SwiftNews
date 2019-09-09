//
//  DOBOConstants.swift
//  SwiftNews
//
//  Created by Vineet Sansare on 9/7/19.
//  Copyright © 2019 Loblaw. All rights reserved.
//

import Foundation

struct DOBOConstants
{
    static let BASE_URL_OF_SERVER : String = "https://www.reddit.com/";
    
    enum HTTPMethodType
    {
        case Get
    }
    
    enum ServerError:String
    {
        case Unauthenticated = "Unauthenticated."
        case NetworkUnreachable = "Network not reachable"
    }
}


