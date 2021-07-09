//
//  ContentView.swift
//  OtusApp
//
//  Created by Dmitry Pavlov on 27.06.2021.
//

import SwiftUI
import UIComponents

final class Router: ObservableObject {
    @Published var tabSelection: Int = 0
}

struct ContentView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
            TabView(selection: $router.tabSelection) {
                NavControllerView(transition: .custom(.move(edge: .trailing))) {
                    LazyView(MainScreen())
                }
                .tabItem {
                    Image(systemName: "house")
                    Text("Main")
                }
                .tag(0)
                NavControllerView(transition: .custom(.move(edge: .trailing))) {
                    LazyView(SeasonsScreen())
                        .navigationTitle("F1 Seasons From 1950")
                }
                .navigationBarTitleDisplayMode(.large)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("List")
                }
                .tag(1)
                NavControllerView(transition: .custom(.move(edge: .leading))) {
                    LazyView(AboutScreen())
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
