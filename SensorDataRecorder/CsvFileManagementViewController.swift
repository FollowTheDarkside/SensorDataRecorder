//
//  CsvFileManagementViewController.swift
//  SensorDataRecorder
//
//  Created by FTD on 2019/09/04.
//  Copyright © 2019 FTD. All rights reserved.
//

import UIKit

class CsvFileManagementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var csvTableView: UITableView!
    
    // directory path of csv files
    let directoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    var csvFileNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCsvFileNames()
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        csvTableView.allowsMultipleSelection = false
    }
    
    @IBAction func deleteAllCsvButtonAction(_ sender: Any) {
        showDeleteAllCsvAlert()
    }
    
    func showDeleteAllCsvAlert() {
        let alertController = UIAlertController(title: "Delete CSV file", message: "Do you delete all csv files?", preferredStyle: .alert)
        
        let defaultAction:UIAlertAction =
            UIAlertAction(title: "OK",
                          style: .default,
                          handler:{
                            (action:UIAlertAction!) -> Void in
                            self.deleteAllCsvFiles()
            })
        let cancelAction:UIAlertAction =
            UIAlertAction(title: "Cancel",
                          style: .cancel,
                          handler:{
                            (action:UIAlertAction!) -> Void in
                            // do not delete csv files
            })
        
        alertController.addAction(defaultAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return csvFileNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let csvFileName = csvFileNames[indexPath.row]
        cell.textLabel!.text = String(csvFileName)
        
        return cell
    }
    
    // delete csv selected by swipe
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let deleteCsvPath = directoryPath + "/" + csvFileNames[indexPath.row]
            
            deleteCsvFile(filePath: deleteCsvPath)
            getCsvFileNames() // call before deleting rows
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.reloadData()
        }
    }
    
    func getCsvFileNames(){
        var tmp: [String] {
            do {
                return try FileManager.default.contentsOfDirectory(atPath: directoryPath)
            } catch {
                return []
            }
        }
        csvFileNames = tmp
    }
    
    func deleteCsvFile(filePath:String){
        do {
            try FileManager.default.removeItem(atPath: filePath)
        } catch {
            print("Failure to Delete CSV")
        }
    }
    
    func deleteAllCsvFiles(){
        var indexPaths = [IndexPath]()
        for (i, name) in csvFileNames.enumerated(){
            let deleteCsvPath = directoryPath + "/" + name
            deleteCsvFile(filePath: deleteCsvPath)
            indexPaths.append([0, i])
        }
        getCsvFileNames() // call before deleting rows
        csvTableView.deleteRows(at: indexPaths, with: .fade)
        csvTableView.reloadData()
        
    }
}
