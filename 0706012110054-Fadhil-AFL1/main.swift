//
//  main.swift
//  0706012110054-Fadhil-AFL1
//
//  Created by MacBook Pro on 02/03/23.
//

import Foundation

//menu
var start: String = ""
var menu: String = ""
var menufight: Int = 0
var back: String = ""
var heal: String = ""
var use_elixir: String = ""

//player
var player: Player = Player(player_name: "")

//Inisialisasi item yang dimiliki oleh Player
var myItem = Items(name: "Inventory", description: "have Potion and Elixir", amount: 2)
var myPotion = Potion(name: "Potion", description: "Heal 20pt of your HP", amount: 10, Restore_HP: 20)
var myElixir = Elixir(name: "Elixir", description: "Heal 10pt of your HP", amount: 10, restore_MP: 10)

//Inisialisasi skill yang dimiliki Player
var mySkill = Skill(skill_name: "My Skill", skill_usage: 1, description: "Skill that player have")
let myPhysicalAttack = Physical_attack(skill_name: "Physical Attack", Skill_usage: 0, description: "No Mana Requiered", damage: 5)
let myMeteor = Meteor(skill_name: "Meteor", Skill_usage: 15, description: "use 15pt of MP", damage: 20)
let myShield = Shield(skill_name: "Shield", Skill_usage: 10, description: "Use 10pt of MP", damage: 0)

var player_name: String = ""
var skillmultiple: Int = 0


//Monster

//Inisialisasi Monster dan membentuk array agar jenis monster beragam yang ada di Forest screen maupun Mountain Screen
var enemies_forest: [Monster] = [
    Troll(monster_name: "Minion", monster_HP: 50, monster_dmg: 5),
    Troll(monster_name: "Fire Troll", monster_HP: 80, monster_dmg: 8),
    Troll(monster_name: "Troll", monster_HP: 100, monster_dmg: 10)
]
var enemies_mountain: [Monster] = [
    Golem(monster_name: "Golem", monster_HP: 90, monster_dmg: 10),
    Golem(monster_name: "Ice Golem", monster_HP: 100, monster_dmg: 15),
    Golem(monster_name: "Diamond Golem", monster_HP: 120, monster_dmg: 20)
]

//Boolean untuk memberikan efek monster awakening ketika darah monster dibawah 30
var monster_awakens: Bool = false

// Randomize monster yang berada di Forest Screen yang akan dilawan player
let randomIndexForest = (0..<enemies_forest.count).randomElement() ?? 0
var selectedMonsterForest = enemies_forest[randomIndexForest]

//Randomize monster yang berada di Mountain Screen yang akan dilawan player
let randomIndexMountain = (0..<enemies_mountain.count).randomElement() ?? 0
var selectedMonsterMountain = enemies_mountain[randomIndexMountain]



//Screen Play
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
    while true{
        print("\nMay i know your name, a young wizard?", terminator: " ")
        player_name = readLine()!
        
        let LetterCharacterSet = CharacterSet.letters
        let InputCharacter = CharacterSet(charactersIn: player_name)
        
        if(LetterCharacterSet.isSuperset(of: InputCharacter)){
            print("Nice to meet you \(player_name)!")
            player = Player(player_name: player_name)
            journeyScreen()
        }else{
            print("\nInvalid Input: Please input only letters ")
        }
    }
    
}


func journeyScreen(){
    //Untuk meng off kan efek scan vital player
    player.scan_vital = false
    
    //Untuk meng off kan efek monster awakening
    monster_awakens = false
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
            playerStatus()
        }else if(menu == "H" ){
            Healing()
        }else if(menu == "F" ){
            Forest()
        }else if(menu == "M" ){
            Mountain()
        }else if(menu == "Q"){
            exit(1)
        }
    }
}



