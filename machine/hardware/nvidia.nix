{
  config,
  lib,
  username,
  ...
}:

{
  hardware.graphics.enable = true;
  hardware.i2c.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  # Load the driver in the initrd, before Plymouth starts. Otherwise Plymouth
  # comes up on the firmware's simpledrm framebuffer, nvidia_drm takes the
  # display over a moment later, simpledrm disappears and the splash is left
  # with no device to draw on — which looks like a black screen.
  boot.initrd.kernelModules = [
    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
    # Without this, suspend/resume leaves VRAM state uninitialized: black
    # screen at the password prompt, then missing wallpaper and a glitched
    # compositor after login.
    powerManagement.enable = true;
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  # For nvidia-settings to reach the GPU over i2c.
  users.users.${username}.extraGroups = lib.mkAfter [ "i2c" ];
}
