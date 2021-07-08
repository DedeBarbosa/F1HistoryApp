//
//  DumaGovApp.swift
//  DumaGov
//
//  Created by Dmitry Pavlov on 07.07.2021.
//

import SwiftUI

@main
struct DumaGovApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Router())
        }
    }
}
