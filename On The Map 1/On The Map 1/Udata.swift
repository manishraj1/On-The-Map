//
//  InMemoryStore.swift
//  On The Map 1
//
//  Created by Manish raj(MR) on 16/12/21.
//

import Foundation

final class Udata {
    static let shared = Udata()
    
    var userUniqueKey: String 
    var cachedStudentInformations: Array<Userlocationsystem>!
    
    private init() {
        self.userUniqueKey = ""
        self.cachedStudentInformations = [];
    }
}
