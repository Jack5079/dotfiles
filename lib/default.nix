{ lib }: {
  patchOutput = old: cmd: old.stdenv.mkDerivation {
    name = "${old.name}-overridden";

    # Using `buildCommand` replaces the original packages build phases.
    buildCommand = ''
      set -euo pipefail

      ${
        # Copy original files, for each split-output (`out`, `dev` etc.).
        # E.g. `${package.dev}` to `$dev`, and so on. If none, just "out".
        # Symlink all files from the original package to here (`cp -rs`),
        # to save disk space.
        # We could alternatiively also copy (`cp -a --no-preserve=mode`).
        lib.concatStringsSep "\n"
          (map
            (outputName:
              ''
                echo "Copying output ${outputName}"
                set -x
                cp -rs --no-preserve=mode "${old.${outputName}}" "''$${outputName}"
                set +x
              ''
            )
            (old.outputs or ["out"])
          )
      }

      ${cmd}
    '';
    meta = old.meta;
  };
}
