//
//  TabBarViewController.swift
//  RappiChallenge
//
//  Created by Guillermo Vergara on 4/1/19.
//  Copyright © 2019 Guillermo Vergara. All rights reserved.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        viewControllers = []
        
        let moviesViewController = UIStoryboard(name: "MovieSeries", bundle: nil).instantiateViewController(withIdentifier: "MovieSeriesNavViewController")
        let seriesViewController = UIStoryboard(name: "MovieSeries", bundle: nil).instantiateViewController(withIdentifier: "MovieSeriesNavViewController")
        
        moviesViewController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "movie_icon"), tag:0)
        viewControllers?.append(moviesViewController)
        
        seriesViewController.tabBarItem = UITabBarItem(title: "Series", image: UIImage(named: "series_icon"), tag:1)
        viewControllers?.append(seriesViewController)
        
        tabBar.tintColor = UIColor.black
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        let navcontroller = viewController as! UINavigationController
        if let controller = navcontroller.topViewController as? MovieSeriesViewController {
            if selectedIndex == 0 {
                controller.source = .Movie
            }
            else{
                controller.source = .Series
            }
        }
    }
}
