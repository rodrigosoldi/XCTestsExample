//
//  SearchSongViewControllerTests.swift
//  XCTestsExample
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 9/7/16.
//  Copyright © 2016 Rodrigo Soldi Lopes. All rights reserved.
//

import XCTest
@testable import XCTestsExample

class MockViewControllerOutput: SearchSongViewControllerOutput {
    
    var searchSongCalled = false
    var parameter: String?
    
    func searchSong(request: SearchSong.Request) {
        searchSongCalled = true
        parameter = request.search
    }
    
}

class MockTableView: UITableView {
    
    var reloadDataCalled = false
    
    override func reloadData() {
        reloadDataCalled = true
    }
    
}

class SearchSongsViewControllerTests: XCTestCase {
    
    func testLoading() {
        guard let vc = getViewController(true) else { fail() ; return }
        
        XCTAssert(vc.searchBar != nil,
                  "It should have set the outlets")
        XCTAssert(vc.tableView != nil,
                  "It should have set the outlets")
    }
    
    func testTableViewDataSource() {
        guard let vc = getViewController(true) else { fail() ; return }
        
        let sections = vc.numberOfSectionsInTableView(vc.tableView)
        
        XCTAssert(sections == 1,
                  "It should be 1")
        
        ////////
        
        let songs = [("", ""), ("", ""), ("", "")]
        vc.songs = songs // <---- muito exposto, não?
        
        let rows = vc.tableView(vc.tableView, numberOfRowsInSection: 0)
        
        XCTAssert(rows == 3,
                  "It should be equal to `songs.count`")
        
        //////////
        
        // o cellForRow é complicado.. fica pra outro dia (2h50 já!) hahaha
    }
    
    func testSearchSong() {
        guard let vc = getViewController(true) else { fail() ; return }
        let output = MockViewControllerOutput()
        vc.output = output
        
        vc.searchSong("My string")
        
        XCTAssert(output.searchSongCalled,
                  "It should have called searchSong()")
        XCTAssert(output.parameter == "My string",
                  "It should have passed the string")
    }
    
    func testReloadingData() {
        guard let vc = getViewController(true) else { fail() ; return }
        let output = MockViewControllerOutput()
        let tableView = MockTableView()
        vc.output = output
        vc.tableView = tableView
        let songs = [
            ("1", "um"),
            ("2", "dois")
        ]
        let viewModel = SearchSong.ViewModel(songs: songs)
        
        vc.displaySearchedSongs(viewModel)
        
        XCTAssert(tableView.reloadDataCalled,
                  "It should have called reloadData()")
        XCTAssert(vc.songs[0].0 == "1" &&
                    vc.songs[0].1 == "um" &&
                    vc.songs[1].0 == "2" &&
                    vc.songs[1].1 == "dois",
                  "It should have set the songs")
    }
    
    // MARK: - helper methods
    
    func getViewController(loading: Bool) -> SearchSongViewController? {
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewControllerWithIdentifier("SongsVC")
            as? SearchSongViewController else {
                return nil
        }
        
        if loading {
            let _ = vc.view // so it will call viewDidLoad() 😉
        }
        
        return vc
    }
    
}

extension XCTestCase {
    
    func fail() {
        XCTAssert(false,
                  "It shall not pass ✋🏻😎")
    }
    
}
