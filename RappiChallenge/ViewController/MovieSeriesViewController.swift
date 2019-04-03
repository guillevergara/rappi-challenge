//
//  MovieSeriesViewController.swift
//  RappiChallenge
//
//  Created by Guillermo Vergara on 4/1/19.
//  Copyright © 2019 Guillermo Vergara. All rights reserved.
//

import UIKit

class MovieSeriesViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    let searchController = UISearchController(searchResultsController: nil)

    var movies:[Movie] = []
    var filteredMovies:[Movie] = []
    var moviesPopular:[Movie] = []
    var moviesTopRated:[Movie] = []
    var moviesUpcoming:[Movie] = []
    var source:Source = .Movie
    var selectedCategory:Category = .Popular
    var selectedMovie:Movie?
    
    enum Source: String {
        case Movie, Series
    }
    
    enum Category: String {
        case Popular, TopRated, Upcoming
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib.init(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search \(source == .Movie ? "movies" : "series")"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if source == .Movie{
            self.title = "Movies"
        }
        else{
            self.title = "Series"
        }
        
        getPopular()
    }
    
    func getPopular(page:Int = 1){
        self.selectedCategory = .Popular
        DataManager.queryPopular(page: page, isMovie: source == .Movie, completion: { (movies, error) in
            self.moviesPopular = movies
            self.movies = self.moviesPopular
            self.collectionView.reloadData()
        })
    }
    
    func getTopRated(page:Int = 1){
        self.selectedCategory = .TopRated
        DataManager.queryTopRated(page: page, isMovie: source == .Movie, completion: { (movies, error) in
            self.moviesTopRated = movies
            self.movies = self.moviesTopRated
            self.collectionView.reloadData()
        })
    }
    
    func getUpcoming(page:Int = 1){
        self.selectedCategory = .Upcoming
        DataManager.queryUpcoming(page: page, isMovie: source == .Movie, completion: { (movies, error) in
            self.moviesUpcoming = movies
            self.movies = self.moviesUpcoming
            self.collectionView.reloadData()
        })
    }
    
    @IBAction func segmentedControlChanged(){
        
        let selectedIndex = self.segmentedControl.selectedSegmentIndex
        switch selectedIndex {
        case 1:
            getTopRated()
        case 2:
            getUpcoming()
        default:
            getPopular()
        }
        collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
    
    private func loadMoreMovies(indexPath: IndexPath) {
        if (indexPath.row == (movies.count - 2)){
            let page = (self.movies.count/20) + 1
            switch selectedCategory {
            case .TopRated:
                getTopRated(page: page)
            case .Upcoming:
                getUpcoming(page: page)
            default:
                getPopular(page: page)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movie = selectedMovie {
            let vc = segue.destination as! DetailViewController
            vc.movie = movie
        }
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

}

extension MovieSeriesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isFiltering() {
            selectedMovie = filteredMovies[indexPath.row]
        }
        else{
            selectedMovie = movies[indexPath.row]
        }
        performSegue(withIdentifier: "showDetail", sender: self)
    }
}

extension MovieSeriesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width - 10
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/1.5)
    }
}

extension MovieSeriesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredMovies.count
        }
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie: Movie
        if isFiltering() {
            movie = filteredMovies[indexPath.row]
        }
        else{
            movie = movies[indexPath.row]
        }
        cell.configure(movie: movie)
        loadMoreMovies(indexPath: indexPath)
        return cell
    }
}

extension MovieSeriesViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredMovies = movies.filter({( movie : Movie) -> Bool in
            if self.source == .Movie {
                return movie.title?.lowercased().contains(searchText.lowercased()) ?? false
            }
            else{
                return movie.name?.lowercased().contains(searchText.lowercased()) ?? false
            }
        })
        collectionView.reloadData()
    }
    
}

