//
//  Store_WebView.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/04/21.
//

import SwiftUI
import WebView
import Combine

struct Store_WebView: View {
   
    @Binding var isToolBarItemHidden: Bool
    @State var webviewStore = WebViewStore()
    
    let url: String
    
    
    var body: some View {
        NavigationView{
            WebView(webView: webviewStore.webView)
                .navigationTitle("술사기")
                .navigationBarItems(trailing: HStack{
                    Button(action: goBack){
                        Image(systemName: "chevron.left")
                            .imageScale(.large)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32, height: 32)
                    }
                    .disabled(!webviewStore.canGoBack)
                    Button(action: goForward){
                        Image(systemName: "chevron.right")
                            .imageScale(.large)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32, height: 32)
                    }.disabled(!webviewStore.canGoForward)
                })
        }.onAppear{
            self.webviewStore.webView.load(URLRequest(url: URL(string: url)!))
        }
    }
    func goBack() {
        webviewStore.webView.goBack()
        webviewStore.webView.allowsBackForwardNavigationGestures
      }
      
    func goForward() {
        webviewStore.webView.goForward()
        
    }
    
}



//struct Store_WebView_Previews: PreviewProvider {
//    static var previews: some View {
//        Store_WebView()
//    }
//}
