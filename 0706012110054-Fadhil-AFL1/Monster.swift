//
//  Monster.swift
//  0706012110054-Fadhil-AFL1
//
//  Created by MacBook Pro on 24/03/23.
//

import Foundation


protocol Monster{
    var monster_name: String { get set }
    var monster_HP: Int { get set }
    var monster_dmg: Int { get set }
    
    func awaken()
}
