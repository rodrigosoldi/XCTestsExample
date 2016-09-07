//
//  SearchSongsInteractorTests.swift
//  XCTestsExample
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 9/7/16.
//  Copyright © 2016 Rodrigo Soldi Lopes. All rights reserved.
//

import XCTest
@testable import XCTestsExample

class MockSearchSongWorker: SearchSongWorker {
    
    var searchSongCalled = false
    
    override func searchSong(search: String, completionHandler: (songs: [Song]?) -> Void) {
        searchSongCalled = true
    }
    
}

class SearchSongsInteractorTests: XCTestCase {
    
    func testCallingWorker() {
        // Arrange
        let interactor = SearchSongInteractor()
        let worker = MockSearchSongWorker()
        interactor.worker = worker
        
        // Act
        interactor.searchSong(SearchSong.Request(search: "anything"))
        
        // Assert
        XCTAssert(worker.searchSongCalled,
                  "It should have called searchSong()")
    }
    
}
