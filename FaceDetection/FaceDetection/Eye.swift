//
//  Eye.swift
//  Mapi
//
//  Created by Cristhian Leon on 25.03.19.
//  Copyright © 2019 Cristhian. All rights reserved.
//
import UIKit

public struct Eye {
    
    private var position: CGPoint
    
    private var status: Status
    
    public enum Status {
        case open
        case closed
    }
    
    public init(position: CGPoint, status: Status) {
        self.position = position
        self.status = status
    }
    
    public var isClosed: Bool {
        return status == .closed
    }
    
    public var isOpen: Bool {
        return status == .open
    }
}
