//
//  SearchSongViewController.swift
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

protocol SearchSongViewControllerInput {
    func displaySearchedSongs(viewModel: SearchSong.ViewModel)
}

protocol SearchSongViewControllerOutput {
    func searchSong(request: SearchSong.Request)
}

class SearchSongViewController: UIViewController, SearchSongViewControllerInput, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var output: SearchSongViewControllerOutput!
    var router: SearchSongRouter!
    
    var songs = [(String, String)]()
    
    // MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Object lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        SearchSongConfigurator.sharedInstance.configure(self)
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    // MARK: Table View DataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("songCell", forIndexPath: indexPath)
        cell.textLabel?.text = songs[indexPath.row].0
        cell.detailTextLabel?.text = songs[indexPath.row].1
        return cell
    }
    
    // MARK: UISearch Bar Delegate
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchSong(searchBar.text)
    }
    
    // MARK: Event handling
    func searchSong(search: String?) {
        self.view.endEditing(true)
        let request = SearchSong.Request(search: search ?? "")
        output.searchSong(request)
    }
    
    // MARK: Display logic
    func displaySearchedSongs(viewModel: SearchSong.ViewModel) {
        songs = viewModel.songs        
        self.tableView.reloadData()
    }
    
}