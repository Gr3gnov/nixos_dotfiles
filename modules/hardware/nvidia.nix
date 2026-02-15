{
  config,
  lib,
  username,
  ...
}:

let
  cfg = config.my.hardware.nvidia;
in
{
  options.my.hardware.nvidia = {
    enable = lib.mkEnableOption "Nvidia proprietary drivers";
  };

  config = lib.mkIf cfg.enable {

    hardware.graphics.enable = true;
    hardware.i2c.enable = true;

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.production;
    };

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };

    users.users.${username}.extraGroups = lib.mkAfter [ "i2c" ];

  };
}
