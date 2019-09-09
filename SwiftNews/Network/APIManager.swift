//
//  APIManager.swift
//  SwiftNews
//
//  Created by Vineet Sansare on 9/7/19.
//  Copyright © 2019 Loblaw. All rights reserved.
//

import Foundation

typealias ServiceResponse = (Any?, Error?) -> Void

class APIManager: NSObject
{
    static let sharedInstance = APIManager()
    
    func makeHTTPRequest(path: String, method: String = "GET", body: [String: Any] = [String: Any](), onCompletion: @escaping ServiceResponse)
    {
        guard let url = URL(string: path) else
        {
            print("Error: cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        if case "POST" = method
        {
            request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json",forHTTPHeaderField: "Accept")
            do
            {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            }
            catch let error
            {
                onCompletion([:], error)
            }
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else
            {
                onCompletion([:], error)
                return
            }
            
            //            let json:JSON = JSON(data: data)
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            print(responseJSON)
            onCompletion(responseJSON, error)
        })
        task.resume()
    }
}

