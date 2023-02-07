//
//  webView.swift
//  HackerNews
//
//  Created by Ashish Jaiswal on 08/08/22.
//

import Foundation
import SwiftUI
import WebKit

struct Webview: UIViewRepresentable {
    var url: String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.url) else {
            return WKWebView.pageNotFound()
        }
        let request = URLRequest(url: url)
        let wkWebView = WKWebView()
        wkWebView.load(request)
        return wkWebView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: self.url) else {
            return
        }
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
}
