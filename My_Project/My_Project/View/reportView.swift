//
//  reportView.swift
//  My_Project
//
//  Created by HaeSik Jang on 2023/09/14.
//

import SwiftUI

struct reportView: View {
    
    @State var report: String = ""
    @State var show_alert: Bool = false
    @State var empty_field: Bool = false
    @Binding var isClicked: Bool
    
    var body: some View {
        VStack{
            TextEditor(text: $report)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
                .textInputAutocapitalization(.never)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200)
            
            Button(action: {
                if report.isEmpty{
                    empty_field = true
                }
                else{
                    show_alert = true
                    isClicked = false
                }
                
                
            }, label: {
                Rectangle()
                    .frame(width: 100, height: 50)
                    .foregroundColor(Color.secondary)
                    .overlay{
                        Text("신고하기")
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                    }
            })
            .alert(isPresented: $empty_field){
                Alert(title: Text("내용을 입력해주세요"), message: nil, dismissButton: .default(Text("확인")))
            }
            .alert(isPresented: $show_alert){
                Alert(title: Text("신고가 완료됐습니다"), message: nil, dismissButton: .default(Text("확인")))
            }
        }
    }
}

struct reportView_Previews: PreviewProvider {
    static var previews: some View {
        reportView(isClicked: .constant(true))
    }
}
