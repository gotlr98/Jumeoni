//
//  Shop.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/03/30.
//

import SwiftUI


func encodingURL(url: String) -> URL? {
    let encodeURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    
    return URL(string: encodeURL)!
}

struct Shop: View {
    
    let webview: Store_WebView
    @Binding var isToolBarItemHidden: Bool
    
    var body: some View {
        
//        let webview = Store_WebView(web: nil, req: URLRequest(url: URL(string: url)!))
        
        VStack{
            HStack() {
                Button(action: {
                    self.webview.goBack()
                }){
                    Image(systemName: "chevron.left")
                }.padding(32)

                Button(action: {
                    self.webview.reload()
                }){
                    Image(systemName: "arrow.clockwise")
                }.padding(32)

                Button(action: {
                    self.webview.goForward()
                }){
                    Image(systemName: "chevron.right")
                }.padding(32)
            }.frame(height: 32)
        }
        
            
    }
        
}

struct Shop_Previews: PreviewProvider {
    static var previews: some View {
        Shop(webview: Store_WebView(web: nil, req: URLRequest(url: URL(string:"")!)), isToolBarItemHidden: .constant(false))
    }
}
