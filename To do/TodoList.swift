//
//  TodoList.swift
//  To do
//
//  Created by Takuma Jimbo on 2017/02/18.
//  Copyright © 2017年 Takuma Jimbo. All rights reserved.
//

import UIKit

class TodoList: NSObject {
    
    var title: String
    var body: String
    var date: Date
    
    init(title: String, body: String, date: Date) {
        self.title = title
        self.body = body
        self.date = date
    }
    
}
