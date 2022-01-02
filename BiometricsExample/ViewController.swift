//
//  ViewController.swift
//  BiometricsExample
//
//  Created by Deepak on 08/12/21.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var authBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func authBtnTap(_ sender: UIButton) {
        let context = LAContext()
        var error: NSError? = nil
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            if (context.biometryType == LABiometryType.faceID) {
                let reason = "Please authorize with touch id!!"
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self](success, error) in
                    DispatchQueue.main.async {
                        guard success, error == nil else{
                            //failed
                            let alert = UIAlertController(title: "Unavailable", message: "Failed to authenticate", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                            self?.present(alert, animated: true, completion: nil)
                            return
                        }
                        //success
                        
                            let vc = UIViewController()
                            vc.title = "welcome!!"
                            vc.view.backgroundColor = .systemBlue
                            self?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
                       
                        
                    }
                  
                }
            }
            else{
                let alert = UIAlertController(title: "Unavailable", message: "you can't use this feature faceid", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
         
        }else{
            let alert = UIAlertController(title: "Unavailable", message: "you can't use this feature", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}

