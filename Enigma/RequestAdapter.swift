//
//  RequestAdapter.swift
//  Enigma
//
//  Created by Christian Bollig on 13.11.20.
//  Copyright © 2020 SevenPrinciples. All rights reserved.
//

import UIKit

enum NetworkError: Error {
    case badURL
    case badData
}
class RequestAdapter: NSObject, URLSessionDelegate {

    static let current: RequestAdapter = RequestAdapter()

    private var sharedSessionHolder: URLSession?
    internal func sharedSession() -> URLSession {
        guard sharedSessionHolder == nil else {
            return sharedSessionHolder!
        }

        let sessionConfig = URLSessionConfiguration.default
        sharedSessionHolder = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)

        return sharedSessionHolder!
    }

    func getID(completionHandler: @escaping (Swift.Result<(HTTPURLResponse, Data), NetworkError>) -> Void) {

        // Build up the URL
        guard let url = URL(string: "http://5.45.106.224:8080/enigma/session") else {
            completionHandler(.failure(.badURL))
            return
        }

        // Generate and execute the request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = sharedSession().dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completionHandler(.failure(.badURL))
                    return
                }
                completionHandler(.success((response, data)))
            }
        }
        task.resume()
    }

    func getMessage(reciever: String, completionHandler: @escaping (Swift.Result<(HTTPURLResponse, Data), NetworkError>) -> Void) {

        // Build up the URL
        guard let url = URL(string: "http://5.45.106.224:8080/enigma/message/\(reciever)") else {
            completionHandler(.failure(.badURL))
            return
        }

        // Generate and execute the request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = sharedSession().dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completionHandler(.failure(.badURL))
                    return
                }
                completionHandler(.success((response, data)))
            }
        }
        task.resume()
    }

    func sendMSG(msg: String, sender: String, reciever: String, completionHandler: @escaping (Swift.Result<(HTTPURLResponse, Data), NetworkError>) -> Void) {

        // Build up the URL
        guard let url = URL(string: "http://5.45.106.224:8080/enigma/message") else {
            completionHandler(.failure(.badURL))
            return
        }

        // Generate and execute the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        var header: [String:String] = [:]
        header["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = header

        var dict: [String:Any] = ["receiverId":reciever]
        let message: [String:Any] = ["senderId": sender, "text": msg]
        dict["message"] = message
        do {
            let data = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            request.httpBody = data
        } catch {
            return completionHandler(.failure(.badData))
        }

        let task = sharedSession().dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {

                guard let data = data, let response = response as? HTTPURLResponse else {
                    completionHandler(.failure(.badURL))
                    return
                }
                completionHandler(.success((response, data)))
            }
        }
        task.resume()
    }
}
