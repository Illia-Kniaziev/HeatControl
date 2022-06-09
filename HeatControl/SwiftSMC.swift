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
        
        let arr = [
            kIOReturnAborted,
            kIOReturnBadArgument,
            kIOReturnBadMedia,
            kIOReturnBadMessageID,
            kIOReturnBusy,
            kIOReturnCannotLock,
            kIOReturnCannotWire,
            kIOReturnDMAError,
            kIOReturnDeviceError,
            kIOReturnError,
            kIOReturnExclusiveAccess,
            kIOReturnIOError,
            kIOReturnIPCError,
            kIOReturnInternalError,
            kIOReturnInvalid,
            kIOReturnIsoTooNew,
            kIOReturnIsoTooOld,
            kIOReturnLockedRead,
            kIOReturnLockedWrite,
            kIOReturnMessageTooLarge,
            kIOReturnNoBandwidth,
            kIOReturnNoChannels,
            kIOReturnNoCompletion,
            kIOReturnNoDevice,
            kIOReturnNoFrames,
            kIOReturnNoInterrupt,
            kIOReturnNoMedia,
            kIOReturnNoMemory,
            kIOReturnNoPower,
            kIOReturnNoResources,
            kIOReturnNoSpace,
            kIOReturnNotAligned,
            kIOReturnNotAttached,
            kIOReturnNotFound,
            kIOReturnNotOpen,
            kIOReturnNotPermitted,
            kIOReturnNotPrivileged,
            kIOReturnNotReadable,
            kIOReturnNotReady,
            kIOReturnNotResponding,
            kIOReturnNotWritable,
            kIOReturnOffline,
            kIOReturnOverrun,
            kIOReturnPortExists,
            kIOReturnRLDError,
            kIOReturnStillOpen,
            kIOReturnTimeout,
            kIOReturnUnderrun,
            kIOReturnUnformattedMedia,
            kIOReturnUnsupported,
            kIOReturnUnsupportedMode,
            kIOReturnVMError,
            kIOReturnError,
            kIOReturnNoMemory,
            kIOReturnNoResources,
            kIOReturnIPCError,
            kIOReturnNoDevice,
            kIOReturnNotPrivileged,
            kIOReturnBadArgument,
            kIOReturnLockedRead,
            kIOReturnLockedWrite,
            kIOReturnExclusiveAccess,
            kIOReturnBadMessageID,
            kIOReturnUnsupported,
            kIOReturnVMError,
            kIOReturnInternalError,
            kIOReturnIOError,
            kIOReturnCannotLock,
            kIOReturnNotOpen,
            kIOReturnNotReadable,
            kIOReturnNotWritable,
            kIOReturnNotAligned,
            kIOReturnBadMedia,
            kIOReturnStillOpen,
            kIOReturnRLDError,
            kIOReturnDMAError,
            kIOReturnBusy,
            kIOReturnTimeout,
            kIOReturnOffline,
            kIOReturnNotReady,
            kIOReturnNotAttached,
            kIOReturnNoChannels,
            kIOReturnNoSpace,
            kIOReturnPortExists,
            kIOReturnCannotWire,
            kIOReturnNoInterrupt,
            kIOReturnNoFrames,
            kIOReturnMessageTooLarge,
            kIOReturnNotPermitted,
            kIOReturnNoPower,
            kIOReturnNoMedia,
            kIOReturnUnformattedMedia,
            kIOReturnUnsupportedMode,
            kIOReturnUnderrun,
            kIOReturnOverrun,
            kIOReturnDeviceError,
            kIOReturnNoCompletion,
            kIOReturnAborted,
            kIOReturnNoBandwidth,
            kIOReturnNotResponding,
            kIOReturnIsoTooOld,
            kIOReturnIsoTooNew,
            kIOReturnNotFound,
            kIOReturnInvalid,
        ]
        
        let barr = [
            "kIOReturnAborted",
            "kIOReturnBadArgument",
            "kIOReturnBadMedia",
            "kIOReturnBadMessageID",
            "kIOReturnBusy",
            "kIOReturnCannotLock",
            "kIOReturnCannotWire",
            "kIOReturnDMAError",
            "kIOReturnDeviceError",
            "kIOReturnError",
            "kIOReturnExclusiveAccess",
            "kIOReturnIOError",
            "kIOReturnIPCError",
            "kIOReturnInternalError",
            "kIOReturnInvalid",
            "kIOReturnIsoTooNew",
            "kIOReturnIsoTooOld",
            "kIOReturnLockedRead",
            "kIOReturnLockedWrite",
            "kIOReturnMessageTooLarge",
            "kIOReturnNoBandwidth",
            "kIOReturnNoChannels",
            "kIOReturnNoCompletion",
            "kIOReturnNoDevice",
            "kIOReturnNoFrames",
            "kIOReturnNoInterrupt",
            "kIOReturnNoMedia",
            "kIOReturnNoMemory",
            "kIOReturnNoPower",
            "kIOReturnNoResources",
            "kIOReturnNoSpace",
            "kIOReturnNotAligned",
            "kIOReturnNotAttached",
            "kIOReturnNotFound",
            "kIOReturnNotOpen",
            "kIOReturnNotPermitted",
            "kIOReturnNotPrivileged",
            "kIOReturnNotReadable",
            "kIOReturnNotReady",
            "kIOReturnNotResponding",
            "kIOReturnNotWritable",
            "kIOReturnOffline",
            "kIOReturnOverrun",
            "kIOReturnPortExists",
            "kIOReturnRLDError",
            "kIOReturnStillOpen",
            "kIOReturnTimeout",
            "kIOReturnUnderrun",
            "kIOReturnUnformattedMedia",
            "kIOReturnUnsupported",
            "kIOReturnUnsupportedMode",
            "kIOReturnVMError",
            "kIOReturnError",
            "kIOReturnNoMemory",
            "kIOReturnNoResources",
            "kIOReturnIPCError",
            "kIOReturnNoDevice",
            "kIOReturnNotPrivileged",
            "kIOReturnBadArgument",
            "kIOReturnLockedRead",
            "kIOReturnLockedWrite",
            "kIOReturnExclusiveAccess",
            "kIOReturnBadMessageID",
            "kIOReturnUnsupported",
            "kIOReturnVMError",
            "kIOReturnInternalError",
            "kIOReturnIOError",
            "kIOReturnCannotLock",
            "kIOReturnNotOpen",
            "kIOReturnNotReadable",
            "kIOReturnNotWritable",
            "kIOReturnNotAligned",
            "kIOReturnBadMedia",
            "kIOReturnStillOpen",
            "kIOReturnRLDError",
            "kIOReturnDMAError",
            "kIOReturnBusy",
            "kIOReturnTimeout",
            "kIOReturnOffline",
            "kIOReturnNotReady",
            "kIOReturnNotAttached",
            "kIOReturnNoChannels",
            "kIOReturnNoSpace",
            "kIOReturnPortExists",
            "kIOReturnCannotWire",
            "kIOReturnNoInterrupt",
            "kIOReturnNoFrames",
            "kIOReturnMessageTooLarge",
            "kIOReturnNotPermitted",
            "kIOReturnNoPower",
            "kIOReturnNoMedia",
            "kIOReturnUnformattedMedia",
            "kIOReturnUnsupportedMode",
            "kIOReturnUnderrun",
            "kIOReturnOverrun",
            "kIOReturnDeviceError",
            "kIOReturnNoCompletion",
            "kIOReturnAborted",
            "kIOReturnNoBandwidth",
            "kIOReturnNotResponding",
            "kIOReturnIsoTooOld",
            "kIOReturnIsoTooNew",
            "kIOReturnNotFound",
            "kIOReturnInvalid",
        ]
        
        guard result == kIOReturnSuccess else {
            
            for (index, e) in arr.enumerated() {
                if result == e {
                    print(barr[index])
                }
            }
            
            fatalError("Failed to start SMC. Result: \(result), \(kIOReturnError)")
        }
        
        IOObjectRelease(SwiftSMC.connection)
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
//        guard let bytes = bytes(key: "TC0F") else { return nil }
//
//        let temp = Double(bytes.0 & 0x7F)
//
//        return temp
        
        guard let bytes: SMCBytes = bytes(key: Sensor.CPU.die.key) else { return nil }
        
        let celsius: Double = Double(bytes.0 & 0x7F)
        
        return celsius
    }
    
    public func printSystemInformation() {
        print()
        print("------------------")
        print("System Information")
        print("------------------")
        
        // CPU
        print()
        print("CPU (°C)")
        for sensor in Sensor.CPU.allCases {
            let cpuTemperature = SwiftSMC.shared.cpuTemperature(sensor: sensor)
            print("\(sensor.title) [\(sensor.key)]: \(cpuTemperature ?? -1222.0)")
        }
        
        print()
        print("------------------")
        print()
    }
}
