//
//  SearchSongPresenter.swift
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

protocol SearchSongPresenterInput {
    func presentSearchedSongs(response: SearchSong.Response)
}

protocol SearchSongPresenterOutput: class {
    func displaySearchedSongs(viewModel: SearchSong.ViewModel)
}

class SearchSongPresenter: SearchSongPresenterInput {
    weak var output: SearchSongPresenterOutput!
    
    // MARK: Presentation logic
    func presentSearchedSongs(response: SearchSong.Response) {
        guard let songs = response.songs else {
            output.displaySearchedSongs(SearchSong.ViewModel(songs: [(String, String)]()))
            return
        }
        
        var searchedSongs = [(String, String)]()
        for song in songs {
            searchedSongs.append((song.name, song.singer))
        }
        
        let viewModel = SearchSong.ViewModel(songs: searchedSongs)
        output.displaySearchedSongs(viewModel)
    }
}
