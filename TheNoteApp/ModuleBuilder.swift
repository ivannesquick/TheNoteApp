//
//  ModuleBuilder.swift
//  TheNoteApp
//
//  Created by Neskin Ivan on 19.03.2021.
//  Copyright © 2021 Neskin Ivan. All rights reserved.
//

import UIKit

class ModuleBuilder {
    static func build() -> UIViewController {
        let view = MainViewController()
        let store = StoreService()
        let presenter = MainScreenPresenter(view: view)
        view.mainPresenter = presenter
        return view
    }
}
