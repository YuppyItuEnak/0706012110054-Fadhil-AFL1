//
//  Potion.swift
//  0706012110054-Fadhil-AFL1
//
//  Created by MacBook Pro on 24/03/23.
//

import Foundation


class Potion: Items{
    var Restore_HP: Int
    
    init(name: String, description: String, amount: Int, Restore_HP: Int) {
        self.Restore_HP = Restore_HP
        super.init(name: name, description: description, amount: amount)
    }
    
}
