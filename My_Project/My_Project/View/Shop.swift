//
//  Shop.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/03/30.
//

import SwiftUI

struct Shop: View {
    
    @Binding var isToolBarItemHidden: Bool
    
    var body: some View {
        Store_WebView(urlToLoad: "https://smartstore.naver.com/wooridoga")
    }
}

struct Shop_Previews: PreviewProvider {
    static var previews: some View {
        Shop(isToolBarItemHidden: .constant(false))
    }
}