//Player Status
func playerStatus(){
    while true{
        print("\n=== Player Status ===")
        print("""
    Player Name: \(player_name)
    
    HP: \(player.player_Hp)/100
    MP: \(player.player_MP)/50
    
    == Magic ==
    - \(myPhysicalAttack.skill_name), \(myPhysicalAttack.description). deal \(myPhysicalAttack.damage)pt of Damage
    - \(myMeteor.skill_name), \(myMeteor.description). deal \(myMeteor.damage)pt of Damage
    - \(myShield.skill_name), \(myShield.description). deal \(myShield.damage)pt of Damage
    
    \n== Item ==
    - \(myPotion.name). \(myPotion.description)
    - \(myElixir.name). \(myElixir.description)

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



// ACTION FIGHT THE MONSTER
func Forest(){
    
    
    //Function untuk take turn attacking monster
    func MonsterAttackTroll(){
        if (selectedMonsterForest.monster_HP <= 0){
            print("Congratulations, You've defeat the Troll")
            journeyScreen()
        }else if monster_awakens == true{
            selectedMonsterForest.monster_dmg = selectedMonsterForest.monster_dmg * 2
            player.player_Hp -= selectedMonsterForest.monster_dmg
            print("\nThe monster hit you \(selectedMonsterForest.monster_dmg)pt of Damage\n")
        }else{
            player.player_Hp = player.player_Hp - selectedMonsterForest.monster_dmg
            print("\nThe monster hit you \(selectedMonsterForest.monster_dmg)pt of Damage\n")
        }
        
    }
    
    //Function untuk melakukan penambahan damage jika user melakukan scan vital pada monster
    func SkillMultipleForest(){
        skillmultiple = myPhysicalAttack.damage * 10
    }
    
    
    if(player.player_Hp <= 0){
        print("""
\n===========GAME OVER===========
You're dead, please choose your action carefully
===========GAME OVER===========\n
""")
        journeyScreen()
    }
    
    
    if selectedMonsterForest.monster_HP <= 30{
        monster_awakens = true
        selectedMonsterForest.awaken()
    }
    
    
    
    
    if selectedMonsterForest.monster_name == "Minion" {
        print("""
            As you enter the forest, you feel a sense of unease watch over you.
            Suddenly, you hear the sound of twigs snapping behind you. You quickly turn around , and find a Troll emerging
            from the shadows.
        
            👿    Name    : \(selectedMonsterForest.monster_name)
            👿    Health  : \(selectedMonsterForest.monster_HP)
        
            Choose your action:
            [1] Physical Attack. No mana required. Deal 5pt of damage.
            [2] Meteor. Use 15pt of MP. Deal 50pt of damage.
            [3] Shield. Use 10pt of MP. Block enemy's attack in 1 turn.
            
            [4] Use potion to Heal your wound
            [5] Use Elixir
            [6] Scan enemy's vital
            [7] Flee from the battle
        
            Your Choice:
        """, terminator: " ")
        menufight = Int(readLine()!)!
        
        switch menufight{
        case 1:
            if (player.scan_vital == true){
                SkillMultipleForest()
                selectedMonsterForest.monster_HP -= skillmultiple
                MonsterAttackTroll()
                Forest()
            }else{
                selectedMonsterForest.monster_HP -= myPhysicalAttack.damage
                MonsterAttackTroll()
                Forest()
            }
            
        case 2:
            selectedMonsterForest.monster_HP -= myMeteor.damage
            player.usingSkill(skill: myMeteor)
            MonsterAttackTroll()
            Forest()
        case 3:
            player.usingSkill(skill: myShield)
            Forest()
        case 4:
            Healing()
        case 5:
            if(player.player_MP < 50){
                addElixir()
            }else{
                print("Your MP is already full, you can't use it")
                Forest()
            }
        case 6:
            print("""
\n========================================
The Monster vital is on the head, Use skill Physical Attack to Kill the monster
========================================\n
""")
            player.scan_vital = true
            Forest()
        case 7:
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
        
        
        
    }else if selectedMonsterForest.monster_name == "Fire Troll"{
        print("""
            As you enter the forest, you feel a sense of unease watch over you.
            Suddenly, you hear the sound of twigs snapping behind you. You quickly turn around , and find a Troll emerging
            from the shadows.
        
            👿    Name    : \(selectedMonsterForest.monster_name)
            👿    Health  : \(selectedMonsterForest.monster_HP)
        
            Choose your action:
            [1] Physical Attack. No mana required. Deal 5pt of damage.
            [2] Meteor. Use 15pt of MP. Deal 50pt of damage.
            [3] Shield. Use 10pt of MP. Block enemy's attack in 1 turn.
            
            [4] Use potion to Heal your wound
            [5] Use Elixir
            [6] Scan enemy's vital
            [7] Flee from the battle
        
            Your Choice:
        """, terminator: " ")
        menufight = Int(readLine()!)!
        
        switch menufight{
        case 1:
            if (player.scan_vital == true){
                SkillMultipleForest()
                selectedMonsterForest.monster_HP -= skillmultiple
                MonsterAttackTroll()
                Forest()
            }else{
                selectedMonsterForest.monster_HP -= myPhysicalAttack.damage
                MonsterAttackTroll()
                Forest()
            }
            
        case 2:
            selectedMonsterForest.monster_HP -= myMeteor.damage
            player.usingSkill(skill: myMeteor)
            MonsterAttackTroll()
            Forest()
        case 3:
            player.usingSkill(skill: myShield)
            Forest()
        case 4:
            Healing()
        case 5:
            if(player.player_MP < 50){
                addElixir()
            }else{
                print("Your MP is already full, you can't use it")
                Forest()
            }
        case 6:
            print("""
\n========================================
The Monster vital is on the head, Use skill Physical Attack to Kill the monster
========================================\n
""")
            player.scan_vital = true
            Forest()
        case 7:
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
    }else if selectedMonsterForest.monster_name == "Troll"{
        print("""
            As you enter the forest, you feel a sense of unease watch over you.
            Suddenly, you hear the sound of twigs snapping behind you. You quickly turn around , and find a Troll emerging
            from the shadows.
        
            👿    Name    : \(selectedMonsterForest.monster_name)
            👿    Health  : \(selectedMonsterForest.monster_HP)
        
            Choose your action:
            [1] Physical Attack. No mana required. Deal 5pt of damage.
            [2] Meteor. Use 15pt of MP. Deal 50pt of damage.
            [3] Shield. Use 10pt of MP. Block enemy's attack in 1 turn.
            
            [4] Use potion to Heal your wound
            [5] Use Elixir
            [6] Scan enemy's vital
            [7] Flee from the battle
        
            Your Choice:
        """, terminator: " ")
        menufight = Int(readLine()!)!
        
        switch menufight{
        case 1:
            if (player.scan_vital == true){
                SkillMultipleForest()
                selectedMonsterForest.monster_HP -= skillmultiple
                MonsterAttackTroll()
                Forest()
            }else{
                selectedMonsterForest.monster_HP -= myPhysicalAttack.damage
                MonsterAttackTroll()
                Forest()
            }
            
        case 2:
            selectedMonsterForest.monster_HP -= myMeteor.damage
            player.usingSkill(skill: myMeteor)
            MonsterAttackTroll()
            Forest()
        case 3:
            player.usingSkill(skill: myShield)
            Forest()
        case 4:
            Healing()
        case 5:
            if(player.player_MP < 50){
                addElixir()
            }else{
                print("Your MP is already full, you can't use it")
                Forest()
            }
        case 6:
            print("""
\n========================================
The Monster vital is on the head, Use skill Physical Attack to Kill the monster
========================================\n
""")
            player.scan_vital = true
            Forest()
        case 7:
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
    }else{
        print("""
\n===============
INVALID ERROR
===============\n
""")
    }
    
    
    
   
}

func Mountain(){
    
    //Function untuk take turn attacking monster
    func MonsterAttackGolem(){
        if (selectedMonsterMountain.monster_HP <= 0){
            print("""
\n============ YOU WIN ============
Congratulations, You've defeat the Golem
============ YOU WIN ============\n
""")
            journeyScreen()
        }else if monster_awakens == true{
            selectedMonsterMountain.monster_dmg = selectedMonsterMountain.monster_dmg * 2
            player.player_Hp = player.player_Hp - selectedMonsterMountain.monster_dmg
            print("\nThe monster hit you \(selectedMonsterMountain.monster_dmg)pt of Damage\n")
        }else{
            player.player_Hp = player.player_Hp - selectedMonsterMountain.monster_dmg
            print("\nThe monster hit you \(selectedMonsterMountain.monster_dmg)pt of Damage\n")
        }
        
    }
    
    if selectedMonsterMountain.monster_HP <= 50{
        monster_awakens = true
        selectedMonsterMountain.awaken()
    }
    
    //Function untuk melakukan penambahan damage jika user melakukan scan vital pada monster
    func SkillMultipleMountain(){
        skillmultiple = myMeteor.damage * 2
    }
    
    if(player.player_Hp <= 0){
        print("""
\n===========GAME OVER===========
You're dead, please choose your action carefully
===========GAME OVER===========\n
""")
        journeyScreen()
    }
    
   
    
    if selectedMonsterMountain.monster_name == "Golem"{
        print("""
            As you make your way through the rugged mountain terrain, you can feel the chill of the wind bitting of your skin.
            Suddenly, you hear a sound that make you freeze in your tracks. that's when you see it - a massive, snarling
            Golem emerging from the shadows
        
            👿    Name    : \(selectedMonsterMountain.monster_name)
            👿    Health  : \(selectedMonsterMountain.monster_HP)
        
            Choose your action:
            [1] Physical Attack. No mana required. Deal 5pt of damage.
            [2] Meteor. Use 15pt of MP. Deal 50pt of damage.
            [3] Shield. Use 10pt of MP. Block enemy's attack in 1 turn.
            
            [4] Use potion to Heal your wound
            [5] Use Elixir
            [6] Scan enemy's vital
            [7] Flee from the battle
        
            Your Choice:
        """, terminator: " ")
        menufight = Int(readLine()!)!
        
        switch menufight{
        case 1:
            MonsterAttackGolem()
            selectedMonsterMountain.monster_HP -= myPhysicalAttack.damage
            Mountain()
        case 2:
            if(player.scan_vital == true){
                SkillMultipleMountain()
                selectedMonsterMountain.monster_HP -= skillmultiple
                player.usingSkill(skill: myMeteor)
                MonsterAttackGolem()
                Mountain()
            }else{
                selectedMonsterMountain.monster_HP -= myMeteor.damage
                player.usingSkill(skill: myMeteor)
                MonsterAttackGolem()
                Mountain()
            }
            
        case 3:
            player.usingSkill(skill: myShield)
            Mountain()
        case 4:
            Healing()
        case 5:
            addElixir()
        case 6:
            print("""
                  \n========================================
                  The Monster vital is in the core, use Skill meteor to kill the monster
                  ========================================\n
                  """)
            player.scan_vital = true
            Mountain()
        case 7:
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
                Mountain()
            }
        default:
            print("Please choose action from one of menu")
            Mountain()
        }
    }else if selectedMonsterMountain.monster_name == "Ice Golem"{
        print("""
            As you make your way through the rugged mountain terrain, you can feel the chill of the wind bitting of your skin.
            Suddenly, you hear a sound that make you freeze in your tracks. that's when you see it - a massive, snarling
            Golem emerging from the shadows
        
            👿    Name    : \(selectedMonsterMountain.monster_name)
            👿    Health  : \(selectedMonsterMountain.monster_HP)
        
            Choose your action:
            [1] Physical Attack. No mana required. Deal 5pt of damage.
            [2] Meteor. Use 15pt of MP. Deal 50pt of damage.
            [3] Shield. Use 10pt of MP. Block enemy's attack in 1 turn.
            
            [4] Use potion to Heal your wound
            [5] Use Elixir
            [6] Scan enemy's vital
            [7] Flee from the battle
        
            Your Choice:
        """, terminator: " ")
        menufight = Int(readLine()!)!
        
        switch menufight{
        case 1:
            
            MonsterAttackGolem()
            selectedMonsterMountain.monster_HP -= myMeteor.damage
            Mountain()
        case 2:
            if(player.scan_vital == true){
                SkillMultipleMountain()
                selectedMonsterMountain.monster_HP -= skillmultiple
                player.usingSkill(skill: myMeteor)
                MonsterAttackGolem()
                Mountain()
            }else{
                selectedMonsterMountain.monster_HP -= myMeteor.damage
                player.usingSkill(skill: myMeteor)
                MonsterAttackGolem()
                Mountain()
            }
            
        case 3:
            player.usingSkill(skill: myShield)
            Mountain()
        case 4:
            Healing()
        case 5:
            addElixir()
        case 6:
            print("""
                  \n========================================
                  The Monster vital is in the core, use Skill meteor to kill the monster
                  ========================================\n
                  """)
            player.scan_vital = true
            Mountain()
        case 7:
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
                Mountain()
            }
        default:
            print("Please choose action from one of menu")
            Mountain()
        }
    }else if selectedMonsterMountain.monster_name == "Diamond Golem"{
        print("""
            As you make your way through the rugged mountain terrain, you can feel the chill of the wind bitting of your skin.
            Suddenly, you hear a sound that make you freeze in your tracks. that's when you see it - a massive, snarling
            Golem emerging from the shadows
        
            👿    Name    : \(selectedMonsterMountain.monster_name)
            👿    Health  : \(selectedMonsterMountain.monster_HP)
        
            Choose your action:
            [1] Physical Attack. No mana required. Deal 5pt of damage.
            [2] Meteor. Use 15pt of MP. Deal 50pt of damage.
            [3] Shield. Use 10pt of MP. Block enemy's attack in 1 turn.
            
            [4] Use potion to Heal your wound
            [5] Use Elixir
            [6] Scan enemy's vital
            [7] Flee from the battle
        
            Your Choice:
        """, terminator: " ")
        menufight = Int(readLine()!)!
        
        switch menufight{
        case 1:
            
            MonsterAttackGolem()
            selectedMonsterMountain.monster_HP -= myMeteor.damage
            Mountain()
        case 2:
            if(player.scan_vital == true){
                SkillMultipleMountain()
                selectedMonsterMountain.monster_HP -= skillmultiple
                player.usingSkill(skill: myMeteor)
                MonsterAttackGolem()
                Mountain()
            }else{
                selectedMonsterMountain.monster_HP -= myMeteor.damage
                player.usingSkill(skill: myMeteor)
                MonsterAttackGolem()
                Mountain()
            }
            
        case 3:
            player.usingSkill(skill: myShield)
            Mountain()
        case 4:
            Healing()
        case 5:
            addElixir()
        case 6:
            print("""
                  \n========================================
                  The Monster vital is in the core, use Skill meteor to kill the monster
                  ========================================\n
                  """)
            player.scan_vital = true
            Mountain()
        case 7:
            print("""
                \nYou feel that if you don't escape soon, you won't be able to continue the fight.
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
                Mountain()
            }
        default:
            print("\nPlease choose action from one of menu")
            Mountain()
        }
    }
    
}


