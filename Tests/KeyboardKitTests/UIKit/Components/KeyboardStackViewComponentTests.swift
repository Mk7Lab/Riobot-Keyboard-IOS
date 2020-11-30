//
//  KeyboardStackViewComponentTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2020-11-30.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import UIKit
@testable import KeyboardKit

class KeyboardStackViewComponentTests: QuickSpec {
    
    override func spec() {
        
        describe("standard height") {
            
            it("is correct for iPhone Portrait") {
                expect(KeyboardButtonRow.standardHeight(for: .phone, bounds: .portrait)).to(equal(48))
            }
            
            it("is correct for iPhone Landscape") {
                expect(KeyboardButtonRow.standardHeight(for: .phone, bounds: .landscape)).to(equal(42))
            }
            
            it("is correct for iPad Portrait") {
                expect(KeyboardButtonRow.standardHeight(for: .pad, bounds: .portrait)).to(equal(65))
            }
            
            it("is correct for iPad Landscape") {
                expect(KeyboardButtonRow.standardHeight(for: .pad, bounds: .landscape)).to(equal(84))
            }
        }
    }
}

private extension CGRect {
    
    static var landscape: CGRect {
        CGRect(x: 0, y: 0, width: 2, height: 1)
    }
    
    static var portrait: CGRect {
        CGRect(x: 0, y: 0, width: 1, height: 2)
    }
}
