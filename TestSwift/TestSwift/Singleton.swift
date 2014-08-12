//
//  Singleton.swift
//  TestSwift
//
//  Created by Vitali Bounine on 2014-06-12.
//

import Foundation

class GlobalVariable {
    // first method to create singleton
    class var sharedInstance:GlobalVariable {
        //return globalVariableSharedInstance
        struct Static {
            static let instance : GlobalVariable = GlobalVariable()
        }
        return Static.instance
    }
    
    class var defaultInstance:GlobalVariable {
        return globalVariableSharedInstance
    }
    
    func ping(message:String) {
        NSLog("ping: %@", message)
    }
    
    private init() {
        NSLog ("GlobalVariable::init")
        sleep(5);
    }
}

private let globalVariableSharedInstance = GlobalVariable()
