rec {
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
}
