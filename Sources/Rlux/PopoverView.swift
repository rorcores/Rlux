import SwiftUI

struct PopoverView: View {
    @ObservedObject var appState: AppState

    private var temperatureLabel: String {
        "\(GammaController.kelvinForWarmth(appState.warmth))K"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            header
            Divider()
            filterToggle
            warmthSlider
            Divider()
            launchAtLoginToggle
            Divider()
            quitButton
        }
        .padding(16)
        .frame(width: 260)
    }

    // MARK: - Sections

    private var header: some View {
        HStack(spacing: 8) {
            Image(systemName: "sun.max.fill")
                .font(.title2)
                .foregroundColor(appState.isEnabled ? .orange : .secondary)
            Text("Rlux")
                .font(.title2)
                .fontWeight(.semibold)
            Spacer()
            if appState.isEnabled {
                Text(temperatureLabel)
                    .font(.caption)
                    .monospacedDigit()
                    .foregroundColor(.secondary)
            }
        }
    }

    private var filterToggle: some View {
        Toggle(isOn: $appState.isEnabled) {
            Text("Filter")
                .fontWeight(.medium)
        }
        .toggleStyle(.switch)
        .tint(.orange)
    }

    private var warmthSlider: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Warmth")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Slider(value: $appState.warmth, in: 0.05...1.0)
                .tint(.orange)

            HStack {
                Text("Mild")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Spacer()
                Text("Strong")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .opacity(appState.isEnabled ? 1.0 : 0.4)
        .allowsHitTesting(appState.isEnabled)
    }

    private var launchAtLoginToggle: some View {
        Toggle(isOn: $appState.launchAtLogin) {
            Text("Launch at Login")
                .font(.subheadline)
        }
        .toggleStyle(.checkbox)
    }

    private var quitButton: some View {
        Button {
            GammaController.reset()
            NSApplication.shared.terminate(nil)
        } label: {
            Text("Quit Rlux")
                .font(.subheadline)
        }
        .buttonStyle(.plain)
        .foregroundColor(.secondary)
    }
}
