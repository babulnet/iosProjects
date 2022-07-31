//
//  SwiftUIPracticeApp.swift
//  SwiftUIPractice
//
//  Created by Babul Raj on 28/05/22.
//

import SwiftUI

@main
struct SwiftUIPracticeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            PracticePractice()
           // RootView(presenter: CatPresenter())
        }
    }
}
