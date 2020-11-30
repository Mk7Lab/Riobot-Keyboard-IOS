//
//  KeyboardButtonRowComponent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This protocol represents a view component that can be added
 to a keyboard button row.
 */
public protocol KeyboardButtonRowComponent: HorizontalKeyboardComponent {}

public extension KeyboardButtonRowComponent {
    
    /**
     These standard insets is padding that should be applied
     INSIDE the row component to provide fake spaces between
     rows and items, while keeping the entire view tappable.
     
     Padding must be added INSIDE the views, since a spacing
     between items will create dead tap areas.
     
     For a keyboard button, it should thus push in the edges
     of the button body to fit these insets, then apply view
     gestures to its entire body.
     */
    static func standardInsets(for device: UIDevice, screen: UIScreen) -> UIEdgeInsets {
        standardInsets(for: device.userInterfaceIdiom, bounds: screen.bounds)
    }
}

extension KeyboardButtonRowComponent {
    
    static func standardInsets(for idiom: UIUserInterfaceIdiom, bounds: CGRect) -> UIEdgeInsets {
        bounds.isLandscape ? standardLandscapeInsets(for: idiom) : standardPortraitInsets(for: idiom)
    }
}

private extension KeyboardButtonRowComponent {
    
    static func standardPortraitInsets(for idiom: UIUserInterfaceIdiom) -> UIEdgeInsets {
        idiom == .pad ? .all(5) : .all(3)
    }
    
    static func standardLandscapeInsets(for idiom: UIUserInterfaceIdiom) -> UIEdgeInsets {
        idiom == .pad ? .all(5) : .all(3)
    }
}

private extension CGRect {
    
    var isLandscape: Bool { width > height }
}

private extension UIEdgeInsets {
    
    static func all(_ all: CGFloat) -> UIEdgeInsets {
        self.init(top: all, left: all, bottom: all, right: all)
    }
}
