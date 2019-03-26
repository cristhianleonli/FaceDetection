//
//  FaceDetector.swift
//  Utilities
//
//  Created by Cristhian León
//  Copyright © 2018 Cristhian León. All rights reserved.
//

import UIKit
import CoreImage
import Foundation

public class FaceDetector {
    
    public init() {
    }
    
    private lazy var faceDetector: CIDetector? = {
        return CIDetector(ofType: CIDetectorTypeFace,
                          context: nil,
                          options: detectionOptions)
    }()
    
    private lazy var detectionOptions: [String: Any] = {
        return [
            CIDetectorSmile: true,
            CIDetectorEyeBlink: true,
            CIDetectorImageOrientation: 6
        ]
    }()
    
    public func detectFaces(ciImage sourceImage: CIImage) -> [FaceProtocol] {
        let features = faceDetector?.features(in: sourceImage, options: detectionOptions)
        
        guard let faceFeatures = features as? [CIFaceFeature] else {
            return []
        }
        
        return faceFeatures.map({ Face.from(feature: $0, ciImageSize: sourceImage.extent.size) })
    }
    
    public func detectFaces(pixelBuffer: CVPixelBuffer) -> [FaceProtocol] {
        let ciImage = CIImage.init(cvPixelBuffer: pixelBuffer)
        return detectFaces(ciImage: ciImage)
    }
}
