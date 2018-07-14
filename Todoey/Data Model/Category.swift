//
//  Category.swift
//  Todoey
//
//  Created by Zhuo Chen on 2018/7/13.
//  Copyright © 2018年 Zhuo Chen. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object{
    @objc dynamic var name : String = ""
    let items = List<Item>()//category里面下属的item 比如category是buy item就是buy里面的比如 milk egg等等
}
