//
//  Checklist.swift
//  Checklists
//
//  Created by Alex Loo on 1/22/18.
//  Copyright © 2018 BigCardinal. All rights reserved.
//

import UIKit

class Checklist: NSObject {
    var name = ""
    
    init(name: String) {
        self.name = name
        super.init()
    }
}
