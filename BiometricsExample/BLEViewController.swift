//
//  BLEViewController.swift
//  BiometricsExample
//
//  Created by Deepak on 22/12/21.
//

import UIKit
import CoreBluetooth

class BLEViewController: UIViewController, CBCentralManagerDelegate,CBPeripheralDelegate {
    
    @IBOutlet weak var onbtn: UIButton!
    var manager:CBCentralManager!
        var connectedPeripheral:CBPeripheral!
        var LEDCharacteristic:CBCharacteristic?
    
    @IBOutlet weak var LEDSwitch: UISwitch!
    
    let deviceName = "Spark32"
    let serviceUUID = CBUUID(string: "00FF")
    let charUUID = CBUUID(string: "FF01")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CBCentralManager(delegate: self, queue: nil)
        
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
        @unknown default:
            print("default")
        }
    }
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let device = advertisementData[CBAdvertisementDataLocalNameKey] as? String
                
                
                if (device?.contains(deviceName)) != nil {
                    
                    self.manager.stopScan()
                    self.connectedPeripheral = peripheral
                    self.connectedPeripheral.delegate = self
                    
                    manager.connect(peripheral, options: nil)
                    
                }
    }
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.discoverServices(nil)
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else {
                   return
               }
               
               for service in services {
                   
                   peripheral.discoverCharacteristics(nil, for: service)
                   
                   if service.uuid == serviceUUID {
                       
                       peripheral.discoverCharacteristics(nil, for: service)
                       
                   }
               }
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else {
                    return
                }
                
                for characteristic in characteristics {
                    
                    if characteristic.uuid == charUUID {
                        
                        LEDCharacteristic = characteristic
                        
                        peripheral.readValue(for: characteristic)
                        
                    }
                    
                }
    }
//    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
//        if characteristic.uuid == charUUID {
//                   
//                   if let data = characteristic.value {
//                       
//                       if data[0] == 1 {
//                           
//                           LEDSwitch.setOn(true, animated: true)
//                       }
//                       
//                   }
//               }
//    }
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        central.scanForPeripherals(withServices: nil, options: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func LEDSwitchChanged(_ sender: UISwitch) {
           
           if sender.isOn {
               
               sendSwitchValue(value: UInt8(1))
               
           }else {
               
               sendSwitchValue(value: UInt8(0))
               
           }
       }
    
    //MARK:- send switch value to peripheral
        func sendSwitchValue(value: UInt8){
            
            let data = Data(bytes: [value])
            
            guard let ledChar = LEDCharacteristic else {
                return
            }
            
            
            connectedPeripheral.writeValue(data, for: ledChar, type: .withResponse)
            
        }
    @IBAction func onTap(_ sender: UIButton) {
        sendSwitchValue(value: UInt8(1))
    }
    @IBAction func offTap(_ sender: UIButton) {
        sendSwitchValue(value: UInt8(0))
    }
}
