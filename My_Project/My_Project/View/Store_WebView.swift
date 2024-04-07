////
////  Store_WebView.swift
////  My_Project
////
////  Created by HaeSik Jang on 2023/04/21.
////
//
//import SwiftUI
//import WebView
//import Combine
//import WebKit
//
//struct Store_WebView: View {
//   
//    @Binding var isToolBarItemHidden: Bool
//    @State var webviewStore = WebViewStore()
//    
//    var url: String
//
//        // showAlert가 true면 알림창이 뜬다 // If showAlert is true, a notification window pops up
//    @State var showAlert: Bool = false
//    
//    // alert에 표시할 내용 // This is the content to be displayed in the alert.
//    @State var alertMessage: String = "error"
//    
//    // 웹뷰 확인/취소 작업을 처리하기 위한 핸드러를 받아오는 변수 // Variable that gets the handler to handle the web view confirmation/cancel operation
//    @State var confirmHandler: (Bool) -> Void = {_ in }
//    
//    
//    var body: some View {
//        let webView = MyWebView(webView: WKWebView(), request: URLRequest(url: URL(string: url)!), showAlert: self.$showAlert, alertMessage: self.$alertMessage, confirmHandler: self.$confirmHandler)
//        
//                    webView
//                    .alert(isPresented: self.$showAlert) { () -> Alert in
//                        var alert = Alert(title: Text(alertMessage))
//                        if(self.showAlert == true) {
//                            alert = Alert(title: Text("알림"), message: Text(alertMessage), primaryButton: .default(Text("OK"), action: {
//                                confirmHandler(true)
//                            }), secondaryButton: .cancel({
//                                confirmHandler(false)
//                            }))
//                        }
//                        return alert;
//                    }
//                    .navigationBarItems(trailing: HStack{
//                        Button(action: webView.goBack){
//                            Image(systemName: "chevron.left")
//                                .imageScale(.large)
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 32, height: 32)
//                        }
////                        .disabled(!webviewStore.canGoBack)
//                        Button(action: webView.goForward){
//                            Image(systemName: "chevron.right")
//                                .imageScale(.large)
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 32, height: 32)
//                        }
////                        .disabled(!webviewStore.canGoForward)
//                        })
////        NavigationView{
//            //            WebView(webView: webviewStore.webView)
//            //                .navigationTitle("술사기")
//            //
//            //                .navigationBarItems(trailing: HStack{
//            //                    Button(action: goBack){
//            //                        Image(systemName: "chevron.left")
//            //                            .imageScale(.large)
//            //                            .aspectRatio(contentMode: .fit)
//            //                            .frame(width: 32, height: 32)
//            //                    }
//            //                    .disabled(!webviewStore.canGoBack)
//            //                    Button(action: goForward){
//            //                        Image(systemName: "chevron.right")
//            //                            .imageScale(.large)
//            //                            .aspectRatio(contentMode: .fit)
//            //                            .frame(width: 32, height: 32)
//            //                    }.disabled(!webviewStore.canGoForward)
//            //                })
//            //
//            //        }.onAppear{
//            //            self.webviewStore.webView.load(URLRequest(url: URL(string: url)!))
//            //        }
////        }
//    }
////    func goBack() {
////        webviewStore.webView.goBack()
////      }
////
////    func goForward() {
////        webviewStore.webView.goForward()
////
////    }
//    
//}
//
//
//
////struct Store_WebView_Previews: PreviewProvider {
////    static var previews: some View {
////        Store_WebView()
////    }
////}
