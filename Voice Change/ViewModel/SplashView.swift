//
//  SplashView.swift
//  Voice Change
//
//  Created by Trần Đức Duy on 04/08/2022.
//

import SwiftUI


struct SplashView: View {
    @AppStorage ("onbroadring") var onbroadring = true
    @State var start = false
    
    
    
    var body: some View {
        ZStack{
            Image("bg_splash")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                    AnimationView()
                .padding()
                .frame(width:120, height: 120, alignment: .center)
                
                    
                    
                Text("VOICE CHANGE")
                    .foregroundColor(.white)
                    .font(.setFont(.medium, size: 18))
                Spacer()
                
                    Button {
                        onbroadring.toggle()
                    } label: {
                        Text("Get Started")
                            .foregroundColor(.black)
                            .frame(width: UIScreen.width - 60, height: 50, alignment: .center)
                            .font(.setFont(.semibold, size: 16))
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding(.bottom,44)
                    }
            }
        }
        
    }
}

struct AnimationView: View{
    
    @State var animation1 = false
    @State var animation2 = false
    @State var animation3 = false
    var body: some View{
        ZStack{
            Circle()
                .stroke(lineWidth: 1)
                .frame(width: 114, height: 114)
                .foregroundColor(.white)
                .opacity(0.1)
                .scaleEffect(animation1 ? 1 : 1.15)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                        self.animation1.toggle()
                    }
                }
            Circle()
                .stroke(lineWidth: 1)
                .frame(width: 102, height: 102)
                .foregroundColor(.white)
                .opacity(0.2)
                .scaleEffect(animation2 ? 1 : 1.1)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                        self.animation2.toggle()
                    }
                }
            Circle()
                .stroke(lineWidth: 2)
                .frame(width: 92, height: 92)
                .foregroundColor(.white)
                .opacity(0.3)
                .scaleEffect(animation3 ? 1 : 1.05)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                        self.animation3.toggle()
                    }
                }
            
            Circle()
                .fill(.white)
                .frame(width: 82, height: 82)
                
            Image("bt_record")
            
                
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
