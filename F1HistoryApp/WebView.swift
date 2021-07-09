//
//  WebView.swift
//  WikiApp
//
//  Created by Dmitry Pavlov on 07.07.2021.
//

import SwiftUI
import WebKit
import UIComponents

struct WebView : UIViewRepresentable {
    //@Binding var title: String
    var url: URL
    var loadStatusChanged: ((Bool, Error?) -> Void)? = nil
    
    func makeCoordinator() -> WebView.Coordinator {
            Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView  {
        let view = WKWebView()
        view.navigationDelegate = context.coordinator
        view.load(URLRequest(url: url))
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
    
    func onLoadStatusChanged(perform: ((Bool, Error?) -> Void)?) -> some View {
        var copy = self
        copy.loadStatusChanged = perform
        return copy
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            parent.loadStatusChanged?(true, nil)
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.loadStatusChanged?(false, nil)
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.loadStatusChanged?(false, error)
        }
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        if let _ = URL(string: "http://ya.ru") {
//            WebView(title: "$title", url: url)
        }
    }
}

struct WebViewScreen: View {
    var title: String
    @State private var _title: String = ""
    
    @State var error: Error? = nil
    
    var url: URL
    
    var body: some View {
        VStack {
            WebView(url: url)
                .onLoadStatusChanged { loading, error in
                    if loading {
                        print("Loading started")
                        self._title = "Loading…"
                    }
                    else {
                        print("Done loading.")
                        if let error = error {
                            self.error = error
                            if self.title.isEmpty {
                                self._title = "Error"
                            }
                        }
                        else if self.title.isEmpty {
                            self._title = "Some Place"
                        } else {
                            _title = title
                        }
                    }
                }
        }
    }
}
