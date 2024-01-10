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
    private var methodChannel: FlutterMethodChannel?
    private var flutterViewController: FlutterViewController?
    
    private let methodChannelName = "com.integrateFlutterInNative.channel"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Start flutter engine and method channel
        setUpFlutterEngine()
        
        // Do any additional setup after loading the view.
        let goToFlutterAction =  UIAction(title: "Go To Flutter", handler: {[weak self] _ in
            print("`Go to Flutter`!")
            guard let localFlutterEngine = self?.flutterEngine else {
                return
            }
            
            let flutterViewController = FlutterViewController(engine: localFlutterEngine,
                                                              nibName: nil,
                                                              bundle: nil)
            self?.flutterViewController = flutterViewController
            self?.present(flutterViewController, animated: true)
        })
        
        let goToFlutterButton = UIButton(type: .system, primaryAction: goToFlutterAction)
        goToFlutterButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(goToFlutterButton)
        NSLayoutConstraint.activate([
            goToFlutterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goToFlutterButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            goToFlutterButton.widthAnchor.constraint(equalToConstant: 300),
            goToFlutterButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        
        let incrementCounterAction =  UIAction(title: "Increment Counter", handler: {[weak self] _ in
            print("`Increment Counter`!")
            self?.incrementCounter()
        })
        
        let incrementCounterButton = UIButton(type: .system, primaryAction: incrementCounterAction)
        incrementCounterButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(incrementCounterButton)
        NSLayoutConstraint.activate([
            incrementCounterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            incrementCounterButton.topAnchor.constraint(equalTo: goToFlutterButton.bottomAnchor,
                                                        constant: 10),
            
            incrementCounterButton.widthAnchor.constraint(equalToConstant: 300),
            incrementCounterButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func goToFlutter(_ sender: Any?) {
        print("Go To Flutter")
    }
    
    //MARK: - Flutter
    private func setUpFlutterEngine() {
        let localFlutterEngine = FlutterEngine()
        localFlutterEngine.run()
        GeneratedPluginRegistrant.register(with: localFlutterEngine)
        flutterEngine = localFlutterEngine
        
        methodChannel = FlutterMethodChannel(name: methodChannelName,
                                             binaryMessenger: localFlutterEngine.binaryMessenger)
        
        methodChannel?.setMethodCallHandler { [weak self] in
            self?.handleMethodCall($0, result: $1)
        }
    }
    
    enum FlutterMethods: String {
        // Native => Flutter
        case incrementCounter
        // Flutter => Native
        case getToken
        case dismiss
    }
    
    private func handleMethodCall(_ methodCall: FlutterMethodCall, result: @escaping FlutterResult) {
        dispatchPrecondition(condition: .onQueue(.main))
        
        guard let method = FlutterMethods(rawValue: methodCall.method) else {
            result(FlutterMethodNotImplemented)
            return
        }
        switch method {
        case .incrementCounter:
            // This method is called from the native side only.
            result(FlutterMethodNotImplemented)
        case .getToken:
            result("f2722e1bf7faebdd5e63810b446bf499")
        case .dismiss:
            self.flutterViewController?.dismiss(animated: true)
            result(true)
        }
    }
    
    private func incrementCounter() {
        methodChannel?.invokeMethod(FlutterMethods.incrementCounter.rawValue,
                                        arguments: nil)
    }
}



