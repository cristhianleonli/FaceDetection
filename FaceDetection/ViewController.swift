//
//  ViewController.swift
//  FaceDetection
//
//  Created by Cristhian Leon on 26.03.19.
//  Copyright © 2019 Cristhian. All rights reserved.
//

import UIKit
import CameraView

class ViewController: UIViewController {

    private let cameraView = CameraView()
    
    private let detector = FaceDetector()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func start(_ sender: Any) {
        cameraView.start()
    }
    
    @IBAction func stop(_ sender: Any) {
        cameraView.stop()
    }
}

private extension ViewController {
    func addCameraView() {
        let frame = CGRect(x: 0, y: 0,
                           width: view.frame.width,
                           height: view.frame.height)
        
        let config = CameraViewConfiguration(frame: frame, cameraPosition: .front)
        cameraView.configuration = config
        cameraView.delegate = self
        
        // add camera view container to main view
        let cameraContainer = cameraView.cameraContainer
        view.addSubview(cameraContainer)
    }
}

extension ViewController: CameraViewDelegate {
    func onFrame(buffer: CVPixelBuffer) {
        let faces = detector.detectFaces(pixelBuffer: buffer)
        print("faces found: \(faces.count)")
    }
    
    func onError(reason: CameraViewError) {
        print("error \(reason)")
    }
    
    func didFinishConfiguration() {
        print("finish configuration")
    }
}
