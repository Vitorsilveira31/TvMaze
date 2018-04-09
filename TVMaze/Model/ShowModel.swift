//
//  ShowModel.swift
//  TVMaze
//
//  Created by Vitor Silveira on 08/04/2018.
//  Copyright © 2018 Vitor Silveira. All rights reserved.
//

import Foundation

struct ShowModel: Decodable {
    let id: Int
    let name: String
    let genres: [String]?
    let premiered: String?
    let image: ImageModel?
    let summary: String?
}
