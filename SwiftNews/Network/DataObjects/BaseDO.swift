//
//  BaseDO.swift
//  NewsApp
//
//  Created by Vineet Sansare on 9/7/19.
//  Copyright © 2019 Loblaw. All rights reserved.
//

import Foundation
import Alamofire

class BaseDO {
    
    //MARK: Accessors
    var request: BaseRequest?
    var jsonData: Data!
    var responseData: AnyObject!
    var serverErrorBO: ServerErrorBO? = nil
    
    //MARK: Internal Methods
    func methodType()->DOBOConstants.HTTPMethodType {
        return DOBOConstants.HTTPMethodType.Get
    }
    
    func baseURL()-> String? {
        return DOBOConstants.BASE_URL_OF_SERVER
    }
    
    func methodName()-> String? {
        return nil
    }
    
    func prepareRequestWithParameters(parameters:AnyObject?...)-> Void {
        
    }
    
    func requestParameters()->Dictionary<String,AnyObject>? {
        return nil
    }
    
    func encoding()-> ParameterEncoding {
        return URLEncoding.default
    }
    
    func queryTheServer(baseDO:@escaping (BaseDO)->Void)-> Void {
        
        if(!Connectivity.isConnectedToInternet()) {
            self.serverErrorBO=ServerErrorBO(errorText: DOBOConstants.ServerError.NetworkUnreachable.rawValue)
            baseDO(self)
        } else {
            // We have internet connectivity and therefore we can hit the web API.
            if(self.methodType() == DOBOConstants.HTTPMethodType.Get) {
                print("\n ***** GET METHOD ***** \n")
                print(self.baseURL()! + self.methodName()!)
                
                let headers = [
                    "cache-control": "no-cache",
                    "Accept": "application/json",
                    "Content-Type":"application/json"
                ]
                
                Alamofire.request((self.baseURL()! + self.methodName()!), method: .get, parameters: self.requestParameters(), encoding: self.encoding(), headers: headers).responseJSON(completionHandler: { (response) in
                    
                    if let JSON_DATA = response.data {
                        self.jsonData = JSON_DATA
                        self.parse()
                        baseDO(self)
                    } else {
                        /*
                         This block is called if response.result.value has a 'nil' value, which means the server has returned with some error
                         This block can also be called if statusCode is 'nil' which might be a case when the network is not reachable.
                         */
                        
                        let statusCode = response.response?.statusCode
                        
                        if(statusCode != nil) {
                            if(statusCode != 200) {
                                self.serverErrorBO=ServerErrorBO(errorText: self.getServerErrorString(statusCode: statusCode!))
                                baseDO(self)
                            }
                        } else if(statusCode == nil) {
                            self.serverErrorBO=ServerErrorBO(errorText: "Network not reachable.")
                            baseDO(self)
                        }
                    }
                })
            }
        }
    }
    
    func parse()-> Void {
        
    }
    
    //MARK: Private Methods
    
    private func getServerErrorString(statusCode:Int) -> String {
        
        var errorString:String = ""
        
        switch statusCode {
        case 400:
            errorString = "The request is missing a required parameter, includes an unsupported parameter value, repeats a parameter or is otherwise malformed"
        case 500:
            errorString = "Unknown error"
        default:
            errorString = "OK"
        }
        
        return errorString
    }
}

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
