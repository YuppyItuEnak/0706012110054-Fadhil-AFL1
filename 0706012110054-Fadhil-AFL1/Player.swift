//
//  Player.swift
//  0706012110054-Fadhil-AFL1
//
//  Created by MacBook Pro on 24/03/23.
//

import Foundation


class Player{
    var player_name: String
    var player_Hp: Int = 100
    var player_MP: Int = 50
    var scan_vital: Bool = false
    var Block: Bool = false
    
    init(player_name: String) {
        self.player_name = player_name
    }
    
    func usingSkill(skill: Skill){
        if(skill is Physical_attack){
            let usePhysicalAttack = skill as! Physical_attack
            
            player_MP -=  usePhysicalAttack.skill_usage
        }else if(skill is Meteor){
            let useMeteor = skill as! Meteor
            
            player_MP -= useMeteor.skill_usage
        }else if(skill is Shield){
            let useShield = skill as! Shield
            
            player_MP -= useShield.skill_usage
        }
    }
    
    func usingItem(item: Items){
        if (item is Potion){
            let potion = item as! Potion
            
            player_Hp += potion.Restore_HP
            potion.amount -= 1
        }else if(item is Elixir){
            let elixir = item as! Elixir
            
            player_MP += elixir.restore_MP
            elixir.amount -= 1
        }
    }
}


