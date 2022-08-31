//
//  AudioChangeView.swift
//  Voice Change
//
//  Created by Trần Đức Duy on 17/08/2022.
//

import SwiftUI
import AVFoundation
import UniformTypeIdentifiers

enum ChangeVoice: String, CaseIterable{
    case normal = "Normal"
    case robot = "Robot"
    case cave = "Cave"
    case deep = "Deep Voice"
    case back = "Backwards"
    case monster = "Monster"
    case small = "Small creature"
    case nervous = "Nervous"
    case poltergeist = "Poltergeist"
    case singing = "Singing chipmunks"
    case skull = "Skull mask"
    case drunk = "Drunk"
    case giant = "Gaint"
    case squirrel = "Squirrel"
    case duck = "Duck"
    case devil = "Devil"
    case fan = "Fan"
    case alien = "Alien"
    case death = "Death"
}
struct ButtonChange: View{
    @Binding var valueVoice: ChangeVoice
    @AppStorage("VOICECURRENT") var voiceCurrent: String = ChangeVoice.normal.rawValue
    @State var resultCallBack: (() -> ())
    
    var body: some View{
        let isActive = (ChangeVoice(rawValue: voiceCurrent) ?? .normal) == valueVoice
        Button {
            voiceCurrent = valueVoice.rawValue
            resultCallBack()
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(isActive ? Color("background") :  Color.white )
                    .frame(width: 90, height: 113, alignment: .center)
                    
                VStack{
                    Spacer()
                        Image(valueVoice.rawValue)
                        .renderingMode(.template)
                        .foregroundColor(isActive ? Color.white : Color("button_main"))
                    Spacer()
                        Text(valueVoice.rawValue)
                            .foregroundColor(isActive ? Color.white : Color.blue)
                            .font(.setFont(.medium, size: 16))
                    Spacer()
                }
            }
        }
    }
}

struct ChangeView: View{
    @ObservedObject var vm = VoiceViewModel(numberOfSamples: 100)
    @State var voiceChange: [ChangeVoice]
    var resultCallBack: ((ChangeVoice) -> ())
    @State var currentTime: TimeInterval = 0
    @State var currentDuration: TimeInterval = 0
    var audioURL: URL
    @State private var fourColumn = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @State var playAudio: Bool = false
    var body: some View{
        VStack {
            ScrollView( showsIndicators: false) {
                LazyVGrid(columns: fourColumn, spacing: 2) {
                    ForEach($voiceChange, id:\.self) {myVoice in
                        ButtonChange(valueVoice: myVoice) {
                            resultCallBack(myVoice.wrappedValue)
                        }
                    }
                }
            }
            VStack{
                Text("\(audioURL.lastPathComponent)")
                    .foregroundColor(.white)
                    .font(.headline)
                HStack(spacing: 10){
                    Spacer()
                    Button {
                        self.vm.startPlaying(url: self.audioURL)
                        playAudio.toggle()
                    } label: {
                        Image(systemName: playAudio ? "stop.fill" : "play.fill")
                            .foregroundColor(.white)
                    }
                    Spacer()
                    
                    Slider(value: $currentTime)
                        .accentColor(.white)
                    
                    Spacer()
                    Button {
                        
                    } label: {
                        Image("ic_download")
                    }

                Spacer()
                }
            }
            .padding()
            .frame(width: UIScreen.width)
            .background(Color.blue)
        }
    }
}

struct ChangeView_Previews: PreviewProvider{
    @ObservedObject static var vm = VoiceViewModel(numberOfSamples: 200)
    static var previews: some View{
        ChangeView(voiceChange: ChangeVoice.allCases, resultCallBack: {_ in}, audioURL: vm.getDocumentDirectory())
    }
}

