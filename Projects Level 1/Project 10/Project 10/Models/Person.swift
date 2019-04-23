//
//  Person.swift
//  Project 10
//
//  Created by Fernando Mata on 4/23/19.
//  Copyright © 2019 Fernando Mata. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
