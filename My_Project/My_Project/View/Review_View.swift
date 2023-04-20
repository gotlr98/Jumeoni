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
    @Binding var review: Results<Makgeolli_Review>
    
    @State var show_sheet: Bool = false
    @State private var dismissed: Bool = false
    @Binding var selected_type: Drink.drink_type
    var name: String
    
    var body: some View {
        VStack {
           
            List{
                ForEach(review, id: \.self){ review in
                    if drink.name == review.drink_name{
                        VStack(alignment: .leading){
                            Text(review.name + "님: ")
                            
                            HStack{
                                Text("단맛 : " + String(review.sweet))
                                Text("신맛 : " + String(review.sour))
                                Text("쓴맛 : " + String(review.bitter))
                                Text("청량감 : " + String(review.refreshing))
                                Text("걸쭉함 : " + String(review.thick))
                            }
                            
                        }
                    }
                }
            }
            .refreshable{
                review = get_All_Makgeolli_Review()
            }
            
            .listStyle(.sidebar)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing, content:{
                    
                    Button(action: {
                        self.show_sheet.toggle()
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 20))
                            .foregroundColor(Color.gray)
                    })
                })
            }

        }
        .fullScreenCover(isPresented: $show_sheet, onDismiss: {
            dismissed = true
        }){
            if selected_type == .makgeolli{
                Makgeolli_Review_View(show_sheet: $show_sheet, name: name)
            }
            
        }
//        .toolbar(.hidden, for: .tabBar)
    }
}
//
//struct Review_View_Previews: PreviewProvider {
//    static var previews: some View {
//        Review_View(drink: Drink(id: UUID(), name: "", type: .makgeolli, price: 1, img_url: ""))
//    }
//}
