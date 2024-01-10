//
//  ViewController.swift
//  IntergrateFlutterInNative
//
//  Created by Alex-IDT on 28.12.2023.
//

import UIKit
import Flutter
import FlutterPluginRegistrant

class ViewController: UIViewController {
    
    var flutterEngine: FlutterEngine?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let goToFlutterAction =  UIAction(title: "Button Title", handler: {[weak self] _ in
            print("`Go to Flutter`!")
            let localFlutterEngine = FlutterEngine()
            localFlutterEngine.run()
            GeneratedPluginRegistrant.register(with: localFlutterEngine)

            self?.flutterEngine = localFlutterEngine
            
            let flutterViewController = FlutterViewController(engine: localFlutterEngine,
                                                              nibName: nil,
                                                              bundle: nil)
            self?.present(flutterViewController, animated: true)
        })
        
        let goToFlutterButton = UIButton(type: .system, primaryAction: goToFlutterAction)
        goToFlutterButton.setTitle("Go To Flutter", for: .normal)
        goToFlutterButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(goToFlutterButton)
        NSLayoutConstraint.activate([
            goToFlutterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goToFlutterButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            goToFlutterButton.widthAnchor.constraint(equalToConstant: 300),
            goToFlutterButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func goToFlutter(_ sender: Any?) {
        print("Go To Flutter")
    }
}



