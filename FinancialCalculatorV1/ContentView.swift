//
//  ContentView.swift
//  FinancialCalculatorV1
//
//  Created by user233619 on 7/22/23.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let title: String
    let image: String
    let imageColor: Color
}

struct ContentView: View {
    
    // private var buttonTypes:[String] = ["Savings", "Loan", "Mortgage", "Help"]
    
    let buttonTypes = [
        Item(title: "Savings", image: "savings", imageColor: .white),
        Item(title: "Loan", image: "loan", imageColor: .blue),
        Item(title: "Mortgage", image: "mortgage", imageColor: .blue),
        Item(title: "Help", image: "help 2", imageColor: Color.orange.opacity(0.8))
    ]
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170), spacing: 20)
    ]
    
    var body: some View {
        
        NavigationView {
            VStack{
                ScrollView {
                    // header
                    headerView
                    
                    // nav icons
                    LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                        ForEach(buttonTypes) { button in
                            
                            let type = button.title;
                            
                            switch type {
                            case "Savings":
                                NavigationLink(destination: SavingView()) {
                                    ItemView(item: button)
                                }
                                .buttonStyle(PlainButtonStyle())
                            case "Loan":
                                NavigationLink(destination: LoanView()) {
                                    ItemView(item: button)
                                }
                                .buttonStyle(PlainButtonStyle())
                            case "Mortgage":
                                NavigationLink(destination: MortgageView()) {
                                    ItemView(item: button)
                                }
                                .buttonStyle(PlainButtonStyle())
                            case "Help":
                                NavigationLink(destination: HelpView()) {
                                    ItemView(item: button)
                                }
                                .buttonStyle(PlainButtonStyle())
                            default:
                                NavigationLink(destination: SavingView()) {
                                    ItemView(item: button)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .padding(.horizontal)
                    .offset(y: -60)
                }
                .background(Color.white)
                .ignoresSafeArea()
                
            }
        }
    }
}

var headerView: some View {
    VStack {
        VStack{
            Image("calc")
                .resizable()
                .frame(width:200, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .padding(10)
            
            Text("Welcome!")
                .foregroundColor(.white)
                .font(.system(size: 25, weight: .medium, design: .rounded))
            
            Text("Financial Calculator")
                .foregroundColor(Color.white.opacity(0.7))
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .medium, design: .rounded))
        }
    }
    .frame(height: 400)
    .frame(maxWidth: .infinity)
    .background(Color.blue.opacity(0.6))
}

struct ItemView: View {
    let item: Item
    
    var body: some View {
        GeometryReader {reader in
            VStack(spacing:15){
                Image(item.image)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(item.imageColor)
                    .frame(width: 50)
                
                Text(item.title)
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .foregroundColor(Color.black.opacity(0.9))
            }
            .frame(width: reader.size.width, height: reader.size.height)
            .background(Color.white)
        }
        .frame(height:150)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.2), radius: 10, y:5)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
