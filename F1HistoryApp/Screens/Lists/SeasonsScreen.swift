//
//  ContentView.swift
//  DumaGov
//
//  Created by Dmitry Pavlov on 07.07.2021.
//

import SwiftUI
import Networking
import UIComponents


final class SeasonsListViewModel: ObservableObject {
    @Published private(set) var seasons: [Season] = .init()
    @Published private(set) var isPageLoading = false
    
    private(set) var offset = 0
    
    private var showBy = 30
    private(set) var maxItems = -1
    
    private func GetItems(_ callBack: (()->())? = nil) {
        SeasonsAPI.seasonsGet(limit: "\(showBy)", offset: "\(offset)") { data, err in
            self.seasons.append(contentsOf: data?.mRData?.seasonTable?.seasons ?? .init())
            self.maxItems = Int(data?.mRData?.total ?? "") ?? 0
            
            if self.offset + self.showBy > self.maxItems {
                self.offset = self.maxItems
            } else {
                self.offset += self.showBy
            }
            callBack?()
        }
    }
    
    func loadItems() {
        if isPageLoading {
            return
        }
        isPageLoading = true
        GetItems() {
            self.isPageLoading = false
        }
    }
    
    func loadAll(_ callback: (()->())?) {
        GetItems() {
            if self.offset != self.maxItems {
                self.loadAll(callback)
            } else {
                callback?()
            }
        }
    }
}

struct SeasonsScreen: View {
    @ObservedObject var viewModel = SeasonsListViewModel()
    @EnvironmentObject var router: Router
    
    var body: some View {
        if viewModel.maxItems < 0 {
            ProgressView("loading...")
                .onAppear {
                    viewModel.loadItems()
                }
        } else {
            list
        }
    }
    
    @State private var selection: String? = nil
    
    var list: some View {
        ScrollViewReader { proxy in
            ScrollView {
                ForEach(viewModel.seasons, id: \.self) { item in
                    SeasonScreenCell(activeLink: router.randomSeason?.season.season == item.season, item: item)
                        .id(item)
                        .environmentObject(viewModel)
                }
            }.onAppear {
                if let season = router.randomSeason?.season {
                    proxy.scrollTo(season)
                }
            }
        }
    }
}

struct SeasonScreenCell: View {
    
    @EnvironmentObject var viewModel: SeasonsListViewModel
    @EnvironmentObject var router: Router
    @State var activeLink = false
    
    var item: Season
    
    var body: some View {
        VStack(alignment: .center, spacing: .none) {
            if let season = item.season {
                let viewModel = StagesScreenViewModel(with: season)
                NavigationLink(destination: LazyView(StagesScreen(viewModel: viewModel)).navigationTitle("Stages of \(season)"), isActive: $activeLink) {
                    VStack {
                        Text(item.season ?? "no year")
                            .foregroundColor(.appBlack)
                        Divider()
                    }
                        
                }.onChange(of: router.tabSelection, perform: { (_) in
                    if router.randomSeason == nil {
                        activeLink = false
                    } else if item == router.randomSeason?.season {
                        self.activeLink = true
                        router.randomSeason = nil
                    }
                    
                }).onAppear() {
                    if self.viewModel.seasons.last == item && self.viewModel.offset != self.viewModel.maxItems {
                        self.viewModel.loadItems()
                    }
                }.onDisappear() {
                    router.randomSeason = nil
                }
            }
            if viewModel.isPageLoading && viewModel.seasons.last == item {
                Divider()
                ProgressView("loading...")
            }
        }
    }
}

struct SeasonsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
