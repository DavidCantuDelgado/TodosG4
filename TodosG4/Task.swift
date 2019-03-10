//
//  Task.swift
//  TodosG4
//
//  Created by David A Cantú Delgado on 3/4/19.
//  Copyright © 2019 Tec de Monterrey. All rights reserved.
//

import UIKit

class Task: NSObject {
    
    var task: String
    var category: String
    var status: Bool
    
    init(task: String, category: String, status: Bool) {
        self.task = task
        self.category = category
        self.status = status
    }

}
