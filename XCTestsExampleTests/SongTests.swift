//
//  SongTests.swift
//  XCTestsExample
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 9/7/16.
//  Copyright © 2016 Rodrigo Soldi Lopes. All rights reserved.
//

import XCTest

/*
 Precisa importar o seu projeto aqui pra 
 ficar visível pros testes.
 */
@testable import XCTestsExample

class SongTests: XCTestCase {
    
    func testInitialization() {
        let song = Song(name: "any name", singer: "any singer")
        
        XCTAssert(song.name == "any name",
                  "It should have set the name")
        XCTAssert(song.singer == "any singer",
                  "It should have set the singer")
    }
    
}
