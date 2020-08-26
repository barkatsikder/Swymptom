//
//  Publisher+Assign.swift
//  Swymptom
//
//  Created by Barkat Sikder on 8/23/20.
//  Copyright © 2020 Barkat Sikder. All rights reserved.
//

import Combine

/// https://forums.swift.org/t/does-assign-to-produce-memory-leaks/29546/11
extension Publisher where Failure == Never {
  func assign<Root: AnyObject>(to keyPath: ReferenceWritableKeyPath<Root, Output>, on root: Root) -> AnyCancellable {
    sink { [weak root] in
      root?[keyPath: keyPath] = $0
    }
  }
}
