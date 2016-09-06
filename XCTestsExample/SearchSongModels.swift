//
//  SearchSongModels.swift
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

struct SearchSong {
    
    struct Request {
        var search: String
    }
    
    struct Response {
        var songs : [(Song)]?
    }
    
    struct ViewModel {
        var songs : [(String, String)]
    }
}
