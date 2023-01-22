//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by Alex Andrews on 22/01/2023.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
