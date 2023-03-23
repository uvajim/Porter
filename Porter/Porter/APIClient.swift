//
//  APIClient.swift
//  Porter
//
//  Created by Jinming Liang on 3/15/23.
//

import Foundation
import StripeTerminal

// Example API client class for communicating with your backend
class APIClient: ConnectionTokenProvider {

    // For simplicity, this example class is a singleton
    static let shared = APIClient()

    // Fetches a ConnectionToken from your backend
    func fetchConnectionToken(_ completion: @escaping ConnectionTokenCompletionBlock) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let jsonData = "{\"function\": \"1\"}"
        guard let url = URL(string: "https://6sqf7z7lqalemeowuzmgzeukcm0imgsw.lambda-url.us-east-1.on.aws")
        else {
            fatalError("Invalid backend URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData.data(using: .utf8)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    
                    // Warning: casting using `as? [String: String]` looks simpler, but isn't safe:
                    
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                        print("Error")
                        return // handle error
                    }
                    print(type(of: json))
                    if let secret = json["secret"] as? String {
                        completion(secret, nil)
                    }
                    else {
                        let error = NSError(domain: "com.stripe-terminal-ios.example",
                                            code: 2000,
                                            userInfo: [NSLocalizedDescriptionKey: "Missing `secret` in ConnectionToken JSON response"])
                        completion(nil, error)
                    }
                    print("HERE IS THE DATA: \(json)")
                    
                }
                catch {
                    completion(nil, error)
                }
            }
            else {
                let error = NSError(domain: "com.stripe-terminal-ios.example",
                                    code: 1000,
                                    userInfo: [NSLocalizedDescriptionKey: "No data in response from ConnectionToken endpoint"])
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    func capturePaymentIntent(_ paymentIntentId: String, completion: @escaping ErrorCompletionBlock) {
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config, delegate: nil, delegateQueue: OperationQueue.main)
            let url = URL(string: "/capture_payment_intent")

            let parameters = "{\"payment_intent_id\": \"\(paymentIntentId)\"}"

            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = parameters.data(using: .utf8)

            let task = session.dataTask(with: request) {(data, response, error) in
                if let response = response as? HTTPURLResponse, let data = data {
                    switch response.statusCode {
                    case 200..<300:
                        completion(nil)
                    case 402:
                        let description = String(data: data, encoding: .utf8) ?? "Failed to capture payment intent"
                        completion(NSError(domain: "com.stripe-terminal-ios.example", code: 2, userInfo: [NSLocalizedDescriptionKey: description]))
                    default:
                        completion(error ?? NSError(domain: "com.stripe-terminal-ios.example", code: 0, userInfo: [NSLocalizedDescriptionKey: "Other networking error encountered."]))
                    }
                } else {
                    completion(error)
                }
            }
            task.resume()
        }
}
