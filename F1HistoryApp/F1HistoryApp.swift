//
//  F1HistoryApp.swift
//  F1HistoryApp
//
//  Created by Dmitry Pavlov on 07.07.2021.
//

import SwiftUI

@main
struct F1HistoryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Router())
        }
    }
}
