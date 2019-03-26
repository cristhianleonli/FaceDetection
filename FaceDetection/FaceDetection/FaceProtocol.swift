//
//  FaceProtocol.swift
//  Mapi
//
//  Created by Cristhian Leon on 26.03.19.
//  Copyright © 2019 Cristhian. All rights reserved.
//

import UIKit

public protocol FaceProtocol {
    // GET-ONLY
    var isSmiling: Bool         { get }
    var isWinkingRightEye: Bool { get }
    var isWinkingLeftEye: Bool  { get }
    var isWinking: Bool         { get }
    var isBlinking: Bool        { get }
    
    // GET-SET
    var bounds: CGRect  { get set }
    var angle: CGFloat  { get set }
    var leftEye: Eye?   { get set }
    var rightEye: Eye?  { get set }
    var mouth: Mouth?   { get set }
}
