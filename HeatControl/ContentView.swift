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

struct PeakTempView: View {
    let label: String
    @Binding var peakTemp: Int
    
    var body: some View {
        HStack(spacing: 0) {
            Text("\(label): ")
                .foregroundColor(.secondary)
                .font(.system(size: 12, weight: .bold, design: .monospaced))
            
            if peakTemp <= 1 {
                Text("-")
                    .font(.system(size: 12, weight: .semibold, design: .monospaced))
            } else {
                RollingText(fontSize: 12, weight: .semibold, design: .monospaced, value: $peakTemp)
            }
            
            Text("°C")
                .foregroundColor(.secondary)
                .font(.system(size: 12, weight: .bold, design: .monospaced))
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
            
            PeakTempView(label: "min", peakTemp: $minTemp)
            
            PeakTempView(label: "max", peakTemp: $maxTemp)
            
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
