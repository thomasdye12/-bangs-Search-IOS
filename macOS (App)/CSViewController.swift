//
// Copyright (C) Thomas Dye 22/03/2025. All rights reserved.
//
//
import Cocoa
import SafariServices

let extensionBundleIdentifier = "net.thomasdye.CustomSearch.Extension"

internal final class CSViewController: NSViewController {
    @IBOutlet var unknownSettingsLabel: NSTextField!
    @IBOutlet var offSettingsLabel: NSTextField!
    @IBOutlet var onSettingsLabel: NSTextField!
    @IBOutlet var openSettingsButton: NSButton!

    @IBOutlet var unknownPreferencesLabel: NSTextField!
    @IBOutlet var offPreferencesLabel: NSTextField!
    @IBOutlet var onPreferencesLabel: NSTextField!
    @IBOutlet var openPreferencesButton: NSButton!

    override func viewWillAppear() {
        super.viewWillAppear()

        var useSettingsInsteadOfPreferences = false
        if #available(macOS 13, *) {
            useSettingsInsteadOfPreferences = true
        }

        if useSettingsInsteadOfPreferences {
            self.unknownSettingsLabel.isHidden = false
            self.openSettingsButton.isHidden = false
        } else {
            self.unknownPreferencesLabel.isHidden = false
            self.openPreferencesButton.isHidden = false
        }

        SFSafariExtensionManager.getStateOfSafariExtension(
            withIdentifier: extensionBundleIdentifier
        ) { state, _ in
            guard let state else {
                return
            }

            DispatchQueue.main.async {
                if useSettingsInsteadOfPreferences {
                    self.unknownSettingsLabel.isHidden = true

                    if state.isEnabled {
                        self.onSettingsLabel.isHidden = false
                    } else {
                        self.offSettingsLabel.isHidden = false
                    }
                } else {
                    self.unknownPreferencesLabel.isHidden = true

                    if state.isEnabled {
                        self.onPreferencesLabel.isHidden = false
                    } else {
                        self.offPreferencesLabel.isHidden = false
                    }
                }
            }
        }
    }

    @IBAction func openSettingsAction(_: Any) {
        SFSafariApplication.showPreferencesForExtension(
            withIdentifier: extensionBundleIdentifier
        ) { _ in
            DispatchQueue.main.async {
                NSApp.terminate(nil)
            }
        }
    }
}
