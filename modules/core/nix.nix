{username, ...}: {
  nix.settings = {
    trusted-users = ["${username}"];

    trusted-substituters = [
      "https://cache.garnix.io"
      "https://hyprland.cachix.org"
    ];

    trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };
}
