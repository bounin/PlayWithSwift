//
//  Task.swift
//  TestSwift
//
//  Created by Vitali Bounine on 6/6/14.
//

import Foundation

class VoidTask {

    let group : dispatch_group_t

    func waitUntilDone () -> () {
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
    }

    init(_ task: () -> (), queue: dispatch_queue_t? = nil) {
        let q = queue ? queue! : dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        self.group = dispatch_group_create()
        dispatch_group_async(group, q, task)
    }

    //    //not really a good idea ;)
    //    deinit {
    //        waitUntilDone ()
    //    }
}

class Task<R>: VoidTask {

    // R[] is a quick and dirty workaround, having R? here causes:
    // error: unimplemented IR generation feature non-fixed class layout
    var results : R[]

    func value () -> R {
        waitUntilDone ()
        return results[0]
    }

    init(_ task: () -> R, queue: dispatch_queue_t? = nil) {
        results = []
        super.init({ self.results = [task ()] }, queue: queue);
    }

}

func async (f: () -> ()) -> VoidTask {
    return VoidTask {
        return f()
    }
}

func async <R> (f: () -> R) -> Task<R> {
    return Task {
        return f()
    }
}

func async <A, R> (f: A -> R) -> A -> Task<R> {
    return { args in
        return Task<R> {
            return f(args)
        }
    }
}

func await <R> (task: Task<R>) -> R {
    return task.value ()
}

@prefix func ! <R> (task: Task<R>) -> R {
    return await(task)
}

operator infix ~ { }

@infix func ~ <A, R> (f: A -> R, args: A) -> Task<R> {
    return async(f)(args)
}

