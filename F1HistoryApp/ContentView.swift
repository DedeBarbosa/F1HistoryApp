//
//  ContentView.swift
//  OtusApp
//
//  Created by Dmitry Pavlov on 27.06.2021.
//

import SwiftUI
import UIComponents
import Networking

enum ListMode: String {
    case seasons = "Seasons List"
    case drivers = "Drivers List"
}

final class Router: ObservableObject {
    @Published var tabSelection: Int = 0
    @Published var randomSeason: RandomSeason? = nil
    
    struct RandomSeason: Equatable {
        let season: Season
        let index: Int
    }
}

struct ContentView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
            TabView(selection: $router.tabSelection) {
                LazyView(MainScreen())
                .tabItem {
                    Image(systemName: "house")
                    Text("Main")
                }
                .tag(0)
                LazyView(ListsScreen())
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Seasons List")
                }
                .tag(1)
                NavigationView() {
                    LazyView(AboutScreen()).navigationTitle("About")
                }
                .tabItem {
                    Image(systemName: "questionmark.circle")
                    Text("About")
                }
                .tag(2)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
