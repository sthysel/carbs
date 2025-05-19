## CLI and GUI Tools to Control PipeWire

PipeWire provides a comprehensive set of command-line and graphical tools for
managing audio (and video) devices, streams, and connections.

---

**CLI Tools**

The main command-line tools for PipeWire management are included in the
`pipewire-utils` package and provide a wide range of functionality[2][5]:

- **pw-cli**: Interactive shell and scripting interface to inspect, control, and
  manipulate PipeWire objects and modules[1][5].
- **pw-link**: Manage connections between audio nodes (e.g., linking sources to
  sinks)[2][5].
- **pw-dump**: Output the current state of the PipeWire daemon in JSON for
  inspection or debugging[2][5].
- **pw-top**: Real-time process viewer for monitoring DSP usage and active
  clients[2][5].
- **pw-mon**: Monitor state changes and events in the PipeWire daemon[2][5].
- **pw-metadata**: Inspect and modify metadata for PipeWire objects[2][5].
- **pw-dot**: Dump a graph of the current audio pipeline for visualization or
  debugging[2][5].
- **pw-cat**: Play and record media streams directly with PipeWire[2].
- **pactl**: Still useful for controlling PulseAudio-compatible features under
  PipeWire’s PulseAudio emulation[5].

---

**GUI Tools**

Several graphical tools are available for managing and visualizing PipeWire’s audio routing and device configuration:

| Tool                       | Description                                                                               | Package/Source                    |
|----------------------------|-------------------------------------------------------------------------------------------|-----------------------------------|
| **PavuControl**            | Classic PulseAudio control panel, works with PipeWire for device/stream management        | `pavucontrol`                     |
| **qpwgraph**               | Qt-based patchbay/graph manager for PipeWire, similar to QjackCtl but native to PipeWire  | `qpwgraph` (AUR)                  |
| **Helvum**                 | GTK-based patchbay for PipeWire, focused on visualizing and connecting audio nodes        | `helvum` (AUR)                    |
| **Coppwr**                 | Low-level PipeWire GUI for node graph editing, object inspection, metadata, and debugging | `coppwr` or `coppwr-bin` (AUR)[7] |
| **Simple Wireplumber GUI** | GUI for managing devices and properties if using WirePlumber as the session manager       | `simple-wireplumber-gui` (AUR)[3] |

**Other Notables:**
- **Pipewire-sample-rate-config**: GUI for adjusting sample rate and buffer size (AUR)[3].
- Many JACK-oriented tools (like QjackCtl, Carla, Catia) also work with PipeWire’s JACK compatibility layer[6].

---

**Summary Table: Essential PipeWire Tools**

| Type | Tool Name   | Main Purpose                     |
|------|-------------|----------------------------------|
| CLI  | pw-cli      | Inspect/control PipeWire objects |
| CLI  | pw-link     | Manage node connections          |
| CLI  | pw-top      | Monitor DSP and client usage     |
| CLI  | pw-dump     | Dump state for debugging         |
| GUI  | pavucontrol | Device/stream management         |
| GUI  | qpwgraph    | Graphical patchbay, node linking |
| GUI  | helvum      | Visual audio routing             |
| GUI  | coppwr      | Advanced low-level control       |

---


Citations:
[1] https://docs.pipewire.org/page_man_pw-cli_1.html
[2] https://www.mankier.com/package/pipewire-utils
[3] https://linuxmusicians.com/viewtopic.php?t=26839
[4] https://github.com/rncbc/qpwgraph
[5] https://kowalcj0.github.io/2022/01/09/handy-pipewire-commands-and-tools/
[6] https://www.reddit.com/r/pipewire/comments/l2x9ud/gui_for_pipewire/
[7] https://github.com/dimtpap/coppwr
[8] https://docs.voidlinux.org/config/media/pipewire.html
[9] https://pegaso.changeip.org/DOCS/pipewire/html/page_man_pw_cli_1.html
[10] https://www.youtube.com/watch?v=EcMLI3dYMmI
[11] https://askubuntu.com/questions/1444357/switching-from-pulseaudio-to-pipewire-deletes-my-gui
[12] https://www.reddit.com/r/pop_os/comments/v3g2w9/is_there_a_cli_command_to_restart_pipewire/
[13] https://wiki.archlinux.org/title/PipeWire
[14] https://manpages.ubuntu.com/manpages/focal/man1/pipewire-cli.1.html
[15] https://manpages.ubuntu.com/manpages/plucky/man1/pw-cli.1.html
[16] https://github.com/mikeroyal/PipeWire-Guide
[17] https://docs.pipewire.org/group__pw__client.html
