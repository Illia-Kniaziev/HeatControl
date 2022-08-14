//
//  ContentView.swift
//  HeatControl
//
//  Created by Illia Kniaziev on 09.06.2022.
//

import Cocoa
import SwiftUI

struct MonitorView: View {
    
    @ObservedObject var viewModel: MonitorViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Label("CPU teperature", systemImage: "flame.fill")
                .foregroundColor(.red)
                .font(.system(.headline, design: .monospaced))
                .padding()
            
            HStack {
                RollingText(fontSize: 32, weight: .semibold, design: .monospaced, value: $viewModel.temp)
                
                Text("°C")
                    .foregroundColor(.secondary)
                    .font(.system(size: 24, weight: .bold, design: .monospaced))
            }
            
            Spacer()
            
            HStack(alignment: .center, spacing: 40) {
                PeakTempView(label: "min", peakTemp: $viewModel.minTemp)
                
                PeakTempView(label: "max", peakTemp: $viewModel.maxTemp)
            }
            
            Spacer()
        }
        .frame(width: 300, height: 130)
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
            
            if peakTemp == 0 {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MonitorView(viewModel: MonitorViewModel())
    }
}
