//
//  FollowerAPIClient.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/04/27.
//  Copyright © 2018年 darquro. All rights reserved.
//

import Foundation
import TwitterKit

class FollowerAPIClient {
    
    let method = "GET"
    let endpoint = URL(string: "https://api.twitter.com/1.1/followers/list.json")!
    var isLoading = false
    
    func fetch(completion: @escaping (Result<FollowerResponse, RequestErrors>) -> Void) {
        let parameters = [
            "count": "200"
        ]
        request(parameters: parameters) { completion($0) }
    }
    
    func fetch(nextCursor: String, completion: @escaping (Result<FollowerResponse, RequestErrors>) -> Void) {
        guard let nextCursorInt = Int(nextCursor), nextCursorInt > 0 else {
            completion(Result(error: .requestError))
            return
        }
        let parameters = [
            "count": "200",
            "cursor": "\(nextCursor)"
        ]
        request(parameters: parameters) { completion($0) }
    }
    
    private func request(parameters: Dictionary<String, String>, completion: @escaping (Result<FollowerResponse, RequestErrors>) -> Void) {
        guard let session = TWTRTwitter.sharedInstance().sessionStore.session() else {
            completion(Result(error: .requestError))
            return
        }
        guard !isLoading else {
            completion(Result(error: .requestError))
            return
        }
        isLoading = true
        /*
         guard let request = TwitterURLRequestGenerator.generate(method: method, endpoint: endpoint, parameters: parameters)
         else {
            return
         }
         */
        let client = TWTRAPIClient(userID: session.userID)
        var clientError : NSError?
        let request = client.urlRequest(withMethod: method, urlString: endpoint.absoluteString, parameters: parameters, error: &clientError)
        Log.d("request \(request.url?.absoluteString ?? "")")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            defer {
                self.isLoading = false
            }
            if let error = error {
                Log.d("Error: \(error.localizedDescription)")
                completion(Result(error: .requestError))
                return
            }
            guard let data = data, let _ = response else {
                Log.d("response error")
                completion(Result(error: .responseError))
                return
            }
            
            do {
                let response = try FollowerResponse.decode(from: data)
                completion(Result(value: response))
                return
            } catch let error {
                Log.d("json decoding error: \(error.localizedDescription)")
                completion(Result(error: .responseError))
                return
            }
        }
        task.resume()
    }
}
