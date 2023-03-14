//
//  RawHero+Mock.swift
//
//
//  Created by Javier Cuesta on 14.03.23.
//

@testable import HeroDomain

extension RawHero {
    enum Mock {
        static let antimage: RawHero =
            .init(id: 1,
                  givenName: "Anti-Mage",
                  primaryAttribute: "agi",
                  attackType: "Melee",
                  imageURL: "antimage.png",
                  iconURL: "antimageIcon.png",
                  roles: ["Carry", "Escape","Nuker"],
                  health: 200,
                  healthRegeneration: 0.25,
                  mana: 75,
                  manaRegeneration: 0,
                  armor: 0,
                  minAttack: 29,
                  maxAttack: 33,
                  strength: 21,
                  agility: 24,
                  intelligence: 12,
                  strengthGain: 1.6,
                  agilityGain: 2.8,
                  intelligenceGain: 1.8,
                  attackRange: 150,
                  projectileSpeed: 0,
                  attackRate: 1.4,
                  moveSpeed: 310)

        static let axe: RawHero =
            .init(id: 2,
                  givenName: "Axe",
                  primaryAttribute: "str",
                  attackType: "Melee",
                  imageURL: "axe.png",
                  iconURL: "axeIcon.png",
                  roles: ["Initiator","Durable","Disabler","Carry"],
                  health: 200,
                  healthRegeneration: 2.5,
                  mana: 75,
                  manaRegeneration: 0,
                  armor: -1,
                  minAttack: 30,
                  maxAttack: 34,
                  strength: 25,
                  agility: 20,
                  intelligence: 18,
                  strengthGain: 2.8,
                  agilityGain: 2,
                  intelligenceGain: 1.6,
                  attackRange: 150,
                  projectileSpeed: 900,
                  attackRate: 1.7,
                  moveSpeed: 315)

        static let bane: RawHero =
            .init(id: 3,
                  givenName: "Bane",
                  primaryAttribute: "int",
                  attackType: "Ranged",
                  imageURL: "antimage.png",
                  iconURL: "antimageIcon.png",
                  roles: ["Support", "Disabler", "Nuker", "Durable"],
                  health: 200,
                  healthRegeneration: 0.25,
                  mana: 75,
                  manaRegeneration: 0,
                  armor: 25,
                  minAttack: 33,
                  maxAttack: 39,
                  strength: 23,
                  agility: 23,
                  intelligence: 23,
                  strengthGain: 2.5,
                  agilityGain: 2.5,
                  intelligenceGain: 2.5,
                  attackRange: 400,
                  projectileSpeed: 900,
                  attackRate: 1.7,
                  moveSpeed: 305)
    }
}


