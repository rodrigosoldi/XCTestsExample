//
//  SearchSongsPresenterTests.swift
//  XCTestsExample
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 9/7/16.
//  Copyright © 2016 Rodrigo Soldi Lopes. All rights reserved.
//

import XCTest
@testable import XCTestsExample

class MockSearchSongPresenterOutput: SearchSongPresenterOutput {
    
    var displayCalled = false
    var songsPassedAsParameters = [(String, String)]()
    
    func displaySearchedSongs(viewModel: SearchSong.ViewModel) {
        displayCalled = true
        songsPassedAsParameters = viewModel.songs
    }
    
}

class SearchSongsPresenterTests: XCTestCase {
    
    func testCallingOutputWithNil() {
        let presenter = SearchSongPresenter()
        let output = MockSearchSongPresenterOutput()
        presenter.output = output
        let emptyResponse = SearchSong.Response(songs: nil)
        
        presenter.presentSearchedSongs(emptyResponse)
        
        XCTAssert(output.displayCalled,
                  "It should have called display()")
        XCTAssert(output.songsPassedAsParameters.count == 0,
                  "It should have passed an empty array")
        
    }
    
    func testCallingOutputWithEmptyArray() {
        let presenter = SearchSongPresenter()
        let output = MockSearchSongPresenterOutput()
        presenter.output = output
        let emptyResponse = SearchSong.Response(songs: [])
        
        presenter.presentSearchedSongs(emptyResponse)
        
        XCTAssert(output.displayCalled,
                  "It should have called display()")
        XCTAssert(output.songsPassedAsParameters.count == 0,
                  "It should have passed an empty array")
        
    }
    
    func testCallingOutputWithSongs() {
        let presenter = SearchSongPresenter()
        let output = MockSearchSongPresenterOutput()
        presenter.output = output
        let songs = [
            Song(name: "My song 1", singer: "My singer 1"),
            Song(name: "My song 2", singer: "My singer 2")
        ]
        
        presenter.presentSearchedSongs(SearchSong.Response(songs: songs))
        
        XCTAssert(output.songsPassedAsParameters[0].0 == "My song 1" &&
                    output.songsPassedAsParameters[0].1 == "My singer 1" &&
                    output.songsPassedAsParameters[1].0 == "My song 2" &&
                    output.songsPassedAsParameters[1].1 == "My singer 2",
                  "It should have passed the array.")
        
    }
    
}
