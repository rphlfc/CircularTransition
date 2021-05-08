//
//  ContentView.swift
//  CircularTransition
//
//  Created by Raphael Cerqueira on 08/05/21.
//

import SwiftUI

struct ContentView: View {
    @State var showSecondView = false
    @Namespace var animation
    
    var body: some View {
        ZStack {
            Text("Hello, world!")
                .padding()
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            showSecondView.toggle()
                        }
                    }, label: {
                        ZStack {
                            Circle()
                                .matchedGeometryEffect(id: "background", in: animation)
                                .frame(width: 60, height: 60)
                            
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                        }
                    })
                }
                .padding()
            }
            
            if showSecondView {
                SecondView(isVisible: $showSecondView, animation: animation)
            }
        }
    }
}

struct SecondView: View {
    @Binding var isVisible: Bool
    let screen = UIScreen.main.bounds
    var animation: Namespace.ID
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.blue)
                .matchedGeometryEffect(id: "background", in: animation)
                .frame(width: calculateRadius(), height: calculateRadius())
            
            Button(action: {
                withAnimation {
                    isVisible.toggle()
                }
            }, label: {
                Text("Close")
                    .foregroundColor(.white)
            })
        }
    }
    
    func calculateRadius() -> CGFloat {
        let sideOne = screen.width / 2
        let sideTwo = screen.height / 2
        let aux = pow(sideOne, 2) + pow(sideTwo, 2)
        let radius = sqrt(aux)
        return radius * 2
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
