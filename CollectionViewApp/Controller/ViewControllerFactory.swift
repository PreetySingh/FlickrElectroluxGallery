//
//  ViewControllerFactory.swift
//  CollectionViewApp
//
//  Created by Preety Singh on 28/05/22.
//

import Foundation

struct ViewControllerFactory {
    /// Creates and returns ViewController and it's required components
    /// - Returns: Initializes and returns ViewController
    static func create() -> ViewController {
        let presenter = ViewControllerPresenter()
        let worker = ViewControllerWorker()
        let interactor = ViewControllerInteractor(presenter: presenter,
                                                  worker: worker)
        let controller = ViewController(
            interactor: interactor
        )
        presenter.setup(controller: controller)
        return controller
    }
}
