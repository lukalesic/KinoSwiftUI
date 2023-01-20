//
//  ServerApi+Parsing.swift
//  Kino
//
//  Created by Luka Lešić on 10.01.2023..
//

import Foundation


class APIDecoder {
    static let decoder = JSONDecoder()
    
    func mapAsTvShow(data: Data) throws -> Show {
        try APIDecoder.decoder.decode(Show.self, from: data)
    }
    
}
