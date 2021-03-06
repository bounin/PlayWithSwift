//
//  StandardProtocols.swift
//  TestSwift
//
//  Created by Vitali Bounine on 6/13/14.
//

import Foundation

// Printable
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

//extension Int: BooleanType {
//    public func boolValue() -> Bool {
//        return self != 0
//    }
//}

//extension Int: BooleanLiteralConvertible {
//    public static func convertFromBooleanLiteral(value: BooleanLiteralType) -> Int {
//        return value ? 1 : 0;
//    }
//}

