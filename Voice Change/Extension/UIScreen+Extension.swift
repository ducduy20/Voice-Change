//
//  ExtentionScreen.swift
//  Voice Change
//
//  Created by Trần Đức Duy on 04/08/2022.
//

import Foundation
import UIKit
import SwiftUI

extension UIScreen{
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}
extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is true.
    
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>, isHidenNavigationBar : Bool = true, navigationBarTitle:String = "") -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle(navigationBarTitle)
                    .navigationBarHidden(true)
                   
                
                NavigationLink(
                    destination: view
                        .navigationBarTitle(navigationBarTitle, displayMode: .inline)
                        .navigationBarHidden(isHidenNavigationBar),
                    isActive: binding
                )
                {
                    EmptyView()
                }
            }
        }.navigationViewStyle(.stack).ignoresSafeArea()
           
    }
}

