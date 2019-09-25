//
//  Coordinator+First.swift
//  Tinkoff
//
//  Created by Mr.Ocumare on 24/09/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit

var currentSegueData = CurrentNewsSlug()

class FirstCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController : UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let newsListController : NewsTabel = NewsTabel()
        newsListController.delegate = self
        self.navigationController.viewControllers = [newsListController]
    }
}
extension FirstCoordinator: NewsLictControllerDelegate {
    func navigateToNewsContoller() {
        let newsController : NewsController = NewsController()
        newsController.delegate = self
        self.navigationController.viewControllers.append(newsController)
    }
}
