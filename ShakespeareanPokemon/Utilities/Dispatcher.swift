//
//  File.swift
//  
//
//  Created by Daven.Gomes on 19/10/2021.
//

import Foundation

protocol Dispatching: AnyObject {
    func async(_ block: @escaping () -> Void)
}

protocol DispatchTimeProviding {
    static func now() -> DispatchTime
}

protocol DispatchQueue {
    func async(group: DispatchGroup?,
               qos: DispatchQoS,
               flags: DispatchWorkItemFlags,
               execute work: @escaping @convention(block) () -> Void)
}

final class Dispatcher: Dispatching {

    private let queue: DispatchQueue

    init(queue: DispatchQueue) {
        self.queue = queue
    }

    func async(_ block: @escaping () -> Void) {
        queue.async(group: nil,
                    qos: .unspecified,
                    flags: [],
                    execute: block)
    }
}
