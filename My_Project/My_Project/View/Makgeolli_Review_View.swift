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
        uiView.didFinishTouchingCosmos = { rating in
            self.rating = rating
        }
    }
}

struct Makgeolli_Review_View: View {
    
    @Binding var show_sheet: Bool
    var name: String
    
    @State var sweet = 0.0
    @State var bitter = 0.0
    @State var sour = 0.0
    @State var refreshing = 0.0
    @State var thick = 0.0
    @State var rating = 0.0
    
    var body: some View{
        
        VStack{
            HStack{
                Text("단맛")
                    .font(.title)
                    .padding(.all)
                MyCosmosView(rating: $sweet)
            }
            
            HStack {
                Text("쓴맛")
                    .font(.title)
                    .padding(.all)
                MyCosmosView(rating: $bitter)
            }
            
            HStack {
                Text("신맛")
                    .font(.title)
                    .padding(.all)
                MyCosmosView(rating: $sour)
            }
            
            HStack {
                Text("청량감")
                    .font(.title)
                    .padding(.all)
                MyCosmosView(rating: $refreshing)
            }
            
            HStack {
                Text("걸쭉함")
                    .font(.title)
                    .padding(.all)
                MyCosmosView(rating: $thick)
            }
            
            Button(action: {
                print(name + "님")
                set_Makgeolli_Review(name: name, drink_name: "대대포 블루 꿀 막걸리", sweet: sweet, bitter: bitter, sour: sour, refreshing: refreshing, thick: thick, rating: rating, comment: "soso")
                show_sheet.toggle()
            }, label: {
                Text("Check")
            })
        }
        
    }
}

struct Makgeolli_Review_View_Previews: PreviewProvider {
    static var previews: some View {
        Makgeolli_Review_View(show_sheet: .constant(false), name: "")
    }
}
