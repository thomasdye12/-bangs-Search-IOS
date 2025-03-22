//
// Copyright (C) Thomas Dye 22/03/2025. All rights reserved.
//
//

import UIKit

internal final class CSSceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo _: UISceneSession,
        options _: UIScene.ConnectionOptions
    ) {
        guard let _ = (scene as? UIWindowScene) else {
            return
        }
    }
}
