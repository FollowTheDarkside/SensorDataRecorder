//
//  ViewController.swift
//  SensorDataRecorder
//
//  Created by FTD on 2019/09/02.
//  Copyright © 2019 FTD. All rights reserved.
//

import UIKit
import CoreMotion
import simd
import CoreML

class ViewController: UIViewController {
    
    
    @IBOutlet weak var sensorDataInfoTextView: UITextView!
    @IBOutlet weak var sensorIntervalLabel: UILabel!
    @IBOutlet weak var sensorIntervalSlider: UISlider!
    @IBOutlet weak var recordCsvButton: CustomButton!
    @IBOutlet weak var csvFileManagementButton: CustomButton!
    
    let motionManager = CMMotionManager()
    var attitude = SIMD3<Double>.zero
    var gyro = SIMD3<Double>.zero
    var gravity = SIMD3<Double>.zero
    var acc = SIMD3<Double>.zero
    
    var format = DateFormatter()
    let csvManager = SensorDataCsvManager()
    
    let inputDataLength = 50
    var compAccArray = [Double]()
    var classLabel = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startSensorUpdates(intervalSeconds: 0.02) // 50Hz
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func changeSensorIntervalSlider(_ sender: UISlider) {
        let val = round(sender.value)
        sensorIntervalSlider.value = val
        
        // change sensor interval
        stopSensorUpdates()
        let intervalSec = Double(1.0/val)
        startSensorUpdates(intervalSeconds: intervalSec)
        
        sensorIntervalLabel.text = "Interval\n" + String(format: "%.0f",val) + "Hz"
    }
    
    @IBAction func recordCsvAction(_ sender: Any) {
        if csvManager.isRecording {
            csvManager.stopRecording()
            
            // save csv file
            format.dateFormat = "yyyy-MMdd-HHmmss"
            let dateText = format.string(from: Date())
            showSaveCsvFileAlert(fileName: dateText)
            
            sensorIntervalSlider.isEnabled = true
            csvFileManagementButton.isEnabled = true
            recordCsvButton.setTitle("START", for: .normal)
        }else{
            csvManager.startRecording()
            
            sensorIntervalSlider.isEnabled = false
            csvFileManagementButton.isEnabled = false
            recordCsvButton.setTitle("STOP", for: .normal)
        }
    }
    
    @IBAction func cscFileManagementButtonAction(_ sender: Any) {
        let csvFileManagementViewController = self.storyboard?.instantiateViewController(withIdentifier: "CsvFileManagementViewController") as! CsvFileManagementViewController
        csvFileManagementViewController.modalPresentationStyle = .overCurrentContext
        csvFileManagementViewController.modalTransitionStyle = .crossDissolve
        self.present(csvFileManagementViewController, animated: true, completion: nil)
    }
    
