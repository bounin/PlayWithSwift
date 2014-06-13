//
//  Singleton.swift
//  TestSwift
//
//  Created by Vitali Bounine on 2014-06-12.
//

import Foundation

class GlobalVariable {
    class var sharedInstance:GlobalVariable {
        //return globalVariableShareInstance
        struct Static {
            static let instance : GlobalVariable = GlobalVariable()
        }
        return Static.instance
    }
    
    func ping(message:String) {
        NSLog("ping: %@", message)
    }
    
    init() {
        NSLog ("GlobalVariable::init")
        sleep(5);
    }
}

//let globalVariableSharedInstance = GlobalVariable()
