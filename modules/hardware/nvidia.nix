{
  config,
  lib,
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

  };
}
