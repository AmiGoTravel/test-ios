//
//  Coordinator.swift
//  RedditAmiGo
//
//  Created by Leonardo Saganski on 3/5/21.
//

import Foundation

import Foundation
import UIKit

final class Coordinator {
    private var navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    func entriesList() {
        let viewC = EntryListViewController.getInstance()
        let viewM = EntryListViewModel()
        viewC.setCoordinator(coordinator: self)
        viewC.bindViewModel(viewModel: viewM)
        navController.pushViewController(viewC, animated: false)
    }
    
    func entriesDetails(item: EntryInfo?) {
        let viewC = EntryDetailsViewController.getInstance()
        let viewM = EntryDetailsViewModel()
        viewM.setItem(item: item)
        viewC.setCoordinator(coordinator: self)
        viewC.bindViewModel(viewModel: viewM)
        navController.pushViewController(viewC, animated: false)
    }
}
