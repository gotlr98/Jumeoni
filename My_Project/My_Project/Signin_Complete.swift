//
//  Signin_Complete.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/03/14.
//

import SwiftUI





struct Signin_Complete: View, SendStringData{
    
    
    
    @StateObject var kakaoAuthVM: Kakao_AuthVM = Kakao_AuthVM()
    @State var name: String = ""
    var test: String = ""

    
    func sendData(mydata: String) {
        
        let vc = Kakao_AuthVM()
        vc.delegate = self
        
        self.name = mydata
        
    }
    
    
    
//    ContentView
    var body: some View{

        Text("Hello" + test)
    }
}


struct Signin_Complete_Previews: PreviewProvider{
    static var previews: some View{
        Signin_Complete()
    }
}
