//
//  StudentDataNotifier.swift
//  On The Map 1
//
//  Created by Manish raj(MR) on 16/12/21.
//

import Foundation

class Userlocation {
    static let shared = Userlocation()
    static let MAP_VIEW_SUBSCRIBER_NAME = "MAP_VIEW_SUBSCRIBER_NAME"
    static let TABLE_VIEW_SUBSCRIBER_NAME = "TABLE_VIEW_SUBSCRIBER_NAME"
    private var subCallbacks: [()-> Void] = []
    private var subscriberNameSet: [String]
    
    private init() {
        self.subCallbacks = []
        self.subscriberNameSet = [];
    }
    
    func subscribe(_ name: String, callback: @escaping () -> ()) -> Void {
        if (subscriberNameSet.contains(name) == false) {
            subCallbacks.append(callback)
        }
    }
    
    func notify() {
        for callback in subCallbacks {
            callback()
        }
    }
}
