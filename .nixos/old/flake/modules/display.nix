{ pkgs, ... }: {
	boot.initrd.kernelModules = [ "amdgpu" ];

	#services.xserver.enable = true;
	#services.xserver.videoDrivers = [ "amdgpu" ];

	#hardware.graphics.enable32Bit = true;
	#hardware.graphics.extraPackages = with pkgs; [ amdvlk ];
	#hardware.graphics.extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
	hardware.amdgpu.amdvlk.enable = true;
	hardware.amdgpu.opencl.enable = true;
	hardware.amdgpu.overdrive.enable = false; #Set to true when wanting to overclock
	
}

