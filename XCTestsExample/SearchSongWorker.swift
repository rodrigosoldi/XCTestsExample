//
//  SearchSongWorker.swift
//  XCTestsExample
//
//  Created by Rodrigo Soldi Lopes on 06/09/16.
//  Copyright (c) 2016 Rodrigo Soldi Lopes. All rights reserved.
//
//  Generated via Aleph Clean Swift Xcode Templates
//  http://alaphao.github.io
//
//  This is a modification of Clean Swift Xcode Templates, see http://clean-swift.com
//

import UIKit

class SearchSongWorker {
  // MARK: Business Logic
  
    func searchSong(search: String, completionHandler: (songs: [Song]?) -> Void) {                
        
        completionHandler(songs: [
            Song(name: "Sugar", singer: "Maroon 5"),
            Song(name: "Sorry", singer: "Justin Bieber"),
            Song(name: "Just the way you are", singer: "Bruno Mars"),
            Song(name: "Uptown Funk", singer: "Bruno Mars"),
            Song(name: "We are the champions", singer: "Queen"),
            Song(name: "She will be loved", singer: "Maroon 5"),
            Song(name: "Photograph", singer: "Ed Sheeran"),
            Song(name: "One", singer: "Ed Sheeran"),
            Song(name: "Drag me down", singer: "One Direction"),
            Song(name: "Hello", singer: "Adele")
            ])
    }
}
