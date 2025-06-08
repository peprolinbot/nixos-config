{username, ...}: {
  nix.settings = {
    trusted-users = ["${username}"];
  };
}
