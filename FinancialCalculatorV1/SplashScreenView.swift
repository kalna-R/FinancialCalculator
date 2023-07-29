//
//  SplashScreenView.swift
//  FinancialCalculatorV1
//
//  Created by user233619 on 7/27/23.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var isActive = false
    
    @State private var size = 0.8
    @State private var opacity = 1.0
    
    
    var body: some View {
        
        if isActive {
            TabViewHelper()
        }
        
        else {
            VStack {
                VStack {
                    Image("calc")
                        .resizable()
                        .scaledToFit()
                        .frame(width:200, height: 100)
                        .font(.system(size: 80))
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .padding(10)
                    
                    Text("Financial Calculator")
                        .fontWeight(.bold)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 0.8)){
                        self.size = 0.9
                        self.opacity = 1.0
                    }
            }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    self.isActive = true
                }
            }
        }
        
        
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
