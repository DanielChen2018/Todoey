//
//  Item.swift
//  Todoey
//
//  Created by Zhuo Chen on 2018/7/13.
//  Copyright © 2018年 Zhuo Chen. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")//用来连接item和category的关系 代表这个item是category下属里面的
}
