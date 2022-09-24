//
//  ContentView.swift
//  Liquid S
//
//  Created by Elaidzha Shchukin on 24.09.2022.
//

import SwiftUI

//24.09

struct ContentView: View {
    
    var body: some View {
      
       Home()
    }
}
//8

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Home: View {
    
    @State var offset = CGSize .zero
    @State var showHome = false
    
    var body: some View {
        
        ZStack {
            
            Color("El")
            
                .overlay(
                    
                    VStack(alignment: .leading, spacing: 10, content: {
                        Text("For developers")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                        
                        Text("The job duties of a software developer typically include tasks such as overseeing software programming, testing software at various phases of completion.")
                            .font(.caption)
                            .bold()
                    })
                    
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .offset(x: -15)
                    
                )
                .clipShape(LiquisSwipe(offset: offset))
                .ignoresSafeArea()
            
                .overlay(
                    
                    Image(systemName: "chevron.left")
                        .font(.largeTitle)
                        .frame(width: 50, height: 50)
                        .contentShape(Rectangle())
                        .gesture(DragGesture().onChanged({ (value) in
                            
                            withAnimation(.interactiveSpring(response: 0, dampingFraction: 0.6, blendDuration: 0.6)) {
                                offset = value.translation
                            }
                        }).onEnded({ (value) in
                            
                            let screen = UIScreen.main.bounds
                            withAnimation(.spring()) {
                                
                                if -offset.width > screen.width / 2 {
                                    offset.width = -screen.height
                                    showHome.toggle()
                                }
                                else {
                                    offset = .zero
                                }
                            }
                        }))
                        .offset(x: 15,y: 58)
                        .opacity(offset == .zero ? 1 : 0)
                    
                    ,alignment: .topTrailing
                    
                )
               
                .padding(.trailing)
            
            if showHome {
                Text("Welcome mobilization")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            offset = .zero
                            showHome.toggle()
                        }
                    }
            }
            
            
        }
    }
}

struct LiquisSwipe: Shape {
    
    var offset: CGSize
    
    var animatableData: CGSize.AnimatableData {
        get {return offset.animatableData}
        set {offset.animatableData = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        return Path {path in
            
            let width = rect.width + (-offset.width > 0 ? offset.width : 0)
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let from = 80 + (offset.width)
            path.move(to: CGPoint(x: rect.width, y: from > 80 ? 80 : from))
            
            var to = 180 + (offset.height) + (-offset.width)
            to = to < 180 ? 180 : to
            
            let mid: CGFloat = 80 + ((to - 80) / 2)
           
            path.addCurve(to: CGPoint(x: rect.width, y: to), control1: CGPoint(x: width - 50, y: mid), control2: CGPoint(x: width - 50, y: mid))
        }
    }
}
