//
//  MainView.swift
//  Voice Change
//
//  Created by Trần Đức Duy on 05/08/2022.
//

import SwiftUI
import AudioToolbox
import UIKit

private let numberOfSamples = 200
struct MainView: View {
    @ObservedObject var vm = VoiceViewModel(numberOfSamples: numberOfSamples)
    @Environment(\.presentationMode) var presentationMode
    @State var showMenu = false
    @State private var menuOpen = false
    @State var king = false
    
    @State var voiceCurrent : [ChangeVoice] = []
    @State private var showRecord =  true
    @State var animation1 = false
    @State var animation2 = false
    @State var animation3 = false
    @State var exporterFile = false
    @State var fileName = ""
    @State private var scrollTarget: Int?
    
    @State private var changeView: Bool = false
    @State var voiceChange: [ChangeVoice] = []
    private func normalizeSound(level: Float) -> CGFloat {
        let level = max(0.2, CGFloat(level) + 40) / 2
        return CGFloat(level * (250 / 20))
    }
    @State var recorder = false
    var body: some View {
        ZStack{
            HStack{
                if showRecord{
                    Button {
                        withAnimation {
                            showMenu.toggle()
                        }
                    } label: {
                        Image("ic_main")
                            .padding()
                    }
                }
                Spacer()
                if showRecord{
                    Text("Voice Change")
                        .font(.headline)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 1.5)) {
                                showRecord = true
                            }
                        }
                }else{
                    if vm.isRecording{
                        Text("Recording")
                            .font(.headline)
                            .padding(.top, 23)
                    }else{
                        Text("Record")
                            .font(.headline)
                            .padding(.top, 23)
                    }
                }
                Spacer()
                if showRecord{
                    Button {
                        king.toggle()
                        if king == true {
                            showMenu = false
                        }
                    } label: {
                        Image("ic_king")
                            .padding()
                    }
                    .fullScreenCover(isPresented: $king, content: SubScriptionView.init)
                }
            }
            .frame(width: UIScreen.width, height: UIScreen.height - 40, alignment: .top)
            if showRecord{
                VStack{
                    Image("ic_nofile")
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 0.3)) {
                                self.showRecord = true
                            }
                        }
                    
                    Text("Click the button below to start a new Record")
                        .font(.setFont(.medium, size: 15))
                        .foregroundColor(Color.black)
                        .frame(width: UIScreen.width-127, height: 38)
                        .multilineTextAlignment(.center)
                }
                .frame(width: UIScreen.width, height: UIScreen.height - 200, alignment: .top)
                Spacer()
            } else{
                if vm.isRecording == false{
                    Rectangle()
                        .stroke(.black.opacity(0.3),lineWidth: 1)
                        .frame( height: UIScreen.height / 2, alignment: .center)
                }else {
                    // MARK: WAVE Form
                    if vm.isCaptupredMode == false{
                        ScrollViewReader { scroll in
                            ScrollView(.horizontal){
                                HStack(spacing: 2) {
                                    ForEach(self.vm.soundSample, id:\.self){level in
                                        BarView(value: self.normalizeSound(level: level))
                                    }
                                }
                                
                            }
                            
                        }.offset( y: -130)
                    }
                }
            }
            // MARK: BottomSheet
            if showRecord == true  {
                ZStack{
                    Circle()
                        .fill(Color("button_main"))
                        .frame(width: 850, height: 850, alignment: .top)
                        .offset(y:UIScreen.height - 150)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 2)) {
                                showRecord = false
                            }
                        }
                    VStack{
                        Button {
                            withAnimation{
                                showRecord.toggle()
                            }
                        } label: {
                            VStack{
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
                                    
                                    Image( "bt_record")
                                    
                                }
                                
                                Text("Tap to record")
                                    .font(.setFont(.medium, size: 16))
                                    .foregroundColor(.white)
                                
                            }
                        }
                    }.offset(y: 100)
                }
                .frame(width: UIScreen.width, height: UIScreen.height, alignment: .top)
                
            }else{
                ZStack{
                    Circle()
                        .fill(Color("button_main"))
                        .frame(width: 850, height: 850, alignment: .top)
                        .offset(y: 370)
                    VStack{
                        HStack{
                            if vm.minutes < 10{
                                Text("0" + "\(vm.minutes )" + " :")
                            }else{
                                Text("\(vm.minutes )" + " :" )
                            }
                            if vm.seconds < 10 {
                                Text("0" + "\(vm.seconds )")
                            }else{
                                Text("\(vm.seconds )")
                            }
                        }
                        .font(.system(size:40 ))
                        .foregroundColor(.white)
                        .opacity(vm.isRecording ? 1 : 0.6 )
                        HStack(spacing: 61){
                            if vm.isRecording == false{
                                Button {
                                    self.exporterFile.toggle()
                                } label: {
                                    VStack{
                                        Image("ic_record1")
                                            .padding(5)
                                        Text("Open file")
                                            .foregroundColor(.white)
                                    }
                                }
                                .fileImporter(isPresented: $exporterFile, allowedContentTypes: [.audio]) { res in
                                    do{
                                        let fileURL = try res.get()
                                        
                                        print(fileURL)
                                        self.fileName = fileURL.lastPathComponent
                                    }catch {
                                        print(error.localizedDescription)
                                    }
                                }
                            }
                            Button {
                                if vm.isRecording == true || changeView == false {
                                    
                                }
                            } label: {
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
                                            withAnimation (Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)){
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
                                    Image( vm.isRecording ? "bt_recording" : "bt_record")
                                        .onTapGesture {
                                            if vm.isRecording == false {
                                                vm.startRecording()
                                            }else{
                                                changeView = true
                                                vm.stopRecording()
                                            }
                                        }
                                }
                            }
                            if vm.isRecording == false {
                                Button {
                                    showRecord.toggle()
                                } label: {
                                    VStack{
                                        Image("ic_record2")
                                            .padding()
                                        Text("Close")
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                        .frame(width: UIScreen.width, alignment: .center)
                    }
                    .offset( y: 100)
                }
                .frame(width: UIScreen.width, height: UIScreen.height, alignment: .top)
            }
            Spacer()
                .preferredColorScheme(.light)
            ShowMenu(width: 270, isOpen: showMenu, menuClose: self.openMenu)
        }
        .navigate(to: ChangeView(voiceChange: ChangeVoice.allCases, resultCallBack: {_ in}, audioURL: vm.getDocumentDirectory()), when: $changeView, isHidenNavigationBar: false, navigationBarTitle: "Audio Change")
        .onAppear {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            AppDelegate.orientationLock = .portrait
            }.onDisappear {
                        AppDelegate.orientationLock = .all
            }
    }
    func openMenu(){
        self.showMenu.toggle()
    }
}

struct BarView: View{
    var value: CGFloat
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 1)
                .frame(width: 2, height: value)
        }
    }
}

struct ShowMenu: View{
    let width: CGFloat
    let isOpen: Bool
    let menuClose: ()->Void
    @State var showMenu = false
    
    var body: some View{
        ZStack{
            GeometryReader{_ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.5))
            .opacity(self.isOpen ? 1 : 0)
            .onTapGesture {
                withAnimation(Animation.default) {
                    self.menuClose()
                }
                
            }
            HStack{
                MenuBarView()
                    .frame(width: self.width)
                    .background(.white)
                    .offset(x: self.isOpen ? 0:-self.width)
                
                
                Spacer()
            }
        }
    }
}



