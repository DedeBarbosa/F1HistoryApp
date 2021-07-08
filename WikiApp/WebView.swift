//
//  WebView.swift
//  WikiApp
//
//  Created by Dmitry Pavlov on 07.07.2021.
//

import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(request: URLRequest(url: URL(string: "http://ya.ru")!))
    }
}

struct WebViewScreen: View {
    var url: URL
    var body: some View {
        WebView(request: URLRequest(url: url))
    }
}
