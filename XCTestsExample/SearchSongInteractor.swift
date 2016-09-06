//
//  SearchSongInteractor.swift
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

protocol SearchSongInteractorInput {
    func searchSong(request: SearchSong.Request)
}

protocol SearchSongInteractorOutput {
    func presentSearchedSongs(response: SearchSong.Response)
}

class SearchSongInteractor: SearchSongInteractorInput {
    var output: SearchSongInteractorOutput!
    var worker: SearchSongWorker!
 
    
    func searchSong(request: SearchSong.Request) {
        worker = SearchSongWorker()
        worker.searchSong(request.search) { (songs) in
            let response = SearchSong.Response(songs: songs)
            self.output.presentSearchedSongs(response)
        }
    }
}
