//
// Copyright (C) Thomas Dye 22/03/2025. All rights reserved.
// 
//

import SafariServices

internal final class CSSafariWebExtensionHandler: NSObject,
    NSExtensionRequestHandling
{
    func beginRequest(with context: NSExtensionContext) {
        context.completeRequest(
            returningItems: [],
            completionHandler: nil
        )
    }
}
