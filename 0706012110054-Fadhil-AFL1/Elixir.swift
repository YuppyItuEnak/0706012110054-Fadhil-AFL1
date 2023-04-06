//
//  Elixir.swift
//  0706012110054-Fadhil-AFL1
//
//  Created by MacBook Pro on 24/03/23.
//

import Foundation

class Elixir: Items{
    var restore_MP: Int
    
    init(name: String, description: String, amount: Int, restore_MP: Int) {
        self.restore_MP = restore_MP
        super.init(name: name, description: description, amount: amount)
    }
}
