//
//  Memoize.swift
//  TestSwift
//
//  Created by Vitali Bounine on 2014-06-12.
//

import Foundation

func memoize2<T: Hashable, U>( body: ((T)->U, T)->U ) -> (T)->U {
    var memo = Dictionary<T,U>()
    var result: ((T)->U)!
    result = { x in
        if let q = memo[x] { return q }
        let r = body(result, x)
        memo[x] = r
        return r
    }
    return result
}

func memoize<T: Hashable, U>( body: (T)->U ) -> (T)->U {
  var memo = Dictionary<T, U>()
    return { x in
        if let q = memo[x] { return q }
        let r = body(x)
        memo[x] = r
        return r
    }
}