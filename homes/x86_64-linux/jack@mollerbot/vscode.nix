{ inputs, system, ... }: {
  programs.vscode = {
    enable = true;
    # https://github.com/nix-community/home-manager/issues/4394#issuecomment-1712909231
    mutableExtensionsDir = false;
    languageSnippets = rec {
      javascript = {
        "Random from array" = {
          prefix = "random";
          body = ''
            /** @type {<Type>(arr: Type[]) => Type} */
            const $\{0:random} = arr => arr[Math.floor(Math.random() * arr.length)]
          '';
        };
      };
      typescript = {
        "Random from array" = {
          prefix = "random";
          body = "const $\{0:random} = <Type>(arr: readonly Type[]): Type => arr[Math.floor(Math.random() * arr.length)]";
        };
      };
      css = {
        # Centering methods from https://web.dev/centering-in-css
        "Gentle Flex" = {
          prefix = "center";
          body = ''
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 1ch;
            flex-direction: $\{0:row};
          '';
          description = ''
            # Pros

            - Only handles alignment, direction, and distribution
            - Edits and maintenance are all in one spot
            - Gap guarantees equal spacing amongst n children

            # Cons

            - Most lines of code
          '';
        };
        "Content Center" = {
          prefix = "center";
          body = ''
            display: grid;
            place-content: center;
            gap: 1ch;
          '';
          description = ''
            # Pros

            - Content is centered even under constrained space and overflow
            - Centering edits and maintenance are all in one spot
            - Gap guarantees equal spacing amongst n children

            # Cons

            - The widest child (max-content) sets the width for all the rest
          '';
        };
        "Pop & Plop" = {
          prefix = "center";
          body = ''
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
          '';
          description = ''
            # Pros

            - Useful
            - Reliable
            - When you need it, it’s invaluable

            # Cons

            - Code with negative percentage values
            - Requires `position: relative` to force a containing block
            - Early and awkward line breaks
            - There can be only 1 per containing block without additional effort
          '';
        };
        Shine = {
          prefix = "shine";
          description = "all my diamonds be shining"; # yeat reference!
          # From https://maliciousmeaning.dev which is in turn from https://css-tip.com/3d-shine-effect, maybe I should use the one from https://ui-snippets.dev instead
          body = ''
            .shine {
              mask: linear-gradient(135deg, rgba(0,0,0,.5) 40%, black, rgba(0,0,0,.5) 60%) 100% 100% / 240% 240%;
              animation: shine 2s infinite;
              animation-fill-mode: none;
              display: flex;
              justify-content: center;
              align-items: center;
              gap: 1ch;
              flex-direction: row;
            }
            @keyframes shine {
              from {
                mask-position: 150% 0;
              }
              to {
                mask-position: 0 0;
              }
            }
          '';
        };
      };
      scss = css;
      postcss = css;
    };
    extensions = with inputs.vscode-extensions.extensions.${system}.vscode-marketplace; [
      astro-build.astro-vscode
      bierner.comment-tagged-templates
      bierner.emojisense
      bierner.markdown-emoji
      bierner.markdown-mermaid
      bodil.blueprint-gtk
      bpruitt-goddard.mermaid-markdown-syntax-highlighting
      catppuccin.catppuccin-vsc
      codespaces-contrib.codeswing
      davidanson.vscode-markdownlint
      drmerfy.overtype
      dtsvet.vscode-wasm
      ecmel.vscode-html-css
      editorconfig.editorconfig
      esbenp.prettier-vscode
      evaera.vscode-rojo
      firefox-devtools.vscode-firefox-debug
      fivethree.vscode-svelte-snippets
      github.copilot
      github.copilot-chat
      github.copilot-labs
      github.github-vscode-theme
      github.remotehub
      hbenl.vscode-test-explorer
      jnoortheen.nix-ide
      johnpapa.vscode-peacock
      kde.breeze
      koihik.vscode-lua-format
      levertion.mcjson
      marko-js.marko-vscode
      mhutchie.git-graph
      mikestead.dotenv
      ms-playwright.playwright
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-ssh-edit
      ms-vscode.hexeditor
      ms-vscode.live-server
      ms-vscode.remote-explorer
      ms-vscode.remote-repositories
      ms-vscode.test-adapter-converter
      ms-vsliveshare.vsliveshare
      mushan.vscode-paste-image
      nico-castell.linux-desktop-file
      nightrains.robloxlsp
      piousdeer.adwaita-theme
      pkief.material-icon-theme
      redhat.vscode-commons
      redhat.vscode-xml
      redhat.vscode-yaml
      relm4.relm4-snippets
      roblox-ts.vscode-roblox-ts
      rust-lang.rust-analyzer
      scrimba.vsimba
      spgoding.datapack-language-server
      svelte.svelte-vscode
      swellaby.vscode-rust-test-adapter
      sysoev.language-stylus
      tamasfe.even-better-toml
      thenuprojectcontributors.vscode-nushell-lang
      thisismanta.stylus-supremacy
      ultram4rine.vscode-choosealicense
      unifiedjs.vscode-mdx
      usernamehw.errorlens
      vadimcn.vscode-lldb
      visualstudioexptteam.intellicode-api-usage-examples
      visualstudioexptteam.vscodeintellicode
      vivaxy.vscode-conventional-commits
      vscode-icons-team.vscode-icons
      yzhang.markdown-all-in-one
      ziglang.vscode-zig
    ] ++ [ inputs.vscode-extensions.extensions.${system}.vscode-marketplace."30-seconds"."30-seconds-of-code" ]; # :molly_tired:
  };
}
