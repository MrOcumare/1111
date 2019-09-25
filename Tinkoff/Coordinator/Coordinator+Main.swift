//
//  Coordinator+Main.swift
//  Tinkoff
//
//  Created by Mr.Ocumare on 24/09/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit

public protocol Coordinator : class {
    
    var childCoordinators: [Coordinator] { get set }
    
    //    COMMENT(mrocumare): все Coordinator должны быть проинициализированы через UINavigationController
    init(navigationController:UINavigationController)
    
    func start()
}
