//
//  RestInterfacer.swift
//  SADJZIOS
//
//  Created by Afshawn Lotfi on 12/4/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation


public enum RequestType:String{
    case POST
    case GET
}


public class RestInterfacer<T : Codable, S : Codable> {
    
    
    private let session = URLSession.shared

    @discardableResult public func getRequest(endpoint : RestEndpoints, args : String?, token : String?, completionHandler: @escaping (T?, Error?) -> Void) -> URLSessionTask {
        let request = self.createRequest(requestType: RequestType.GET, endpoint: endpoint, args: args, token: token)
        return dataTask(request: request, completionHandler: completionHandler);
    }
    
    @discardableResult public func postRequest(endpoint : RestEndpoints, model : S, args : String?, token : String?, completionHandler: @escaping (T?, Error?) -> Void) -> URLSessionTask {
        let request = self.createRequest(requestType: RequestType.POST, endpoint: endpoint, args: args, token: token)
        let encoder = JSONEncoder();
        let sendModel = try? encoder.encode(model)
        if let serializedData = sendModel{
            request.httpBody = serializedData
        }else{
            completionHandler(nil, NSError(domain:"EncodingError", code:0, userInfo:[ NSLocalizedDescriptionKey: "Could not encode model"]));
        }
        return dataTask(request: request, completionHandler: completionHandler);
    }
    
    
    
    
    private func dataTask(request : NSMutableURLRequest, completionHandler: @escaping (T?, Error?) -> Void) -> URLSessionTask {
    
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                
                completionHandler(nil, error );
                return;
                
                
            } else {
                
                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder();
                    let deserailized = try decoder.decode(T.self, from: data);
                    completionHandler(deserailized, nil );
                    
                } catch let err {
                    completionHandler(nil, err);
                }
            }
        })
        
        dataTask.resume();
    
        return dataTask;
    
    }
    
    
    
    private func createRequest(requestType : RequestType, endpoint : RestEndpoints, args : String?,token : String?) -> NSMutableURLRequest{
        
        var headers: [String : String] = [:];
        headers["Content-Type"] =  "application/json"
        if (token != nil){
            headers["Authorization"] =  "Bearer " + token!;
        }
        var address = "http://" + AppReference.serverAddress + ":5000/" + endpoint.rawValue;
        if (args != nil){
            address += "/" + args!
        }
        let request = NSMutableURLRequest(url: NSURL(string: address)! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = requestType.rawValue
        request.allHTTPHeaderFields = headers
        return request;
    }
    
    
    
    
}

