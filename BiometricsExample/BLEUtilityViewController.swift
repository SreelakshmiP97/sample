//
//  BLEUtilityViewController.swift
//  BiometricsExample
//
//  Created by Deepak on 28/12/21.
//

import UIKit
import CoreBluetooth

class BLEUtilityViewController: UIViewController, CBCentralManagerDelegate,CBPeripheralDelegate {
    
   
    @IBOutlet weak var tableview: UITableView!
    var centralManager: CBCentralManager!
    var connectedPeripheral: CBPeripheral!
    var BLEDatasoure:[(name:String,pheripheral:CBPeripheral)] = [(String,CBPeripheral)]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.register(UINib(nibName: "bleTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
                   
               case .poweredOn:
                   print("powered on")
                   central.scanForPeripherals(withServices: nil, options: nil)
               case .poweredOff:
                   print("powered off")
                   
               case .resetting:
                   print("resetting")
                   
               case .unauthorized:
                   print("unauthorized")
                   
               case .unknown:
                   print("unknown")
                   
               case .unsupported:
                   print("unsupported")
        @unknown default: break
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
       
      print("Found peripheral: \(peripheral.name ?? "NO Name")")
      self.BLEDatasoure.append((peripheral.name ?? "NO Name",peripheral))
        
        if(peripheral.name == "439207"){
            connectedPeripheral = peripheral;
            centralManager.stopScan()
            centralManager.connect(connectedPeripheral, options: nil)
        }
        
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connection complete")
        print("Peripheral info: \(peripheral)")
        connectedPeripheral.delegate = self
        connectedPeripheral.discoverServices(nil)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("service count=\(peripheral.services?.count)")
        
        for service in peripheral.services! {
            print("Service: \(service)")
            
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteritics = service.characteristics {
            for characteristic in characteritics {
                if characteristic.properties == CBCharacteristicProperties.read {
                    print("--------------------Read Characteritic--------------------------")
                    print(characteristic)
                    peripheral.readValue(for: characteristic)
                }
                if characteristic.properties == CBCharacteristicProperties.write {
                    print("---------------------Write Characteritic-------------------------")
                    print(characteristic)
                
                }
                if characteristic.properties == CBCharacteristicProperties.notify{
                    print("---------------------Notify Characteritic-------------------------")
                    print(characteristic)
                    peripheral.setNotifyValue(true, for: characteristic)
                }
            }
        }
    }
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic,
        error: Error?
    ) {
        guard let data = characteristic.value else {
            // no data transmitted, handle if needed
            return
        }
        print("characteristic.value")
        print(characteristic.value ?? "null")
//        if characteristic.uuid == batteryLevelUUID {
//            // Decode data and map it to your model object
//        }
        guard let firstByte = data.first else {
            // handle unexpected empty data
            return
        }
        var str = String( data: characteristic.value! , encoding: String.Encoding.utf8) as String?
        print("string value:\(str)")
        let stringarray = Array(arrayLiteral: str)
        let stringarray1 = str!.components(separatedBy: ", ")
        print("stringarray\(stringarray)")
        let strone = str!.split(separator: ",")
        print("strone\(strone)")
    }
    
    @IBAction func scanClick(_ sender: UIButton) {
        print("Scan Clicked")
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
}


extension BLEUtilityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BLEDatasoure.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? bleTableViewCell {
           
            cell.tableviewCell.text = BLEDatasoure[indexPath.row].name
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select row at")
        self.connectedPeripheral = BLEDatasoure[indexPath.row].pheripheral
        print(BLEDatasoure[indexPath.row].name)
        //centralManager.stopScan()
        //centralManager.connect(connectedPeripheral, options: nil)
    }
}
