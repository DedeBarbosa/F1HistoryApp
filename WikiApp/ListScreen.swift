//
//  ContentView.swift
//  DumaGov
//
//  Created by Dmitry Pavlov on 07.07.2021.
//

import SwiftUI
import WikiNetworking


final class TopicsListViewModel: ObservableObject {
    @Published private(set) var topics: [Season] = .init()
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
        SeasonsAPI.everythingGet { data, err in
            self.topics = data?.mRData?.seasonTable?.seasons ?? .init()
            self.maxItems = Int(data?.mRData?.total ?? "") ?? 0
        }
        
        if offset + showBy > maxItems {
            offset = maxItems
        } else {
            offset += showBy
        }
        isPageLoading = false
    }
}

struct ListScreen: View {
    
    @ObservedObject var viewModel = TopicsListViewModel()
    
    var body: some View {
        ZStack {
            list
        }
    }
    @State private var selection: String? = nil
    var list: some View {
        NavigationView {
            List(viewModel.topics, id: \.self) { item in
                listCell(item: item)
            }
        }
    }
    
    func listCell(item: Season) -> some View {
        VStack {
            if viewModel.isPageLoading && viewModel.topics.last == item {
                Divider()
                Text("Loading...")
            }
            if let url = URL(string: item.url ?? "") {
                NavigationLink(destination: WebViewScreen(url: url)) {
                    Text(item.season ?? "")
                }
            } else {
                Text(item.season ?? "")
            }
        }.onAppear() {
            if viewModel.topics.last == item {
                viewModel.loadItems()
            }
        }
    }
}

struct ListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ListRow: View {
    
    var name: String?
    
    var body: some View {
        Text(name ?? "no name")
            .foregroundColor(.black)
            .font(.headline)
    }
}
