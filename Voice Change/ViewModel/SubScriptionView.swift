//
//  SubScription.swift
//  Voice Change
//
//  Created by Trần Đức Duy on 04/08/2022.
//

import SwiftUI
import PopupView

struct SubScriptionView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var simple:Unlock = .fonts
    
    @State private var imageFonts = "ic_sub1"
    @State private var imageShapes = "ic_sub2"
    @State private var imageSickers = "ic_sub3"
    @State private var imageTemplates = "ic_sub4"
    
    @State private var priceCurrent : Price = .year
    @State private var priceWeek = "3.99$"
    @State private var priceMonth = "7.99$"
    @State private var priceYear = "29.99$"
    
    @State private var saveWeek = ""
    @State private var saveMonth = "Save 20%"
    @State private var saveYear = "Save 80%"
    
    @State private var dateWeek = "/ Week"
    @State private var dateMonth = "/ Month"
    @State private var dateYear = "/ Year"
    
    @State private var isShowprivacy = false
    var body: some View {
       
            ZStack{
            Image("ic_color")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            ZStack{
                ScrollView( showsIndicators: false){
                    Spacer(minLength: 50)
                    VStack{
                        Text("Voice Change")
                            .foregroundColor(.white)
                            .font(.setFont(.bold, size: 20))
                            .padding(4)
                        Text("Unlock All Access")
                            .foregroundColor(.white)
                            .font(.setFont(.medium, size: 16))
                        
                        HStack{
                            ButtonUnlock(value: .fonts, valueSimple: $simple, valueImage: $imageFonts)
                            ButtonUnlock(value: .shapes, valueSimple: $simple, valueImage: $imageShapes)
                            ButtonUnlock(value: .stickers, valueSimple: $simple, valueImage: $imageSickers)
                            ButtonUnlock(value: .templates, valueSimple: $simple, valueImage: $imageTemplates)
                        }
                        Text("Unlock all fonts, shapes, stickers and templates. Remove Ads. Scan unlimited.")
                            .foregroundColor(.white)
                            .font(.setFont(.medium, size: 14))
                            .multilineTextAlignment(.center)
                            .frame(width: UIScreen.width-52, height: 47, alignment: .center)
                        Text("Start your 3-day free trial")
                            .padding(30)
                            .font(.setFont(.medium, size: 16))
                            .frame(width: UIScreen.width-38, height: 21, alignment: .center)
                        VStack{
                            ButtonPrice(priceString: $priceWeek, price: .week, currentPrice: $priceCurrent, savePrice: $saveWeek, datePrice: $dateWeek)
                            ButtonPrice(priceString: $priceMonth, price: .month, currentPrice: $priceCurrent, savePrice: $saveMonth, datePrice: $dateMonth)
                            ButtonPrice(priceString: $priceYear, price: .year, currentPrice: $priceCurrent, savePrice: $saveYear, datePrice: $dateYear)
                        }
                        Button {
                            //continude
                        } label: {
                            VStack{
                                Text("Continue")
                                    .font(.setFont(.medium, size: 16))
                                
                                Text("Auto-renew at the end of the trial")
                                    .font(.setFont(.medium, size: 12))
                                
                            }
                            .padding()
                            .frame(width: UIScreen.width-60, height: 50, alignment: .center)
                            .foregroundColor(.black)
                            .background(.white)
                            .cornerRadius(10)
                        }
                        VStack{
                            Text("Subscription is auto-renewable. Cancel anytime")
                                .font(.setFont(.regular, size: 14))
                                .frame(width: UIScreen.width-66, height: 26, alignment: .center)
                            Text("After the subscription, you can get unlimited access to TextArt pro. According to the policy of the Apple Store, your subscription will be automatically renewed within 24 hours before the free trial expires. If you need to cancel, please manually turn off automatic renewal in the iTunes/ Apple ID settings at least 24 hours before the end of the currently subscription. Users who have already tried VIP and subscribe again will be charged directly.")
                                .frame(width: UIScreen.width-40, height: 86)
                                .multilineTextAlignment(.center)
                                .font(.setFont(.medium, size: 11))
                                .padding()
                            HStack{
                                Button {
                                    //action
                                } label: {
                                    Text("Terms of Use ")
                                        .font(.setFont(.medium, size: 15))
                                }
                                Divider()
                                    .background(Color.white)
                                    .frame(width: 12, height: 17)
                                Button {
                                    isShowprivacy.toggle()
                                } label: {
                                    Text("Privacy Policy")
                                        .font(.setFont(.medium, size: 15))
                                }
                                .popup(isPresented: $isShowprivacy, position: .bottom,closeOnTap: false, closeOnTapOutside: true, backgroundColor: Color.black.opacity(0.7)){
                                    Privacy_Policy{_ in
                                        
                                    }
                                    
                                }
                               
                                
                            }.font(.setFont(.medium, size: 15))
                                .frame(width: UIScreen.width-21, height: 18)
                                
                        }
                        .foregroundColor(.white)
                        
                    }
                }
        
                VStack{
                    HStack{
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Close")
                                .font(.setFont(.regular, size: 16))
                                .opacity(0.8)
                                .foregroundColor(Color(.white))
                        }
                        Spacer()
                        Button {
                           
                        } label: {
                            Text("Restore")
                                .font(.setFont(.semibold, size: 16))
                                .foregroundColor(Color(.white))
                        }
                    }.padding().frame(height: 50, alignment: .top)
                    Spacer()
                }
            }
        }.preferredColorScheme(.dark)
        
    }
}
enum Unlock{
    case fonts
    case shapes
    case stickers
    case templates
}
struct ButtonUnlock: View{
    @State var value: Unlock
    @Binding var valueSimple: Unlock
    @Binding var valueImage: String
    var body: some View{
        let isActive = value == valueSimple
        Button {
            valueSimple = value
        } label: {
            Image(valueImage)
                .frame(width: 32, height: 32, alignment: .center)
        }
        
        
    }
}
enum Price{
    case week
    case month
    case year
}



struct ButtonPrice:View{
    @Binding var priceString: String
    @State var price: Price
    @Binding var currentPrice: Price
    @Binding var savePrice: String
    @Binding var datePrice: String
    
    var body : some View{
        let isActive = currentPrice == price
        Button {
            currentPrice = price
        } label: {
            HStack{
                Image(isActive ? "ic_sub5" : "ic_sub6" )
                HStack{
                    Text(priceString)
                        .font(.headline)
                        .foregroundColor(.white)
                    Group{
                        Text(datePrice)
                            .font(.setFont(.semibold, size: 16))
                            .foregroundColor(.white)
                        Spacer()
                        Text(savePrice)
                            .font(.setFont(.regular, size: 12))
                            .foregroundColor(Color(.white).opacity(0.8))
                            
                    }
                }
            }
        }.frame(width: UIScreen.width - 85, height: 44).padding([.leading,.trailing],12)
            .background{
                RoundedRectangle(cornerRadius: 10).stroke(.white,lineWidth: isActive ? 1 : 0)
            }
            
        
    }
}



struct SubScription_Previews: PreviewProvider {
    static var previews: some View {
        SubScriptionView()
    }
}
