//
//  Api.swift
//  TVMaze
//
//  Created by Vitor Silveira on 07/04/2018.
//  Copyright © 2018 Vitor Silveira. All rights reserved.
//

import UIKit
import Alamofire

class Api: NSObject {
    static let shared = Api()
    var delegate: FeedDelegate!
    var baseUrl: String = "https://api.tvmaze.com/"

    func requestSearch(search: String) {
        let text = search.replacingOccurrences(of: " ", with: "+")
        Alamofire.request("\(baseUrl)search/shows?q=\(text)")
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                do {
                    let result: [SearchModel]? = try JSONDecoder().decode([SearchModel].self, from: response.data!)
                    self.delegate.response(status: 200, feed: result)
                } catch {
                    print("Json Error")
                    self.delegate.response(status: 400, feed: nil)
                }
        }
    }
}


