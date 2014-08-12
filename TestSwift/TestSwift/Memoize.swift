//
//  Memoize.swift
//  TestSwift
//
//  Created by Vitali Bounine on 2014-06-12.
//

import Foundation

func memoize<T: Hashable, U>( body: ((T)->U, T)->U ) -> (T)->U {
    var memo = [T:U]()
    var result: ((T)->U)!
    result = { x in
        if let q = memo[x] { return q }
        let r = body(result, x)
        memo[x] = r
        return r
    }
    return result
}
