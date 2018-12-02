//
//  NetWorker.swift
//  ToDoFIRE
//
//  Created by Nugumanov Dmitry on 11/29/18.
//  Copyright © 2018 Nugumanov Dmitry. All rights reserved.
//

import Foundation

enum Values {
    static let link = "https://pozzad-email-validator.p.rapidapi.com/emailvalidator/validateEmail/"
}
enum Keys {
    static let APIKey = "nnRAFziCLomshXSemkkjFG4sgcHPp1Noe74jsn5HuEx0IBqzhN"
}

class NetWorker {
    
    /// Validate Email Verification
    ///
    /// - Parameters:
    ///   - email: This user's email address will be checked for confirmation
    ///   - completion: Function response result
    
    
    func checkEmail(email: String, completion: @escaping (Bool?, Error?) -> Void) {
        guard let url = URL(string: Values.link + email) else {
            completion(nil, nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(Keys.APIKey, forHTTPHeaderField: "X-RapidAPI-Key")
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(nil, error)
                print(error)
                return
            }
            
            guard let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []),
                let dict = json as? [String: Bool],
                let asnwer = dict["isValid"]
                    else {
                        completion(nil, nil)
                        return
                }
            
            completion(asnwer, nil)
        }
        task.resume()
    }
    
    
}
