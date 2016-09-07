//
//  SearchSongsWorkerTests.swift
//  XCTestsExample
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 9/7/16.
//  Copyright © 2016 Rodrigo Soldi Lopes. All rights reserved.
//

import XCTest
@testable import XCTestsExample

class SearchSongsWorkerTests: XCTestCase {
    
    func testCompletionHandler() {
        let worker = SearchSongWorker()
        let expectation = expectationWithDescription("It should call the completion handler")
        
        worker.searchSong("any string") { (songs) in
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(0.1) { (error) in
            print("Timeout error: \(error)")
        }
    }
    
}
