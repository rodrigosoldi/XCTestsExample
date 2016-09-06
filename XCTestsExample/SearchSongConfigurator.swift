//
//  SearchSongConfigurator.swift
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

// MARK: Connect View, Interactor, and Presenter

extension SearchSongViewController: SearchSongPresenterOutput {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        router.passDataToNextScene(segue)
    }
}

extension SearchSongInteractor: SearchSongViewControllerOutput {
}

extension SearchSongPresenter: SearchSongInteractorOutput {
}

class SearchSongConfigurator {
    // MARK: Object lifecycle
    
    class var sharedInstance: SearchSongConfigurator {
        struct Static {
            static var instance: SearchSongConfigurator?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = SearchSongConfigurator()
        }
        
        return Static.instance!
    }
    
    // MARK: Configuration
    
    func configure(viewController: SearchSongViewController) {
        let router = SearchSongRouter()
        router.viewController = viewController
        
        let presenter = SearchSongPresenter()
        presenter.output = viewController
        
        let interactor = SearchSongInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
