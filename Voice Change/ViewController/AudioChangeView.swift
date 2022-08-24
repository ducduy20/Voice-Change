//
//  AudioChangeView.swift
//  Voice Change
//
//  Created by Trần Đức Duy on 17/08/2022.
//

import SwiftUI
import AVFoundation

enum ChangeVoice: String, CaseIterable{
    case normal = "Normal"
    case helium = "Helium"
    case robot = "Robot"
    case cave = "Cave"
    case deep = "Deep Voice"
    case back = "Backwards"
    case monster = "Monster"
    case small = "Small creature"
    case nervous = "Nervous"
    case cyborg = "Cyborg"
    case poltergeist = "Poltergeist"
    case singing = "Singing chipmunks"
    case skull = "Skull mask"
    case drunk = "Drunk"
    case giant = "Gaint"
    case squirrel = "Squirrel"
    case dark = "Drak cyborg"
    case zombie = "Zombie"
    case child = "Child"
    case duck = "Duck"
    case devil = "Devil"
    case fan = "Fan"
    case alien = "Alien"
    case death = "Death"
}
struct ButtonChange: View{
    @Binding var valueVoice: ChangeVoice
    @AppStorage("VOICECURRENT") var voiceCurrent: String = ChangeVoice.alien.rawValue
    @State var resultCallBack: (() -> ())
    
    var body: some View{
        let isActive = (ChangeVoice(rawValue: voiceCurrent) ?? .alien) == valueVoice
        Button {
            voiceCurrent = valueVoice.rawValue
            resultCallBack()
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 90, height: 113, alignment: .center)
                    .background(isActive ? Color("background") :  Color.primary )
                
            
                HStack{
                    Image(valueVoice.rawValue)
                        .foregroundColor(isActive ? Color("button_main") : .white)
                }
            }
        }

        
    }
}

struct ChangeView: View{
    @Binding var voiceChange: [ChangeVoice]
    var resultCallBack: ((ChangeVoice) -> ())
    @State private var fourColumn = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View{
        LazyVGrid(columns: fourColumn, spacing: 2) {
            ForEach($voiceChange, id:\.self) {myVoice in
                ButtonChange(valueVoice: myVoice) {
                    resultCallBack(myVoice.wrappedValue)
                }
            }
        }
    }
}

struct AudioChangeView: View {
    @ObservedObject var vm = VoiceViewModel(numberOfSamples: 200 )
    @Binding var voiceChange : [ChangeVoice]
    @State var playAgain: Bool = false
    @State var playValue: TimeInterval = 0.0
    var audioURL : URL
    var body: some View {
        VStack{
            NavigationView{
                ChangeView(voiceChange: $voiceChange) { _ in}
                    .frame(width: UIScreen.width, height: (UIScreen.height) * 4/5 , alignment: .top)
            }
            VStack{
                Text("\(audioURL.lastPathComponent)")
                HStack(spacing: 10){
                    Button {
                        playAgain.toggle()
                        self.vm.startPlaying(url: self.audioURL)
                    } label: {
                        
                        Image(systemName: playAgain ? "play.fill" : "stop.fill")
                    }
                    Slider(value: $playValue    )
                        .accentColor(.white)
                    

                }
            }
        }
    }
}
