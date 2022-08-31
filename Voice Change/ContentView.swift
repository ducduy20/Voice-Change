//
//  ContentView.swift
//  Voice Change
//
//  Created by Trần Đức Duy on 04/08/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm = VoiceViewModel(numberOfSamples: 200)
    var body: some View {
        //MenuBarView()
        //SplashView()
        //ContentsView()
        //RecordingTest(audioRecorder: AudioRecorder())
        //WaveForm()
        MainViewController()
        //WaveFormView()
        //ContentsView()
        //ChangeView(voiceChange: ChangeVoice.allCases, resultCallBack: {_ in}, audioURL: vm.getDocumentDirectory())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
