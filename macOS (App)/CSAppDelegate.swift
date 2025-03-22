//
// Copyright (C) Thomas Dye 22/03/2025. All rights reserved.
//
//

import Cocoa

@main
internal final class CSAppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_: NSApplication)
        -> Bool
    {
        return true
    }
}
