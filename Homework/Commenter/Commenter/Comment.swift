//
//  Comment.swift
//  Commenter
//
//  Created by Nathan VelaBorja on 1/31/17.
//  Copyright © 2017 Nathan VelaBorja. All rights reserved.
//

import Foundation

class Comment {
    var comment : String
    var date : Date
    
    init(_ comment: String, _ date: Date) {
        self.comment = comment
        self.date = date
    }
}
