//
//  PlayerCompatible.swift
//  APlay
//
//  Created by lincoln on 2018/7/2.
//  Copyright © 2018年 SelfStudio. All rights reserved.
//

import Foundation
protocol PlayerCompatible: AnyObject {
    var readClosure: (UInt32, UnsafeMutablePointer<UInt8>) -> (UInt32, Bool) { get set }
    var eventPipeline: Delegated<Player.Event, Void> { get }
    var startTime: Float { get set }
    var asbd: AudioStreamBasicDescription { get }
    var state: Player.State { get }
    var volume: Float { get set }
    
    func destroy()
    func pause()
    func resume()
    func toggle()
    
    func setup(_: AudioStreamBasicDescription)
    
    func currentTime() -> Float
    
    init(config: ConfigurationCompatible)
}

struct Player {
    static var maxFramesPerSlice: UInt32 = 4096
    
    enum State { case idle, running, paused }
    
    enum Event {
        case playback(Float)
        case state(State)
        case error(APlay.Error)
        case unknown(Error)
    }
    
    struct Bus {
        static let output: UInt32 = 0
        static let input: UInt32 = 1
    }
}
