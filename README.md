<h1 align="center">jack.cab/dotfiles</h1>

<p align="center">
 <a href="https://wiki.nixos.org/wiki/Flakes" target="_blank">
  <img alt="Nix Flakes Ready" src="https://img.shields.io/static/v1?logo=nixos&logoColor=d8dee9&label=Nix%20Flakes&labelColor=5e81ac&message=Ready&color=d8dee9&style=for-the-badge">
</a>
 <a href="https://github.com/snowfallorg/lib" target="_blank">
  <img alt="Built With Snowfall" src="https://img.shields.io/static/v1?logoColor=d8dee9&label=Built%20With&labelColor=5e81ac&message=Snowfall&color=d8dee9&style=for-the-badge">
 </a>
</p>

![Fullscreen screenshot of a GNOME desktop. Wallpaper is Unsplash photo "silhouette of mountains during daytime" modified to make the foreground mountain pure black. JPEG artifacts are visible. GNOME's topbar has been moved to the bottom, made slightly smaller, font changed to Inter, and has the power icon removed with a Wayland icon added to the right. Vesktop is also visible in the system tray.](./screenshot.png)

* [`devShells.rust`](./packages/skylight-wallpaper/default.nix): Basic Rust devshell for temporary experiments
* [`packages.skylight-wallpaper`](./packages/skylight-wallpaper/default.nix): The Etcetera brand wallpaper, designed by yours truly
* [`homeConfigurations.jack`](./homes/x86_64-linux/jack/default.nix): My [Home Manager](https://home-manager.dev) configuration
* [`homeModules.firefox`](./modules/home/firefox/default.nix): Installs Firefox Nightly and allows desktop integrations to work
* [`homeModules.gnome`](./modules/home/gnome/default.nix): Configures GNOME extensions, favorite apps, and keybindings
* [`homeModules.vscode`](./modules/home/vscode/default.nix): Visual Studio Code [extensions](./modules/home/vscode/extensions.nix) and [snippets](./modules/home/vscode/snippets.nix)
* [`nixosConfigurations.mollerbot`](./systems/x86_64-linux/mollerbot/default.nix): My NixOS configuration
* [`nixosModules.hardened`](./modules/nixos/hardened/default.nix): Security settings for NixOS
* [`nixosModules.virt-manager`](./modules/nixos/virt-manager/default.nix): Enables settings required for `virt-manager` including ones that are needed for hardened
