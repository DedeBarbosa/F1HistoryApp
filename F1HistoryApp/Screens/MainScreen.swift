//
//  MainScreen.swift
//  OtusApp
//
//  Created by Dmitry Pavlov on 27.06.2021.
//

import SwiftUI

struct MainScreen: View {
    
    @EnvironmentObject var router: Router
    
    @State var progressIsVisible = false
    
    var body: some View {
        VStack{
            Spacer()
            Button("Random season") {
                self.progressIsVisible = true
                let vm = SeasonsListViewModel()
                vm.loadAll() {
                    progressIsVisible = false
                    if let seasonIndex = vm.seasons.indices.randomElement() {
                        router.randomSeason = Router.RandomSeason(season: vm.seasons[seasonIndex], index: seasonIndex)
                    }
                    router.tabSelection = 1
                }
            }.foregroundColor(.appBlack)
            Spacer()
            if progressIsVisible {
                ProgressView("Loading & Сhoosing")
            }
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        MainScreen()
    }
}
