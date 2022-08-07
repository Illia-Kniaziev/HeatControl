//
//  SwiftSMC.swift
//  HeatControl
//
//  Created by Illia Kniaziev on 09.06.2022.
//

import Foundation
import IOKit

class SwiftSMC {
    
    static let shared = SwiftSMC()
    
    private static var connection: io_connect_t = 0
    
    private init() {
        connect()
    }
    
    private func connect() {
        let matchingDictionary = IOServiceMatching("AppleSMC")
        let service = IOServiceGetMatchingService(kIOMainPortDefault, matchingDictionary)
        let result = IOServiceOpen(service, mach_task_self_, 0, &SwiftSMC.connection)
        
        guard result == kIOReturnSuccess else {
            fatalError("Failed to start SMC. Result: \(result)")
        }
        
        IOObjectRelease(service)
    }
    
    private func disconnect() {
        IOServiceClose(SwiftSMC.connection)
    }
    
    public func bytes(key: String) -> SMCBytes? {
        guard let smcKey: UInt32 = key.smcKey() else { return nil }
        let outputDataSize: IOByteCount = dataSize(smcKey: smcKey)
        let outputBytes: SMCBytes = bytes(smcKey: smcKey, dataSize: outputDataSize)
        return outputBytes
    }
    
    private func dataSize(smcKey: UInt32) -> IOByteCount {
        var inputStructure: SMCStructure = SMCStructure()
        var outputStructure: SMCStructure = SMCStructure()
        
        let inputStructureSize: Int = MemoryLayout<SMCStructure>.stride
        var outputStructureSize: Int = MemoryLayout<SMCStructure>.stride
        
        inputStructure.key = smcKey
        inputStructure.data8 = 9
        
        let _ = IOConnectCallStructMethod(SwiftSMC.connection,
                                          2,
                                          &inputStructure,
                                          inputStructureSize,
                                          &outputStructure,
                                          &outputStructureSize)
        
        return outputStructure.keyInfo.dataSize
    }
    
    private func bytes(smcKey: UInt32, dataSize: UInt32) -> SMCBytes {
        var inputStructure: SMCStructure = SMCStructure()
        var outputStructure: SMCStructure = SMCStructure()
        
        let inputStructureSize: Int = MemoryLayout<SMCStructure>.stride
        var outputStructureSize: Int = MemoryLayout<SMCStructure>.stride
        
        inputStructure.key = smcKey
        inputStructure.keyInfo.dataSize = dataSize
        inputStructure.data8 = 5
        
        let _ = IOConnectCallStructMethod(SwiftSMC.connection,
                                          2,
                                          &inputStructure,
                                          inputStructureSize,
                                          &outputStructure,
                                          &outputStructureSize)
        
        return outputStructure.bytes
    }

    deinit {
        disconnect()
    }
    
}

extension SwiftSMC {
    func cpuTemperature(sensor: Sensor.CPU) -> Double? {
        guard let bytes: SMCBytes = bytes(key: sensor.key) else { return nil }
        
        let celsius: Double = Double(bytes.0 & 0x7F)
        
        return celsius
    }
}
