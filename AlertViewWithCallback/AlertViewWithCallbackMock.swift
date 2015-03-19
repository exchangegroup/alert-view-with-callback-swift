//
//  This file is injected into the app from unit test for verifying the
//  alert view functionality.
//
//  Created by Evgenii Neumerzhitckii on 19/03/2015.
//  Copyright (c) 2015 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

public class AlertViewWithCallbackMock: AlertViewWithCallback {
  public var testAlertView: UIAlertView?
  
  override func show(alert: UIAlertView, onButtonTapped: ((UIAlertView, Int)->())?) {
    AlertViewWithCallbackDelegate.shared.callback = onButtonTapped
    
    testAlertView = alert
  }
  
  public func tapButton(tapButtonWithIndex: Int) {
    if tapButtonWithIndex > (testAlertView!.numberOfButtons - 1) {
      NSException(
        name: "Button with index \(tapButtonWithIndex) does not exist in alert. There are \(testAlertView!.numberOfButtons) buttons.",
        reason: nil, userInfo: nil).raise()
    }
    
    AlertViewWithCallbackDelegate.shared.callback!(testAlertView!, tapButtonWithIndex)
  }

  // Taps a butons that has the caption
  public func tapButton(caption: String) {
    var buttonIndex: Int? = nil

    for currentButtonIndex in (0..<testAlertView!.numberOfButtons) {
      let currentCaption = testAlertView!.buttonTitleAtIndex(currentButtonIndex)
      if currentCaption == caption {
        buttonIndex = currentButtonIndex
        break
      }
    }

    if let currentButtonIndex = buttonIndex {
      tapButton(currentButtonIndex)
    } else {
      NSException(
        name: "Button with caption \(caption) does not exist in alert view.",
        reason: nil, userInfo: nil).raise()
    }
  }
}
