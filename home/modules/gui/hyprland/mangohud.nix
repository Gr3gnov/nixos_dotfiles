{ ... }:

{
  home.file.".config/MangoHud/MangoHud.conf".text = ''
    legacy_layout=0
    fps
    frametime
    frame_timing=1
    cpu_stats
    cpu_temp
    gpu_stats
    gpu_temp
    gpu_power
    ram
    vram
    position=top-left
    background_alpha=0.35
    round_corners=10
    font_scale=1.0
    toggle_hud=Shift_R+F12
  '';
}
