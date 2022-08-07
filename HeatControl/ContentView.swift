//
//  ContentView.swift
//  HeatControl
//
//  Created by Illia Kniaziev on 09.06.2022.
//

import Cocoa
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            TitleView()
            TempView()
            Spacer()
        }
        .frame(width: 300, height: 130)
    }
}

struct TitleView: View {
    var body: some View {
        HStack {
            Spacer()
            Label("CPU teperature", systemImage: "flame.fill")
                .foregroundColor(.red)
                .font(.system(.headline, design: .monospaced))
                .padding()
            Spacer()
        }
    }
}

struct TempView: View {
    @State private var temp = 0
    @State private var minTemp = Int.max
    @State private var maxTemp = Int.min
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack {
            Spacer()
            HStack {
                RollingText(fontSize: 32, weight: .semibold, design: .monospaced, value: $temp)
                    .onReceive(timer) { _ in
                        updateTempString()
                    }
                
                Text("°C")
                    .foregroundColor(.secondary)
                    .font(.system(size: 24, weight: .bold, design: .monospaced))
            }
            Spacer()
        }
        .onAppear {
            updateTempString()
        }
        
        Spacer()
        
        HStack(alignment: .center, spacing: 40) {
            Spacer()
            
            HStack(spacing: 0) {
                Text("min: ")
                    .foregroundColor(.secondary)
                    .font(.system(size: 12, weight: .bold, design: .monospaced))
                
                if minTemp == 0 {
                    Text("-")
                        .font(.system(size: 12, weight: .semibold, design: .monospaced))
                } else {
                    RollingText(fontSize: 12, weight: .semibold, design: .monospaced, value: $minTemp)
                }
                
                Text("°C")
                    .foregroundColor(.secondary)
                    .font(.system(size: 12, weight: .bold, design: .monospaced))
            }

            HStack(spacing: 0) {
                Text("max: ")
                    .foregroundColor(.secondary)
                    .font(.system(size: 12, weight: .bold, design: .monospaced))
                
                if maxTemp == 0 {
                    Text("-")
                        .font(.system(size: 12, weight: .semibold, design: .monospaced))
                } else {
                    RollingText(fontSize: 12, weight: .semibold, design: .monospaced, value: $maxTemp)
                }
                
                Text("°C")
                    .foregroundColor(.secondary)
                    .font(.system(size: 12, weight: .bold, design: .monospaced))
            }
            
            Spacer()
        }
    }
    
    func updateTempString() {
        let temp = SwiftSMC.shared.cpuTemperature(sensor: .die)
        if let temp = temp {
            self.temp = Int(temp)
            minTemp = min(minTemp, Int(temp))
            maxTemp = max(maxTemp, Int(temp))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
