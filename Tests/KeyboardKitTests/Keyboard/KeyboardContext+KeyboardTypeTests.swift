//
//  KeyboardContext+KeyboardTypeTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import KeyboardKit
import MockingKit
import XCTest

class KeyboardContext_KeyboardTypeTests: XCTestCase {
    
    var context: KeyboardContext!
    var proxy: MockTextDocumentProxy!

    override func setUp() {
        proxy = MockTextDocumentProxy()
        context = KeyboardContext(controller: MockKeyboardInputViewController())
        context.textDocumentProxy = proxy
        context.keyboardType = .alphabetic(.lowercased)
    }


    func result(for current: KeyboardType, preCursorPart: String, type: UITextAutocapitalizationType) -> KeyboardType {
        context.keyboardType = current
        proxy.documentContextBeforeInput = preCursorPart
        proxy.autocapitalizationType = type
        return context.preferredKeyboardType
    }

    func textPreferredKeyboardTypeReturnsCorrectDefaultType() {
        XCTAssertEqual(context.preferredKeyboardType, .alphabetic(.lowercased))
    }

    func textPreferredKeyboardTypeReturnsCurrentTypeIfTypeIsNonAlphabetic() {
        context.keyboardType = .symbolic
        XCTAssertEqual(result(for: .symbolic, preCursorPart: "", type: .allCharacters), .symbolic)
    }


    func testPreferredKeyboardTypeWithAutoCapitalizationReturnsCorrectResultForAllCharactersCapitalizaton() {
        let current = KeyboardType.alphabetic(.lowercased)
        let type = UITextAutocapitalizationType.allCharacters
        let expected = KeyboardType.alphabetic(.uppercased)
        XCTAssertEqual(result(for: current, preCursorPart: "", type: type), expected)
        XCTAssertEqual(result(for: current, preCursorPart: "foo", type: type), expected)
        XCTAssertEqual(result(for: current, preCursorPart: "foo!", type: type), expected)
        XCTAssertEqual(result(for: current, preCursorPart: "foo! ", type: type), expected)
    }

    func testPreferredKeyboardTypeWithAutoCapitalizationAlwaysReturnsCapsLockedForCapsLocked() {
        let current = KeyboardType.alphabetic(.capsLocked)
        let type = UITextAutocapitalizationType.sentences
        XCTAssertEqual(result(for: current, preCursorPart: "", type: type), current)
        XCTAssertEqual(result(for: current, preCursorPart: "foo", type: type), current)
        XCTAssertEqual(result(for: current, preCursorPart: "foo ", type: type), current)
        XCTAssertEqual(result(for: current, preCursorPart: "foo!", type: type), current)
        XCTAssertEqual(result(for: current, preCursorPart: "foo! ", type: type), current)
    }

    func testPreferredKeyboardTypeWithAutoCapitalizationReturnsCorrectResultForSentenceCapitalizatons() {
        let current = KeyboardType.alphabetic(.lowercased)
        let type = UITextAutocapitalizationType.sentences
        let expected = KeyboardType.alphabetic(.uppercased)
        XCTAssertEqual(result(for: current, preCursorPart: "", type: type), expected)
        XCTAssertEqual(result(for: current, preCursorPart: "foo", type: type), current)
        XCTAssertEqual(result(for: current, preCursorPart: "foo ", type: type), current)
        XCTAssertEqual(result(for: current, preCursorPart: "foo!", type: type), current)
        XCTAssertEqual(result(for: current, preCursorPart: "foo! ", type: type), expected)
        XCTAssertEqual(result(for: current, preCursorPart: "foo!  ", type: type), expected)
    }

    func testPreferredKeyboardTypeWithAutoCapitalizationReturnsCorrectResultForWordsCcapitalizaton() {
        let current = KeyboardType.alphabetic(.lowercased)
        let type = UITextAutocapitalizationType.words
        let expected = KeyboardType.alphabetic(.uppercased)
        XCTAssertEqual(result(for: current, preCursorPart: "", type: type), expected)
        XCTAssertEqual(result(for: current, preCursorPart: "foo", type: type), current)
        XCTAssertEqual(result(for: current, preCursorPart: "foo ", type: type), expected)
        XCTAssertEqual(result(for: current, preCursorPart: "foo!", type: type), expected)
        XCTAssertEqual(result(for: current, preCursorPart: "foo! ", type: type), expected)
    }

    func testPreferredKeyboardTypeWithAutoCapitalizationReturnsCorrectResultForNoneCapitalizaton() {
        let current = KeyboardType.alphabetic(.lowercased)
        let type = UITextAutocapitalizationType.none
        let expected = KeyboardType.alphabetic(.lowercased)
        XCTAssertEqual(result(for: current, preCursorPart: "", type: type), expected)
        XCTAssertEqual(result(for: current, preCursorPart: "foo", type: type), expected)
        XCTAssertEqual(result(for: current, preCursorPart: "foo!", type: type), expected)
        XCTAssertEqual(result(for: current, preCursorPart: "foo! ", type: type), expected)
    }


    func testPreferredKeyboardTypeWhenPressingSpaceInNumericAndSymbolicKeyboardReturnsCorrectResult() {
        XCTAssertEqual(result(for: .numeric, preCursorPart: "foo, ", type: .sentences), .alphabetic(.lowercased))
        XCTAssertEqual(result(for: .numeric, preCursorPart: "foo. ", type: .sentences), .alphabetic(.uppercased))
        XCTAssertEqual(result(for: .numeric, preCursorPart: "123 ", type: .sentences), .alphabetic(.lowercased))
        XCTAssertEqual(result(for: .symbolic, preCursorPart: "foo, ", type: .sentences), .alphabetic(.lowercased))
        XCTAssertEqual(result(for: .symbolic, preCursorPart: "foo. ", type: .sentences), .alphabetic(.uppercased))
        XCTAssertEqual(result(for: .numeric, preCursorPart: "#€% ", type: .sentences), .alphabetic(.lowercased))
    }
}
#endif
