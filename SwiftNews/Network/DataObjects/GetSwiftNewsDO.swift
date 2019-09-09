//
//  GetSwiftNewsDO.swift
//  SwiftNews
//
//  Created by Vineet Sansare on 9/7/19.
//  Copyright © 2019 Loblaw. All rights reserved.
//

import Foundation

class GetSwiftNewsDO: BaseDO {
    
    override func methodType() -> DOBOConstants.HTTPMethodType {
        return .Get
    }
    
    override func methodName()->String? {
        return "r/swift/.json"
    }
    
    override func prepareRequestWithParameters(parameters: AnyObject?...) {
        let getSwiftNewsRequest: GetSwiftNewsRequest =  GetSwiftNewsRequest()
        request=getSwiftNewsRequest
    }
    
    override func parse() {
        do {
            self.responseData  = try  JSONDecoder().decode(GetSwiftNewsResponse.self, from: self.jsonData) as AnyObject
        }
        catch {
            print(error)
        }
    }
}