// Add Potion or Elixir
func Healing(){
    
    if(myPotion.amount == 0){
        print("""
            \nYou don't have ny potion left. Be careful of your next journey.
            press [return] to go back:
            """, terminator: " ")
        back = readLine()!
    }else {
        print("""
                \nYour HP is \(player.player_Hp)
                You have \(myPotion.amount) potion
                
                are you sure want to use 1 potion to heal wound? [Y/N]
                """, terminator: " ")
        heal = readLine()!.uppercased()
        
        if(heal == "Y" ){
            if(myPotion.amount == 0){
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
    if (player.player_Hp < 100){
        player.usingItem(item: myPotion)
        print("""
        \nYour HP is now: \(player.player_Hp)
        You have \(myPotion.amount) potion left
    
        Still want to use 1 potion to heal wound again? [Y/N]
    """, terminator: " ")
        heal = readLine()!.uppercased()
        
        if(heal == "Y"){
            healingAgain()
        }else{
            journeyScreen()
        }
    }else if(player.player_Hp >= 100){
        print("\nYour HP is already healed, please use heal wisely")
    }
}

func addElixir(){
    if(myElixir.amount == 0){
        print("""
        \nYou don't have any Elixir left. Be careful of your next journey.
        press [return] to go back:
        """, terminator: " ")
        back = readLine()!
    }else{
        print("""
            \nYour MP is: \(player.player_MP)
            You have \(myElixir.amount) elixir left
    
            Do you want to use 1 elixir [Y/N]?
    """, terminator: " ")
        use_elixir = readLine()!.uppercased()
        
        if use_elixir == "Y"{
            addElixirAgain()
        }else{
            journeyScreen()
        }
        
    }
}

func addElixirAgain(){
    if player.player_MP < 50{
        player.usingItem(item: myElixir)
        
        print("""
            \nYour MP now: \(player.player_MP)
            Your Elixir is \(myElixir.amount) left
    
        Still want to use elixir?[Y/N]
    """)
        use_elixir = readLine()!.uppercased()
        if use_elixir == "Y"{
            addElixirAgain()
        }else{
            journeyScreen()
        }
    }else if player.player_MP >= 50{
        print("\nYour MP is already full, please use it wisely.")
    }
    
    
}