    func startSensorUpdates(intervalSeconds:Double) {
        if motionManager.isDeviceMotionAvailable{
            motionManager.deviceMotionUpdateInterval = intervalSeconds
            
            // start sensor updates
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {(motion:CMDeviceMotion?, error:Error?) in
                self.getMotionData(deviceMotion: motion!)
                
            })
        }
    }
    
    func stopSensorUpdates() {
        if motionManager.isDeviceMotionAvailable{
            motionManager.stopDeviceMotionUpdates()
        }
    }
    
    func getMotionData(deviceMotion:CMDeviceMotion) {
//        print("attitudeX:", deviceMotion.attitude.pitch)
//        print("attitudeY:", deviceMotion.attitude.roll)
//        print("attitudeZ:", deviceMotion.attitude.yaw)
//        print("gyroX:", deviceMotion.rotationRate.x)
//        print("gyroY:", deviceMotion.rotationRate.y)
//        print("gyroZ:", deviceMotion.rotationRate.z)
//        print("gravityX:", deviceMotion.gravity.x)
//        print("gravityY:", deviceMotion.gravity.y)
//        print("gravityZ:", deviceMotion.gravity.z)
//        print("accX:", deviceMotion.userAcceleration.x)
//        print("accY:", deviceMotion.userAcceleration.y)
//        print("accZ:", deviceMotion.userAcceleration.z)
        
        attitude.x = deviceMotion.attitude.pitch
        attitude.y = deviceMotion.attitude.roll
        attitude.z = deviceMotion.attitude.yaw
        gyro.x = deviceMotion.rotationRate.x
        gyro.y = deviceMotion.rotationRate.y
        gyro.z = deviceMotion.rotationRate.z
        gravity.x = deviceMotion.gravity.x
        gravity.y = deviceMotion.gravity.y
        gravity.z = deviceMotion.gravity.z
        acc.x = deviceMotion.userAcceleration.x
        acc.y = deviceMotion.userAcceleration.y
        acc.z = deviceMotion.userAcceleration.z
        
        displaySensorData()
        
        // record sensor data
        if csvManager.isRecording {
            format.dateFormat = "MMddHHmmssSSS"
            
            var text = ""
            text += format.string(from: Date()) + ","
            
            text += String(attitude.x) + ","
            text += String(attitude.y) + ","
            text += String(attitude.z) + ","
            text += String(gyro.x) + ","
            text += String(gyro.y) + ","
            text += String(gyro.z) + ","
            text += String(gravity.x) + ","
            text += String(gravity.y) + ","
            text += String(gravity.z) + ","
            text += String(acc.x) + ","
            text += String(acc.y) + ","
            text += String(acc.z)
            
            csvManager.addRecordText(addText: text)
        }
    }
    
    func displaySensorData() {
        var text = ""
        
        text += "Attitude\n"
        text += "X(pitch): " + String(format:"%06f", attitude.x) + "\n"
        text += "Y(roll): " + String(format:"%06f", attitude.y) + "\n"
        text += "Z(yaw): " + String(format:"%06f", attitude.z) + "\n"
        
        text += "Gyro(Rotation Rate)\n"
        text += "X: " + String(format:"%06f", gyro.x) + "\n"
        text += "Y: " + String(format:"%06f", gyro.y) + "\n"
        text += "Z: " + String(format:"%06f", gyro.z) + "\n"
        
        text += "Gravity\n"
        text += "X: " + String(format:"%06f", gravity.x) + "\n"
        text += "Y: " + String(format:"%06f", gravity.y) + "\n"
        text += "Z: " + String(format:"%06f", gravity.z) + "\n"
        
        text += "User Acceleration\n"
        text += "X: " + String(format:"%06f", acc.x) + "\n"
        text += "Y: " + String(format:"%06f", acc.y) + "\n"
        text += "Z: " + String(format:"%06f", acc.z) + "\n"
        
        sensorDataInfoTextView.text = text
    }
    
    func showSaveCsvFileAlert(fileName:String){
        let alertController = UIAlertController(title: "Save CSV file", message: "Enter file name to add.", preferredStyle: .alert)
        
        let defaultAction:UIAlertAction =
            UIAlertAction(title: "OK",
                          style: .default,
                          handler:{
                            (action:UIAlertAction!) -> Void in
                            let textField = alertController.textFields![0] as UITextField
                            self.csvManager.saveSensorDataToCsv(fileName: textField.text!)
            })
        let cancelAction:UIAlertAction =
            UIAlertAction(title: "Cancel",
                          style: .cancel,
                          handler:{
                            (action:UIAlertAction!) -> Void in
                            self.showDeleteRecordedDataAlert(fileName: fileName)
            })
        
        alertController.addTextField { (textField:UITextField!) -> Void in
            alertController.textFields![0].text = fileName
        }
        alertController.addAction(defaultAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showDeleteRecordedDataAlert(fileName:String){
        let alertController = UIAlertController(title: "Delete recorded data", message: "Do you delete recorded data?", preferredStyle: .alert)
        
        let defaultAction:UIAlertAction =
            UIAlertAction(title: "OK",
                          style: .default,
                          handler:{
                            (action:UIAlertAction!) -> Void in
                            // delete recorded data
            })
        let cancelAction:UIAlertAction =
            UIAlertAction(title: "Cancel",
                          style: .cancel,
                          handler:{
                            (action:UIAlertAction!) -> Void in
                            self.showSaveCsvFileAlert(fileName: fileName)
            })
        
        alertController.addAction(defaultAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func getCompositeData(sensorData:inout SIMD3<Double>) -> Double{
        let compData = sqrt((sensorData.x * sensorData.x) + (sensorData.y * sensorData.y) + (sensorData.z * sensorData.z))
        
        return compData
    }
    
    func getCoremlOutput(){
        // store sensor data in array for CoreML model
        let dataNum = NSNumber(value:inputDataLength)
        let mlarray = try! MLMultiArray(shape: [dataNum], dataType: MLMultiArrayDataType.double )
        
        for (index, data) in compAccArray.enumerated(){
            mlarray[index] = data as NSNumber
        }
        
        // input data to CoreML model
        let model = iPhoneModel()
        guard let output = try? model.prediction(input:
            iPhoneModelInput(input1: mlarray)) else {
                fatalError("Unexpected runtime error.")
        }
        classLabel = output.classLabel
    }
}

