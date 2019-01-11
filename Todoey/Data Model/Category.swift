//
//  Category.swift
//  Todoey
//
//  Created by zed kh on 1/10/19.
//  Copyright © 2019 artech.dz. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name: String = ""
    
    let items = List<Item>()
}
