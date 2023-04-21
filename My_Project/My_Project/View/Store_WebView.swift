//
//  Store_WebView.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/04/21.
//

import SwiftUI
import WebKit

struct Store_WebView: UIViewRepresentable {
    
    var urlToLoad: String
    
    func makeUIView(context: Context) -> WKWebView{
        
        guard let url = URL(string: urlToLoad) else {
            return WKWebView()
        }
        
        let webview = WKWebView()
        
        webview.load(URLRequest(url: url))
        
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}

struct Store_WebView_Previews: PreviewProvider {
    static var previews: some View {
        Store_WebView(urlToLoad: "https://www.naver.com")
    }
}
