//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Alex Loo on 1/16/18.
//  Copyright © 2018 BigCardinal. All rights reserved.
//

import Foundation

class ChecklistItem {
    var text = ""
    var checked = false

    func toggleChecked() {
        checked = !checked
    }
}
