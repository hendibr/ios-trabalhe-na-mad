//
//  PullOwner.swift
//  Mad
//
//  Created by hendi on 12/03/17.
//  Copyright © 2017 cuca. All rights reserved.
//

import Foundation
import Gloss

struct PullOwner: Decodable {
    
    let name: String?
    let photoURL: String?
    
    init?(json: JSON) {
        self.name = "login" <~~ json
        self.photoURL = "avatar_url" <~~ json
    }
}
