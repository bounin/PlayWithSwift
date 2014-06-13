//
//  AppDelegate.swift
//  TestSwift
//
//  Created by Vitali Bounine on 6/6/14.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func testTaskAndSingleton () -> () {
        func seriousComputation (sleep_delay:CUnsignedInt) -> Int {
            NSLog("starting serious computation")
            sleep(sleep_delay)
            NSLog("finished serious computation")
            GlobalVariable.sharedInstance.ping("\(Suit.Hearts)")
            return 42
        }

        // create a task directly
        let x = Task<String> {
            sleep(1)
            return "Swift"
        }

        // or use async { ... } unfortunetely () -> T in is required
        let y = async { () -> String in
            sleep(1)
            return "is"
        }

        NSLog("Aaaaa")
        // ... unless it is () -> (
        async {
            NSLog("Ooooo...")
            sleep(5)
            NSLog("you shall not pass")
        }

        for i in 0..5 {
            async {
                sleep(1)
                GlobalVariable.sharedInstance.ping(i.description)
            }
        }

        // you can await tasks inside other tasks
        let z = async { () -> String in
            let w = ["c", "o", "o", "l"].reduce("") { (a, b) in
                sleep(1)
                return a + b
            }
            return "\(!x) \(!y) \(w)"
        }

        // can either await(x) or !x
        NSLog("%@", !z)
        NSLog("%@", await(z))

        // can either async(seriousComputation)() or seriousComputation~()
        let answer = seriousComputation~(3)

        NSLog("can't wait for the answer!")

        NSLog("%d", !answer)
        GlobalVariable.sharedInstance.ping("\(Suit.Clubs)")
    }
    
    func testMemoize () -> () {
        let fibonacci:(Int)->Double = memoize {
            fibonacci, n in
            n < 2 ? Double(n) : fibonacci(n-1) + fibonacci(n-2)
        }
        
        println ("\(fibonacci(45)/fibonacci(44))")
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        // Override point for customization after application launch.
        testTaskAndSingleton()
        testMemoize()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


// Test printable
enum Suit : String, Printable {
    case Hearts="Hearts", Diamonds="Diamonds", Spades="Spades", Clubs="Clubs"
    var description : String { return "Suit." + self.toRaw() }
//    var description : String {
//        switch self {
//            case .Hearts: return "Hearts"
//            case .Diamonds: return "Diamond"
//            case .Spades: return "Spades"
//            case .Clubs: return "Clubs"
//        }
//    }
}
