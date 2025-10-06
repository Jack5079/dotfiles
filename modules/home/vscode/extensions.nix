{ extensions, pkgs }: builtins.concatLists (builtins.attrValues {
  markdown = with extensions; [
    bierner.markdown-emoji
    # bierner.markdown-mermaid
    bpruitt-goddard.mermaid-markdown-syntax-highlighting
    davidanson.vscode-markdownlint
    mushan.vscode-paste-image
    unifiedjs.vscode-mdx
    yzhang.markdown-all-in-one
  ];
  fullstack = with extensions; [
    astro-build.astro-vscode
    bierner.comment-tagged-templates
    codespaces-contrib.codeswing
    dtsvet.vscode-wasm
    ecmel.vscode-html-css
    firefox-devtools.vscode-firefox-debug
    fivethree.vscode-svelte-snippets
    yoavbls.pretty-ts-errors
    marko-js.marko-vscode
    ms-playwright.playwright
    ms-vscode.live-server
    orta.vscode-twoslash-queries
    oven.bun-vscode
    svelte.svelte-vscode
    sysoev.language-stylus
    thisismanta.stylus-supremacy
    typespec.typespec-vscode
  ];
  gnome = with extensions; [
    bodil.blueprint-gtk
    nico-castell.linux-desktop-file
  ];
  roblox = with extensions; [
    # evaera.vscode-rojo
    koihik.vscode-lua-format
    # nightrains.robloxlsp
    # roblox-ts.vscode-roblox-ts
  ];
  themes = with extensions; [
    # github.github-vscode-theme
    johnpapa.vscode-peacock
    kde.breeze
    piousdeer.adwaita-theme
    vscode-icons-team.vscode-icons
    littensy.charmed-icons # Orca my beloved
    keksiqc.idx-monospace-theme
  ];
  rust = with extensions; [
    relm4.relm4-snippets
    # pkgs.vscode-extensions.rust-lang.rust-analyzer
    rust-lang.rust-analyzer
    tamasfe.even-better-toml
    rust10x.rust10x
  ];
  java = with extensions; [
    vscjava.vscode-maven
    vscjava.vscode-java-debug
    redhat.java
    vscjava.vscode-java-dependency
    vscjava.vscode-gradle
  ];
  # dotnet = with extensions; [
  #   ionide.ionide-fsharp
  #   ms-dotnettools.csharp
  # ];
  minecraft = with extensions; [
    jackmacwindows.vscode-computercraft
    sumneko.lua
    object-object.hex-casting
  ];
  other = with extensions; [
    swiftlang.swift-vscode
    # supermaven.supermaven
    /*pkgs.vscode-extensions.*/github.copilot
    /*pkgs.vscode-extensions.*/github.copilot-chat
    bierner.emojisense
    editorconfig.editorconfig
    esbenp.prettier-vscode
    # github.remotehub
    qwtel.sqlite-viewer
    pkgs.vscode-extensions.github.vscode-pull-request-github
    hbenl.vscode-test-explorer
    icrawl.discord-vscode
    jnoortheen.nix-ide
    mhutchie.git-graph # Nonfree, similar functionality now built into Code
    mikestead.dotenv
    pkgs.vscode-extensions.ms-vscode-remote.remote-ssh
    pkgs.vscode-extensions.ms-vscode-remote.remote-ssh-edit
    pkgs.vscode-extensions.ms-vscode.hexeditor
    ms-vscode.remote-explorer
    ms-vscode.remote-repositories
    ms-vscode.test-adapter-converter
    ms-vsliveshare.vsliveshare
    redhat.vscode-xml
    redhat.vscode-yaml
    spgoding.datapack-language-server
    thenuprojectcontributors.vscode-nushell-lang
    ultram4rine.vscode-choosealicense
    usernamehw.errorlens
    # pkgs.vscode-extensions.vadimcn.vscode-lldb # my pc is trying to build lldb
    visualstudioexptteam.intellicode-api-usage-examples
    visualstudioexptteam.vscodeintellicode
    vivaxy.vscode-conventional-commits
    ziglang.vscode-zig
    # typefox.open-collaboration-tools
  ];
})
