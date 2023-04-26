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
    
    var url: String
    
    @Binding var isToolBarItemHidden: Bool
    
    var body: some View {
        Store_WebView(urlToLoad: "https://msearch.shopping.naver.com/search/all?query=\(url)&cat_id=&frm=NVSHATC".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
    }
}

struct Shop_Previews: PreviewProvider {
    static var previews: some View {
        Shop(url: "", isToolBarItemHidden: .constant(false))
    }
}
