#!/usr/bin/env bash
set -euo pipefail

PRESET_DIR="$HOME/.config/easyeffects/output"
PRESET="$PRESET_DIR/acer-aspire.json"
PIPEWIRE_DIR="$HOME/.config/pipewire/pipewire.conf.d"

echo "=== Acer Aspire A515-46 Audio Setup ==="

echo "[1] Installing audio packages..."
sudo apt update
sudo apt install -y \
  pipewire \
  pipewire-audio \
  pipewire-pulse \
  wireplumber \
  alsa-utils \
  alsa-tools-gui \
  pavucontrol \
  easyeffects \
  libspa-0.2-bluetooth \
  sysfsutils

echo "[2] Disabling Realtek audio power saving..."
echo "options snd_hda_intel power_save=0" | sudo tee /etc/modprobe.d/disable-audio-powersave.conf >/dev/null

echo "[3] Applying Acer Realtek ALC255 model hint..."
echo "options snd-hda-intel model=alc255-acer" | sudo tee /etc/modprobe.d/acer-alc255.conf >/dev/null

echo "[4] Updating initramfs..."
sudo update-initramfs -u

echo "[5] Configuring PipeWire latency..."
mkdir -p "$PIPEWIRE_DIR"

cat > "$PIPEWIRE_DIR/99-acer-lowlatency.conf" << 'EOF'
context.properties = {
    default.clock.rate          = 48000
    default.clock.quantum       = 256
    default.clock.min-quantum   = 256
    default.clock.max-quantum   = 1024
}
EOF

echo "[6] Creating EasyEffects Acer Aspire preset..."
mkdir -p "$PRESET_DIR"

if [ -f "$PRESET" ]; then
  cp "$PRESET" "$PRESET.backup.$(date +%F-%H%M%S)"
fi

cat > "$PRESET" << 'EOF'
{
    "output": {
        "blocklist": [],
        "equalizer#0": {
            "balance": 0.0,
            "bypass": false,
            "input-gain": 0.0,
            "left": {
                "band0": {"frequency": 22.4, "gain": -5.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band1": {"frequency": 27.8, "gain": 0.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band2": {"frequency": 34.51, "gain": 0.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band3": {"frequency": 42.82, "gain": 0.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band4": {"frequency": 53.14, "gain": 0.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band5": {"frequency": 65.95, "gain": -3.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band6": {"frequency": 81.83, "gain": 0.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band7": {"frequency": 101.55, "gain": 0.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band8": {"frequency": 126.0, "gain": 0.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band9": {"frequency": 156.38, "gain": 0.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band10": {"frequency": 194.06, "gain": 0.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band11": {"frequency": 240.81, "gain": 2.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band12": {"frequency": 298.834, "gain": 0.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band13": {"frequency": 370.834, "gain": 0.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band14": {"frequency": 460.182, "gain": 1.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band15": {"frequency": 571.057, "gain": 0.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band16": {"frequency": 708.647, "gain": 0.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band17": {"frequency": 879.387, "gain": 0.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band18": {"frequency": 1091.26, "gain": 0.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band19": {"frequency": 1354.19, "gain": 0.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band20": {"frequency": 1680.47, "gain": 0.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band21": {"frequency": 2085.35, "gain": 1.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band22": {"frequency": 2587.79, "gain": 0.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band23": {"frequency": 3211.29, "gain": 0.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band24": {"frequency": 3985.01, "gain": 2.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band25": {"frequency": 4945.15, "gain": 0.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band26": {"frequency": 6136.63, "gain": 0.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band27": {"frequency": 7615.17, "gain": 3.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band28": {"frequency": 9449.96, "gain": 0.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band29": {"frequency": 11726.8, "gain": 2.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band30": {"frequency": 14552.2, "gain": 0.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0},
                "band31": {"frequency": 18058.4, "gain": 0.0, "mode": "RLC (BT)", "mute": false, "q": 4.36, "slope": "x1", "solo": false, "type": "Bell", "width": 4.0}
            },
            "mode": "IIR",
            "num-bands": 32,
            "output-gain": 0.0,
            "pitch-left": 0.0,
            "pitch-right": 0.0,
            "right": {},
            "split-channels": false
        },
        "limiter#0": {
            "alr": false,
            "alr-attack": 5.0,
            "alr-knee": 0.0,
            "alr-release": 50.0,
            "attack": 5.0,
            "bypass": false,
            "dithering": "None",
            "external-sidechain": false,
            "gain-boost": true,
            "input-gain": 2.0,
            "lookahead": 5.0,
            "mode": "Herm Thin",
            "output-gain": 0.0,
            "oversampling": "None",
            "release": 5.0,
            "sidechain-preamp": 0.0,
            "stereo-link": 100.0,
            "threshold": 0.0
        },
        "plugins_order": [
            "equalizer#0",
            "limiter#0"
        ]
    }
}
EOF

echo "[7] Copying left EQ bands to right channel..."
python3 << 'PY'
import json
from pathlib import Path

preset = Path.home() / ".config/easyeffects/output/acer-aspire.json"

with preset.open("r", encoding="utf-8") as f:
    data = json.load(f)

eq = data["output"]["equalizer#0"]
eq["right"] = json.loads(json.dumps(eq["left"]))

with preset.open("w", encoding="utf-8") as f:
    json.dump(data, f, indent=4)

print("EasyEffects preset fixed successfully.")
PY

echo "[8] Restarting audio services..."
systemctl --user daemon-reexec || true
systemctl --user restart pipewire pipewire-pulse wireplumber || true

echo "[9] Setting default analog speaker sink..."
pactl set-default-sink alsa_output.pci-0000_05_00.6.analog-stereo || true
pactl set-sink-volume @DEFAULT_SINK@ 90% || true
pactl set-sink-mute @DEFAULT_SINK@ false || true

echo "[10] Restarting EasyEffects..."
pkill easyeffects || true
nohup easyeffects >/dev/null 2>&1 &

echo
echo "=== Done ==="
echo "Recommended: reboot now:"
echo "sudo reboot"
echo
echo "After reboot, verify:"
echo "cat /sys/module/snd_hda_intel/parameters/power_save"
echo "systool -vm snd_hda_intel | grep model"
echo "pactl list short sinks"
echo "speaker-test -c 2"