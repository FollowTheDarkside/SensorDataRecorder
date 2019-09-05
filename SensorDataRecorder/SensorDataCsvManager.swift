//
//  SensorDataCsvManager.swift
//  SensorDataRecorder
//
//  Created by FTD on 2019/09/04.
//  Copyright © 2019 FTD. All rights reserved.
//

import Foundation

class SensorDataCsvManager {
    
    private(set) var isRecording = false
    private let headerText = "timestamp,attitudeX,attitudeY,attitudeZ,gyroX,gyroY,gyroZ,gravityX,gravityY,gravityZ,accX,accY,accZ"
    private var recordText = ""
    
    var format = DateFormatter()
    
    
    init() {
        format.dateFormat = "yyyyMMddHHmmssSSS"
    }
    
    func startRecording() {
        recordText = ""
        recordText += headerText + "\n"
        isRecording = true
    }
    
    func stopRecording() {
        isRecording = false
    }
    
    func addRecordText(addText:String) {
        recordText += addText + "\n"
    }
    
    func saveSensorDataToCsv(fileName:String) {
        
        let filePath = NSHomeDirectory() + "/Documents/" + fileName + ".csv"
        
        do{
            try recordText.write(toFile: filePath, atomically: false, encoding: String.Encoding.utf8)
            print("Success to Write CSV")
        }catch let error as NSError{
            print("Failure to Write CSV\n\(error)")
        }
    }
}
