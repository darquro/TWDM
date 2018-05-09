//
//  TwitterURLRequestGenerator.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/04/27.
//  Copyright © 2018年 darquro. All rights reserved.
//

import Foundation
import TwitterKit

class TwitterURLRequestGenerator {
    
    static func generate(method: String, endpoint: URL, parameters: [String: String]?) -> URLRequest? {
        guard var urlComponents = URLComponents(string: endpoint.absoluteString) else {
            return nil
        }
        if let parameters = parameters {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        guard let url = urlComponents.url else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        guard let session = TWTRTwitter.sharedInstance().sessionStore.session() else {
            return nil
        }
        var oauthParams:Dictionary<String, String> = [:]
        if let parameters = parameters {
            parameters.forEach {
                oauthParams[$0.key] = $0.value
            }
        }
        oauthParams["oauth_token"] = session.authToken
        oauthParams["oauth_version"] = "1.0"
        oauthParams["oauth_signature_method"] = "HMAC-SHA1"
        oauthParams["oauth_consumer_key"] = TWTRTwitter.sharedInstance().authConfig.consumerKey
        oauthParams["oauth_timestamp"] = String(Int64(Date().timeIntervalSince1970))
        oauthParams["oauth_nonce"] = String.random(42)
        oauthParams["oauth_signature"] = generateSignature(method: method, url: endpoint, query: oauthParams, session: session)
        
        let authorizationString = oauthParams.map {
            return "\($0.key)=\"\($0.value)\""
        }.joined(separator: ", ")
        let authorizationValue = "OAuth \(authorizationString)"
        Log.d(authorizationValue)
        
        urlRequest.addValue("OAuth \(authorizationValue)", forHTTPHeaderField: "Authorization")
        return urlRequest
    }
    
    static func generateSignature(method: String, url: URL, query: Dictionary<String, String>, session: TWTRAuthSession) -> String {
        let value = generateSignatureBaseString(method: method, url: url, query: query)
            .hmac(algorithm: .SHA1, key: generateSignatureSigninKey(session: session))
        let encoded = value.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        return encoded!
    }
    
    static func generateSignatureBaseString (method: String, url: URL, query: Dictionary<String, String>) -> String {
        let urlEncoded = url.absoluteString.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        let queryEncoded = query.map {
                return "\($0.key)%3D\($0.value)"
            }.joined(separator: "%26")
        
        guard let urlComponent = urlEncoded else {
            return ""
        }
        
        let baseString = "\(method)&\(urlComponent)&\(queryEncoded)"
        Log.d(baseString)
        return baseString
    }
    
    static func generateSignatureSigninKey(session: TWTRAuthSession) -> String {
        return "\(TWTRTwitter.sharedInstance().authConfig.consumerSecret)&\(session.authTokenSecret)"
    }
    
}
