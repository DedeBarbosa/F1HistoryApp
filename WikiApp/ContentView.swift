//
//  ContentView.swift
//  OtusApp
//
//  Created by Dmitry Pavlov on 27.06.2021.
//

import SwiftUI

final class Router: ObservableObject {
    @Published var tabSelection: Int = 0
}

struct ContentView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
            TabView(selection: $router.tabSelection) {
                MainScreen()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Main")
                    }
                    .tag(0)
                ListScreen()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("List")
                    }
                    .tag(1)
                AboutScreen()
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
