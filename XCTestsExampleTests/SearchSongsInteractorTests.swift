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
    var requestSearchParameter: String?
    
    override func searchSong(search: String, completionHandler: (songs: [Song]?) -> Void) {
        searchSongCalled = true
        requestSearchParameter = search
        let songs = [
            Song(name: "song 1", singer: "singer 1"),
            Song(name: "song 2", singer: "singer 2"),
            Song(name: "song 3", singer: "singer 3")
        ]
        completionHandler(songs: songs)
    }
    
}

class MockInteractorOutput: SearchSongInteractorOutput {
    
    var presentSearchSongsCalled = false
    
    func presentSearchedSongs(response: SearchSong.Response) {
        presentSearchSongsCalled = true
    }
    
}

class SearchSongsInteractorTests: XCTestCase {
    
    func testCallingWorker() {
        // Arrange
        let interactor = SearchSongInteractor()
        let worker = MockSearchSongWorker()
        let output = MockInteractorOutput()
        interactor.worker = worker
        interactor.output = output
        
        // Act
        interactor.searchSong(SearchSong.Request(search: "anything"))
        
        // Assert
        XCTAssert(worker.searchSongCalled,
                  "It should have called searchSong()")
    }
    
    func testPassingParameters() {
        // Arrange
        let interactor = SearchSongInteractor()
        let worker = MockSearchSongWorker()
        let output = MockInteractorOutput()
        interactor.worker = worker
        interactor.output = output
        let myString = "my favorite string"
        
        // Act
        interactor.searchSong(SearchSong.Request(search: myString))
        
        // Assert
        XCTAssert(worker.requestSearchParameter == myString,
                  "It should have called with the right string")
    }
    
    func testCallingOutput() {
        let interactor = SearchSongInteractor()
        let worker = MockSearchSongWorker()
        let output = MockInteractorOutput()
        interactor.worker = worker
        interactor.output = output
        
        interactor.searchSong(SearchSong.Request(search: "My string"))
        
        XCTAssert(output.presentSearchSongsCalled,
                  "It should have called the output")
    }
    
}
