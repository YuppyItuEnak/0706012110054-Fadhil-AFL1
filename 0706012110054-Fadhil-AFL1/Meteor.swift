//
//  Meteor.swift
//  0706012110054-Fadhil-AFL1
//
//  Created by MacBook Pro on 24/03/23.
//

import Foundation

class Meteor: Skill{
    var damage: Int
    
    init(skill_name: String, Skill_usage: Int, description: String,damage: Int) {
        self.damage = damage
        super.init(skill_name: skill_name, skill_usage: Skill_usage, description: description)
    }
}
