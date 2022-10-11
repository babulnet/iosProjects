//
//  CoundownView_SwiftUIApp.swift
//  CoundownView_SwiftUI
//
//  Created by Babul Raj on 12/10/22.
//

import SwiftUI

@main
struct CoundownView_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            CountDownView(title: "This is timer", buttonTitle: "next", endTimeInterval: 1665516200, colour: .yellow, iconName: nil) {
                ""
            }
        }
    }
}
