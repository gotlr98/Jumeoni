//
//  SideView.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/04/03.
//

import SwiftUI

struct SideView: View {
    @State var isCliked: Bool = false
    var body: some View {
        
        NavigationView{
            VStack(alignment: .leading){
                
                NavigationLink(destination: Signin_Complete(), isActive: $isCliked, label:{
                    Button(action: {
                        isCliked = true
                    }, label: {
                        Text("Soju")
                            .foregroundColor(Color.black)
                    })
                })
                
                NavigationLink(destination: Signin_Complete(), isActive: $isCliked, label:{
                    Button(action: {
                        isCliked = true
                    }, label: {
                        Text("Beer")
                            .foregroundColor(Color.black)
                    })
                })
                
            }
        }
        
    }
}

struct SideView_Previews: PreviewProvider {
    static var previews: some View {
        SideView()
    }
}
