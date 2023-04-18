//
//  Review_View.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/04/05.
//

import SwiftUI
import RealmSwift

struct Review_View: View {
    
    var drink: Drink
    var review: Results<Review>
    
    @State var show_sheet: Bool = false
    @State private var dismissed: Bool = false
    
    var body: some View {
        VStack {
           
            List{
                ForEach(review, id: \.self){ review in
                    if drink.name == review.drink_name{
                        HStack{
                            Text(review.name)
                            Text(String(review.rating))
                        }
                    }
                }
            }
            .listStyle(.sidebar)
            .toolbar{
                ToolbarItem(placement: ToolbarItemPlacement.bottomBar, content:{
                    
                    Button(action: {
                        self.show_sheet.toggle()
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 40))
                            .foregroundColor(Color.gray)
                    })
                })
            }

        }
        .sheet(isPresented: $show_sheet, onDismiss: {
            dismissed = true
        }){
            Makgeolli_Review_View()
        }
        .toolbar(.hidden, for: .tabBar)
    }
}
//
//struct Review_View_Previews: PreviewProvider {
//    static var previews: some View {
//        Review_View(drink: Drink(id: UUID(), name: "", type: .makgeolli, price: 1, img_url: ""))
//    }
//}
