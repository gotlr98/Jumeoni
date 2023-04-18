//
//  Makgeolli_Review_View.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/04/18.
//

import SwiftUI
import Cosmos

struct MyCosmosView: UIViewRepresentable {
    @Binding var rating: Double

    func makeUIView(context: Context) -> CosmosView {
        CosmosView()
    }

    func updateUIView(_ uiView: CosmosView, context: Context) {
        uiView.rating = rating
    
        // Autoresize Cosmos view according to it intrinsic size
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
      
        // Change Cosmos view settings here
        uiView.settings.starSize = 40
    }
}

struct Makgeolli_Review_View: View {
    
    @State var rating = 3.0
    
    var body: some View{
        
        VStack{
            MyCosmosView(rating: $rating)
            
            Button(action: {
                print(rating)
            }, label: {
                Text("Check")
            })
        }
        
    }
}

struct Makgeolli_Review_View_Previews: PreviewProvider {
    static var previews: some View {
        Makgeolli_Review_View()
    }
}
