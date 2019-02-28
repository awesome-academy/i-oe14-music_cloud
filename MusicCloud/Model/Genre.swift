//
//  Genre.swift
//  MusicCloud
//
//  Created by thanh on 3/1/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import Foundation

enum Genre: String, CaseIterable {
    case Disco = "Disco"
    case Rock = "Rock"
    case Pop = "Pop"
    case Dubstep = "Dubstep"
    case Indie = "Indie"
    case Country = "Country"
    case House = "House"
    case Trap = "Trap"
    case Trance = "Trance"
    case Classical = "Classical"
    
    func createGenreParam() -> String {
        switch self {
        case .Disco:
            return APIConstant.DISCO
        case .Country:
            return APIConstant.COUNTRY
        case .Dubstep:
            return APIConstant.DUBSTEP
        case .Indie:
            return APIConstant.INDIE
        case .Rock:
            return APIConstant.ROCK
        case .Pop:
            return APIConstant.POP
        case .House:
            return APIConstant.HOUSE
        case .Trap:
            return APIConstant.TRAP
        case .Trance:
            return APIConstant.TRANCE
        case .Classical:
            return APIConstant.CLASSICAL
        }
    }
}
