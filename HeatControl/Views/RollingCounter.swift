//
//  RollingText.swift
//  RollingCounter
//
//  Created by Illia Kniaziev on 05.08.2022.
//

import SwiftUI

struct RollingText: View {
    
    var fontSize: CGFloat = 14
    var weight: Font.Weight = .regular
    var design: Font.Design = .default
    
    @Binding var value: Int
    @State var animationRange: [Int] = []
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<animationRange.count, id: \.self) { index in
                Text("0")
                    .font(.system(size: fontSize, weight: weight, design: design))
                    .opacity(0)
                    .overlay {
                        GeometryReader { proxy in
                            let size = proxy.size
                            
                            VStack(spacing: 0) {
                                ForEach(0...9, id: \.self) { number in
                                    Text(String(number))
                                        .font(.system(size: fontSize, weight: weight, design: design))
                                        .frame(width: size.width, height: size.height, alignment: .center)
                                }
                            }
                            .offset(y: -CGFloat(animationRange[index]) * size.height)
                        }
                        .clipped()
                    }
            }
        }
        .onAppear() {
            animationRange = Array(repeating: 0, count: String(value).count)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.07) {
                updateText()
            }
        }
        .onChange(of: value) { _ in
            let extra = String(value).count - animationRange.count
            if extra > 0 {
                for _ in 0..<extra {
                    withAnimation(.easeIn(duration: 0.1)) {
                        animationRange.append(0)
                    }
                }
            } else {
                for _ in 0..<(-extra) {
                    withAnimation(.easeIn(duration: 0.1)) {
                        animationRange.removeLast()
                    }
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.07) {
                updateText()
            }
        }
    }
    
    func updateText() {
        let stringValue = String(value)
        for (index, value) in zip(0..<stringValue.count, stringValue) {
            var fraction = Double(index) * 0.15
            fraction = fraction > 0.5 ? 0.5 : fraction
            withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 1, blendDuration: 1 + fraction)) {
                animationRange[index] = (String(value) as NSString).integerValue
            }
        }
    }
    
}
