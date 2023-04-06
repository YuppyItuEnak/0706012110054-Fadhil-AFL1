//
//  Troll.swift
//  0706012110054-Fadhil-AFL1
//
//  Created by MacBook Pro on 04/04/23.
//

import Foundation

struct Troll: Monster{
    var monster_name: String
    var monster_HP: Int
    var monster_dmg: Int
    
    
    init(monster_name: String, monster_HP: Int, monster_dmg: Int) {
        self.monster_name = monster_name
        self.monster_HP = monster_HP
        self.monster_dmg = monster_dmg
    }
    
    func awaken() {
        print("""
\n!!!!!!!!!!!!! WARNING !!!!!!!!!!!!!
        You make the Troll Mad
the Troll has awaken to Troll King

        the damage increase
         please be careful
!!!!!!!!!!!!! WARNING !!!!!!!!!!!!!\n
""")
      
    }
}
