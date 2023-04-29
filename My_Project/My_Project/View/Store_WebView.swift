//
//  Store_WebView.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/04/21.
//

import SwiftUI
import WebKit

struct Store_WebView: UIViewRepresentable {
    
    let request: URLRequest
    var webview: WKWebView?
    
    init(web: WKWebView?, req: URLRequest) {
            self.webview = WKWebView()
            self.request = req
        }
    
    class Coordinator: NSObject, WKUIDelegate {
            var parent: Store_WebView

            init(_ parent: Store_WebView) {
                self.parent = parent
            }

            // Delegate methods go here

            func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
                // alert functionality goes here
            }
        }
    
    func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }

        func makeUIView(context: Context) -> WKWebView  {
            return webview!
        }

        func updateUIView(_ uiView: WKWebView, context: Context) {
            uiView.uiDelegate = context.coordinator
            uiView.load(request)
        }

        func goBack(){
            webview?.goBack()
        }

        func goForward(){
            webview?.goForward()
        }

        func reload(){
            webview?.reload()
        }
    
    
}

struct Store_WebView_Previews: PreviewProvider {
    static var previews: some View {
        Store_WebView(web: nil, req: URLRequest(url: URL(string:"https://www.google.com")!))
    }
}
