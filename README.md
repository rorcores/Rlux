# Rorlux

A simple blue light filter for macOS that lives in your menu bar.

![logo](https://github.com/user-attachments/assets/5e6971be-fb49-4f30-a944-49a20c581bef)

<img width="287" height="182" alt="Screenshot 2026-03-04 at 6 58 54 AM" src="https://github.com/user-attachments/assets/8d10bddd-c50d-413b-bb91-ce9b4a13db22" />


## Why

f.lux used to be great — a straightforward app that warmed your screen to reduce blue light. Over the years it became bloated with automatic scheduling, location-based fading, multiple colour presets, movie modes, and more. I just wanted to toggle a warm filter on, set the intensity, and have it stay there and it's so insane that you could not do that with f.lux anymore, f.lux would literally force me to change the TIME ZONE ON MY LAPTOP in order to set the color gradient i wanted, it's comical how bad products get when they keep building post PMF. So anyway, this is rorlux. Enjoy.

## Build & Install

```bash
git clone https://github.com/rorcores/Rorlux.git
cd Rorlux
chmod +x build.sh
./build.sh
rm -rf /Applications/Rorlux.app && cp -r build/Rorlux.app /Applications/
```

Then open from Applications, Spotlight, or:

```bash
open /Applications/Rorlux.app
```

To rebuild after changes, run `./build.sh` again and re-copy to Applications.

## How It Works

Rorlux uses the same core technique as f.lux: it adjusts your display's gamma tables via the macOS CoreGraphics API (`CGSetDisplayTransferByFormula`). A colour temperature value (in Kelvin) is converted to per-channel RGB multipliers using blackbody radiation curves, then applied to every connected display. Lowering the temperature reduces blue and green light output, giving the screen a warm amber tint.

The filter automatically re-applies after wake from sleep, screen unlock, and monitor connect/disconnect events, and refreshes every 30 seconds to stay active even if another process resets the gamma.

## Notes

- Disable macOS Night Shift (System Settings → Displays → Night Shift) to avoid conflicts
- When Rorlux quits, your display colours return to normal immediately
- No data is collected — settings are stored locally in UserDefaults
