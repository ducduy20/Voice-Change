//
//  MenuBarView.swift
//  Voice Change
//
//  Created by Trần Đức Duy on 05/08/2022.
//

import SwiftUI

struct MenuBarView: View {
    @State private var voiceChange : [Navigation] = Navigation.allCases
    var body: some View {
        
        VStack(alignment: .leading){
            
            
            HStack{
                Image("ic_navi")
                Text("VOICE CHANGE")
                    .frame(width: 126, height: 40)
                    .padding()
                    .foregroundColor(.blue)
            }
            Voice(choice: $voiceChange)
            Spacer(minLength: -120)
        }.frame(alignment: .center)
    }
}


enum Navigation: String,CaseIterable{
    case premium = "Get Premium"
    case policy = "Privacy Policy"
    case share = "Share Qr Code"
    case feedback = "Feedback"
    case other = "Other App"
    case version = "App Version 1.0"
}


struct ButtonNavi: View{
    @Binding var nameSetting: Navigation
    @Binding var imageSetting: Navigation
    var resuilCallBack : (()->())
    var body: some View{
        Button {
            resuilCallBack()
        } label: {
            HStack{
                Image(imageSetting.rawValue)
                    .frame(width: 44, height: 44)
                Text(nameSetting.rawValue)
                    .font(.setFont(.medium, size: 16))
                    .foregroundColor(.black)
            }
        }
    }
}

struct Voice: View{
    @Binding var choice: [Navigation]
    var body: some View{
        VStack(alignment: .leading){
            ForEach($choice, id: \.self) { index in
                ButtonNavi(nameSetting: index, imageSetting: index) {
                    
                }
            }
        }
    }
}

struct MenuBarView_Previews: PreviewProvider {
    static var previews: some View {
        MenuBarView()
    }
}
