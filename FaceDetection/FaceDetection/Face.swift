//
//  Face.swift
//  Utilities
//
//  Created by Cristhian León
//  Copyright © 2018 Cristhian León. All rights reserved.
//

import UIKit

public struct Face: FaceProtocol {
    
    // MARK: Public properties
    
	public var bounds: CGRect = .zero
    
	public var angle: CGFloat = 0
    
	public var leftEye: Eye?
    
	public var rightEye: Eye?
    
	public var mouth: Mouth?
    
    // MARK: Private properties
    
	public init() {
	}
}

private extension Face {
    typealias Eyes = (left: Eye, right: Eye)
    
    var bothEyes: Eyes? {
        guard let left = leftEye else {
            return nil
        }
        
        guard let right = rightEye else {
            return nil
        }
        
        return (left, right)
    }
}

// MARK: FaceProtocol Behavior
public extension Face {
    var isSmiling: Bool {
        return mouth?.hasSmile ?? false
    }
    
    var isWinkingRightEye: Bool {
        guard let eyes = bothEyes else {
            return false
        }
        
        return eyes.right.isClosed && eyes.left.isOpen
    }
    
    var isWinkingLeftEye: Bool {
        guard let eyes = bothEyes else {
            return false
        }
        
        return eyes.left.isClosed && eyes.right.isOpen
    }
    
    var isWinking: Bool {
        return isWinkingLeftEye || isWinkingRightEye
    }
    
    var isBlinking: Bool {
        guard let eyes = bothEyes else {
            return false
        }
        
        return eyes.left.isOpen && eyes.right.isOpen
    }
}

public extension Face {
    static func from(feature: CIFaceFeature, ciImageSize: CGSize) -> Face {
        var face = Face()
        face.bounds = feature.bounds
        
        if feature.hasFaceAngle {
            face.angle = CGFloat(feature.faceAngle)
        }
        
        if feature.hasLeftEyePosition {
            let status: Eye.Status = feature.leftEyeClosed ? .closed : .open
            let eye = Eye(position: feature.leftEyePosition, status: status)
            
            face.leftEye = eye
        }
        
        if feature.hasRightEyePosition {
            let status: Eye.Status = feature.rightEyeClosed ? .closed : .open
            let eye = Eye(position: feature.rightEyePosition, status: status)
            
            face.rightEye = eye
        }
        
        if feature.hasMouthPosition {
            face.mouth = Mouth()
            face.mouth?.position = feature.mouthPosition
            
            if feature.hasSmile {
                face.mouth?.hasSmile = feature.hasSmile
            }
        }
        
        return face
    }
}
