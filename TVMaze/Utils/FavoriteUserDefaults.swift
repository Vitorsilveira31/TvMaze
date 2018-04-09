//
//  FavoriteUserDefaults.swift
//  TVMaze
//
//  Created by Vitor Silveira on 08/04/2018.
//  Copyright © 2018 Vitor Silveira. All rights reserved.
//

import Foundation

class FavoriteUserDefaults {
    
    static let shared = FavoriteUserDefaults()
    
    let key = "favorite"
    var item: [Int] = []
    
    func remove(index: Int) {
        self.item = recover()
        self.item.remove(at: index)
        UserDefaults.standard.set(self.item, forKey: self.key)
    }
    
    func save(id: Int){
        self.item = recover()
        self.item.append(id)
        UserDefaults.standard.set(self.item, forKey: self.key)
    }
    
    func recover() -> Array<Int> {
        let data = UserDefaults.standard.object(forKey: self.key)
        if data != nil {
            return data as! Array<Int>
        } else {
            return []
        }
    }
}
