This is my working example on how to turn your default nixos configuration into a livecd.
The patch files are there to show how minimal change I needed to make in the nixos livecd files.
My `/etc/nixos/*.nix` files are a bit cut down due to passwords, etc being removed, so I can't guarantee it is fully functional, but should give you an idea anyway.

I suggest you look at:
* Files under `/home/kr2/livecd/` (especially `*.patch` files, they are generated to show what has changed between them and the original files from `~/.nix-defexpr/channels/nixos/...`).
* Difference between `/etc/nixos/configuration.nix` and `/etc/nixos/live-configuration.nix`.
