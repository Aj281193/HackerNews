//
//  WkWebView+Extension.swift
//  HackerNews
//
//  Created by Ashish Jaiswal on 08/08/22.
//

import Foundation
import WebKit

extension WKWebView {
    
    static func pageNotFound() -> WKWebView {
        let wk = WKWebView()
        wk.loadHTMLString("<html><body><h1>Page not found!</h1></body></html>", baseURL: nil)
        return wk
    }
}
