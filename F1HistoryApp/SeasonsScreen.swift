//
//  ContentView.swift
//  DumaGov
//
//  Created by Dmitry Pavlov on 07.07.2021.
//

import SwiftUI
import Networking
import  UIComponents


final class SeasonsListViewModel: ObservableObject {
    @Published private(set) var seasons: [Season] = .init()
    @Published private(set) var isPageLoading = false
    
    private(set) var offset = 0
    
    private var showBy = 30
    private var maxItems = -1
    
    init() {
        loadItems()
    }
    
    func loadItems() {
        if isPageLoading {
            return
        }
        isPageLoading = true
        SeasonsAPI.everythingGet(limit: "\(showBy)", offset: "\(offset)", format: .json) { data, err in
            self.seasons.append(contentsOf: data?.mRData?.seasonTable?.seasons ?? .init())
            self.maxItems = Int(data?.mRData?.total ?? "") ?? 0
            
            if self.offset + self.showBy > self.maxItems {
                self.offset = self.maxItems
            } else {
                self.offset += self.showBy
            }
            self.isPageLoading = false
        }
    }
}

struct SeasonsScreen: View {
    @ObservedObject var viewModel = SeasonsListViewModel()
    
    var body: some View {
        list
    }
    
    @State private var selection: String? = nil
    
    var list: some View {
        List(viewModel.seasons, id: \.self) { item in
            SeasonScreenCell(item: item)
                .environmentObject(viewModel)
        }
    }
}

struct SeasonScreenCell: View {
    
    @EnvironmentObject var viewModel: SeasonsListViewModel
    var item: Season
    
    var body: some View {
        VStack(alignment: .center, spacing: .none) {
            if let url = URL(string: item.url ?? "") {
                HStack {
                    if let season = item.season {
                        let viewModel = StagesScreenViewModel(with: season)
                        NavPushButton(destination: LazyView(StagesScreen(viewModel: viewModel))) {
                            Text(item.season ?? "")
                        }
                    }
                    Spacer()
                    ZStack {
                        NavPushButton(destination: LazyView(WebViewScreen(title: item.season ?? "", url: url))) {
                            Image(systemName: "w.circle")
                        }
                    }
                }
            } else {
                Text(item.season ?? "")
            }
            if viewModel.isPageLoading && viewModel.seasons.last == item {
                Divider()
                ProgressView("loading...")
            }
        }
        .onAppear() {
            if viewModel.seasons.last == item {
                viewModel.loadItems()
            }
        }
    }
}

struct SeasonsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
