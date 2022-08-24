//
//  MainViewController.swift
//  Voice Change
//
//  Created by Trần Đức Duy on 17/08/2022.
//

import SwiftUI




struct MainViewController: View {
    @AppStorage ("onbroadring") var onbroadring = true
    var body: some View {
        if onbroadring {
            SplashView()
        } else {
            withAnimation(Animation.default){
            
                MainView()
            
            }
            
        }
    }
}

struct MainViewController_Previews: PreviewProvider {
    static var previews: some View {
        MainViewController()
    }
}
