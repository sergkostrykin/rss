//
//  URNNetworking.swift
//  URNNetworking
//
//  Created by Sergiy Kostrykin on 5/29/19.
//  Copyright © 2019 SSK. All rights reserved.
//

import Foundation
import FeedKit

open class URNNetworking: NSObject {
    
    typealias Completion = (RSSFeed?, URLResponse?, Error?) -> Void
    
    enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
    
    class func startTask(for urlString: String, parameters: [String: String] = [:], body: Data? = nil, method: Method? = nil, completion: Completion?) {
        var url: URL?
        do {
            url = try URNNetworking.url(for: urlString, parameters: parameters)
        } catch {
            completion?(nil, nil, error)
            return
        }
        
        guard let requestUrl = url else {
            let error = NSError.standard(message: "URL not found")
            completion?(nil, nil, error)
            return
        }
        
        var request = URLRequest(url: requestUrl)
        
        request.httpMethod = method != nil ? method!.rawValue : body == nil ? "GET" : "POST"
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                if (error as NSError).code != NSURLErrorCancelled {
                    completion?(nil, response, error)
                }
                return
            }

            guard
                let data = data
                else {
                    let error = NSError.standard(message: "Error Loading Data")
                    completion?(nil, response, error)
                    return
            }
            
            let parser = FeedParser.init(data: data)
            parser.parseAsync(result: { (result) in
                switch result {
                case .rss(let feed):
                    completion?(feed, response, error)
                case .failure(let parseError):
                    completion?(nil, response, parseError)

                default:
                    let dateError = NSError.standard(message: "Error Loading Data")
                    completion?(nil, response, dateError)
                }
            })
            
        }
        
        task.resume()
    }
    
    static func url(for urlString: String, parameters: [String: String] = [:]) throws -> URL {
        var str = urlString
        for parameter in parameters {
            let value = parameter.value
            guard let validValue = value.addingPercentEncoding(withAllowedCharacters: []) else {
                let error = NSError.standard(message: "Error Loading Data")
                throw error
            }
            str += str == urlString ? "?" : "&"
            str += parameter.key + "=" + validValue
        }
        guard let url = URL(string: str) else {
            let error = NSError.standard(message: "URL not found")
            throw error
        }
        return url
    }
    
    
    class func fetchRSSFeed(type: FeedType, completion: ((RSSFeed?, Error?) -> Void)?) {
        switch type {
        case .business:
            fetchNews(completion: completion)
        case .entertainment:
            var entertainment = [RSSFeedItem]()
            var environment = [RSSFeedItem]()
            var rssError: Error?
            
            let group = DispatchGroup()
            let queue = DispatchQueue.global()

            let entertainmentWorkItem = DispatchWorkItem {
                group.enter()
                fetchEntertainment(completion: { (feed, error) in
                    rssError = error
                    entertainment = feed?.items ?? [RSSFeedItem]()
                    group.leave()
                })
            }

            let environmentWorkItem = DispatchWorkItem {
                group.enter()
                fetchEntertainment(completion: { (feed, error) in
                    rssError = error
                    environment = feed?.items ?? [RSSFeedItem]()
                    group.leave()
                })
            }

            queue.async(group: group, execute: entertainmentWorkItem)
            queue.async(group: group, execute: environmentWorkItem)
        
            group.notify(queue: .main) {
                if let error = rssError {
                    completion?(nil, error)
                    return
                }
                let feed = RSSFeed()
                feed.items = entertainment + environment
                completion?(feed, nil)
            }
        }
    }

    class func fetchNews(completion: ((RSSFeed?, Error?) -> Void)?) {
        let path = URNNetworkingConstants.baseUrl + "/reuters/businessNews"
        URNNetworking.startTask(for: path, parameters: [:]) { rss, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion?(nil, error)
                }
                return
            }
            completion?(rss, nil)
            
        }
    }

    class func fetchEntertainment(completion: ((RSSFeed?, Error?) -> Void)?) {
        let path = URNNetworkingConstants.baseUrl + "/reuters/entertainment"
        URNNetworking.startTask(for: path, parameters: [:]) { rss, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion?(nil, error)
                }
                return
            }
            completion?(rss, nil)
            
        }
    }
    
    class func fetchEnvironment(completion: ((RSSFeed?, Error?) -> Void)?) {
        let path = URNNetworkingConstants.baseUrl + "/reuters/environment"
        URNNetworking.startTask(for: path, parameters: [:]) { rss, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion?(nil, error)
                }
                return
            }
            completion?(rss, nil)
            
        }
    }

}

extension URNNetworking: XMLParserDelegate {
//    public func parserDidStartDocument(_ parser: XMLParser) {
//        
//    }
//    
//    public func parserDidEndDocument(_ parser: XMLParser) {
//        
//    }
    
    
}
