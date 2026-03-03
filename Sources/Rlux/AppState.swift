import Foundation
import ServiceManagement

class AppState: ObservableObject {
    @Published var isEnabled: Bool {
        didSet {
            UserDefaults.standard.set(isEnabled, forKey: "rlux_isEnabled")
            applyCurrentState()
            onStateChange?()
        }
    }

    @Published var warmth: Double {
        didSet {
            UserDefaults.standard.set(warmth, forKey: "rlux_warmth")
            applyCurrentState()
        }
    }

    @Published var launchAtLogin: Bool {
        didSet {
            UserDefaults.standard.set(launchAtLogin, forKey: "rlux_launchAtLogin")
            updateLaunchAtLogin()
        }
    }

    var onStateChange: (() -> Void)?

    init() {
        let defaults = UserDefaults.standard
        self.isEnabled = defaults.object(forKey: "rlux_isEnabled") as? Bool ?? false
        self.warmth = defaults.object(forKey: "rlux_warmth") as? Double ?? 0.5
        self.launchAtLogin = defaults.object(forKey: "rlux_launchAtLogin") as? Bool ?? false
    }

    func applyCurrentState() {
        if isEnabled {
            GammaController.setWarmth(warmth)
        } else {
            GammaController.reset()
        }
    }

    private func updateLaunchAtLogin() {
        do {
            if launchAtLogin {
                try SMAppService.mainApp.register()
            } else {
                try SMAppService.mainApp.unregister()
            }
        } catch {
            print("Launch at login update failed: \(error)")
        }
    }
}
