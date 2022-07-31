//
//  Model.swift
//  SwiftUIPractice
//
//  Created by Babul Raj on 29/05/22.
//

import Foundation

struct BreedImage: Codable {
    let height: Int?
    let id: String?
    let url: String?
    let width: Int?
    
}

struct Breed: Codable, CustomStringConvertible, Identifiable {
    let id: String
    let name: String
    let temperament: String
    let breedExplaination: String
    let energyLevel: Int
    let isHairless: Bool
    let image: BreedImage?
    
    var description: String {
        return "breed with name: \(name) and id \(id), energy level: \(energyLevel) isHairless: \(isHairless ? "YES" : "NO")"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case temperament
        case breedExplaination = "description"
        case energyLevel = "energy_level"
        case isHairless = "hairless"
        case image
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        temperament = try values.decode(String.self, forKey: .temperament)
        breedExplaination = try values.decode(String.self, forKey: .breedExplaination)
        energyLevel = try values.decode(Int.self, forKey: .energyLevel)
        
        let hairless = try values.decode(Int.self, forKey: .isHairless)
        isHairless = hairless == 1
        
        image = try values.decodeIfPresent(BreedImage.self, forKey: .image)
    }
    
    init(name: String, id: String, explaination: String, temperament: String,
         energyLevel: Int, isHairless: Bool, image: BreedImage?){
        self.name = name
        self.id = id
        self.breedExplaination = explaination
        self.energyLevel = energyLevel
        self.temperament = temperament
        self.image = image
        self.isHairless = isHairless
    }
    
    
    static func example1() -> Breed {
        return Breed(name: "Abyssinian",
                     id: "abys",
                     explaination: "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.",
                     temperament: "Active, Energetic, Independent, Intelligent, Gentle",
                     energyLevel: 5,
                     isHairless: false, image: BreedImage(height: 100, id: "i", url: "https://cdn2.thecatapi.com/images/unX21IBVB.jpg", width: 100))
        
    }
    
    static func example2() -> Breed {
        return Breed(name: "Cyprus",
                     id: "cypr",
                     explaination: "Loving, loyal, social and inquisitive, the Cyprus cat forms strong ties with their families and love nothing more than to be involved in everything that goes on in their surroundings. They are not overly active by nature which makes them the perfect companion for people who would like to share their homes with a laid-back relaxed feline companion.",
                     temperament: "Affectionate, Social",
                     energyLevel: 4,
                     isHairless: false,
                     image: BreedImage(height: 100, id: "i", url: "https://cdn2.thecatapi.com/images/unX21IBVB.jpg", width: 100))
        
    }
}
