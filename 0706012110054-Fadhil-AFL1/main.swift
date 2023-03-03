//
//  main.swift
//  0706012110054-Fadhil-AFL1
//
//  Created by MacBook Pro on 02/03/23.
//

import Foundation

//Character Name


//action
var getHeal: Int = 20
var skill: [String] = ["Physical Attack", "Meteor", "Shield"]
var skill_dmg: [Int] = [5, 50, 0]
var skill_MP: [Int] = [0, 15, 10]
var usedMP: [String] = ["No Mana required", "Use \(skill_MP[1]) of MP", "Use \(skill_MP[2]) of MP"]

//menu
var start: String = ""
var menu: String = ""
var menuf: Int = 0
var back: String = ""
var heal: String = ""
//var heal2: String = ""

//player
var player_name: String = ""
var player_HP: Int = 50
var player_MP: Int = 50
var potion: Int = 20
var elixir: Int = 10

//Monster
var monster_name: [String] = ["Troll", "Golem"]
var monster_HP: [Int] = [1000, 1000]


welcomeScreen()


func welcomeScreen(){
    print("""
    ===== Welcome to the World of Magic ===== 🧙‍♂️
    you have been choosen to embark on an epic journey as a young wizard on the path to becoming a master of the
    \t\tarcane arts. Your adventures will take you through forest 🌲, mountains ⛰️, and dungeons 🏰, where you will
    \t\tface challenges, make allies, and fight enemies.

    press [return] to continue:
    """, terminator: " ")
    start = readLine()!
    
    switch start{
    case "":
        gameStart()
    default:
        welcomeScreen()
    }
}


func gameStart(){
    print("\nMay i know your name, a young wizard?", terminator: " ")
    player_name = readLine()!
    
    print("Nice to meet you \(player_name)!")
    journeyScreen()
    
    
}

func journeyScreen(){
    while true{
        
    
    print("""
\nFrom here, you can...

[C]heck your health and stat
[H]eal your wounds with potion

...or, choose where you want to go

[F]orest of Troll
[M]ountain of Golem
[Q]uit game

your choice?
""", terminator: " ")
    menu = readLine()!.uppercased()
    
    if (menu == "C" ){
        playerStat()
    }else if(menu == "H" ){
        Healing()
    }else if(menu == "F" ){
        Forest()
    }else if(menu == "M" ){
        print("Mountain")
    }else if(menu == "Q"){
        exit(1)
    }
}
}


func playerStat(){
    while true{
        print("\n=== Player Status ===")
        print("""
    Player Name: \(player_name)
    
    HP: \(player_HP)/100
    MP: \(player_MP)/50
    
    == Magic ==
    """)
        for (index, item) in skill.enumerated(){
            print("- \(item). \(usedMP[index])pt of MP. \(skill_dmg[index])pt of damage")
        }
        
        print("""
    == Item ==
    - Potion. Heal 20pt of your HP
    - Elixir. add 10pt of your MP
    """)
        
        
        print("""
    Press [return] to go back:
    """, terminator: " ")
        menu = readLine()!
        
        switch menu{
        case "":
            journeyScreen()
        default:
            print("")
        }
    }
}
     
func Healing(){
    
        if(potion == 0){
            print("""
            You don't have ny potion left. Be careful of your next journey.
            press [return] to go back:
            """, terminator: " ")
            back = readLine()!
        }else {
                print("""
                \nYour HP is \(player_HP)
                You have \(potion) potion
                
                are you sure want to use 1 potion to heal wound? [Y/N]
                """, terminator: " ")
                heal = readLine()!.uppercased()
                
                if(heal == "Y" ){
                    if(potion == 0){
                        print("""
                            \nYou don't have ny potion left. Be careful of your next journey.
                            press [return] to go back:
                        """, terminator: " ")
                        back = readLine()!
                        
                        switch back{
                        case "":
                            journeyScreen()
                        default:
                            Healing()
                        }
                    }else{
                            healingAgain()
                        }
                }else{
                    journeyScreen()
                }
        }
    }
      
func healingAgain(){
    if (player_HP < 100){
        player_HP = player_HP + getHeal
        potion = potion - 1
        print("""
        \nYour HP is now: \(player_HP)
        You have \(potion) potion left
    
        Still want to use 1 potion to heal wound again? [Y/N]
    """, terminator: " ")
        heal = readLine()!.uppercased()
        
        if(heal == "Y"){
            healingAgain()
        }else{
            journeyScreen()
        }
    }else if(player_HP >= 100){
        print("\nYour HP is already healed, please use heal wisely")
    }
}
    
func Forest(){
    if (monster_HP[monster_name.firstIndex(of: "Troll")!] <= 0){
        print("Congratulatons, You've defeat the Troll")
        journeyScreen()
    }
    print("""
        As you enter the forest, you feel a sense of unease watch over you.
        Suddenly, you hear the sound of twigs snapping behind you. You quickly turn around , and find a Troll emerging
        from the shadows.
    
        👿    Name    : Troll
        👿    Health  : \(monster_HP[0])
    
        Choose your action:
        [1] Physical Attack. No mana required. Deal 5pt of damage.
        [2] Meteor. Use 15pt of MP. Deal 50pt of damage.
        [3] Shield. Use 10pt of MP. Block enemy's attack in 1 turn.
        
        [4] Use potion to Heal your wound
        [5] Scan enemy's vital
        [6] Flee from the battle
    
        Your Choice:
    """, terminator: " ")
    menuf = Int(readLine()!)!
    
    switch menuf{
    case 1:
        monster_HP[monster_name.firstIndex(of: "Troll")!] -= skill_dmg[0]
        Forest()
    case 2:
        monster_HP[monster_name.firstIndex(of: "Troll")!] -= skill_dmg[1]
        Forest()
    case 3:
        Forest()
    case 4:
       Healing()
    case 5:
        print("")
    case 6:
        print("""
            You feel that if you don't escape soon, you won't be able to continue the fight.
        You look around frantically, searching for the way out. You sprint towards the exit, your hearth pounding in your
        chest.
        
        You're safe now
        Press [return] to continue:
        """, terminator: "")
        back = readLine()!
        
        switch back{
        case "":
            journeyScreen()
        default:
            Forest()
        }
    default:
        print("Please choose action from one of menu")
        Forest()
    }
}

func Mountain(){
    
}


