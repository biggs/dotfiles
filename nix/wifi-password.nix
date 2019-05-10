{ stdenv }:

stdenv.mkDerivation rec {
  name    = "wifi-password-${version}";
  version = "0.1.0";

  src = builtins.fetchGit {
    url = https://github.com/rauchg/wifi-password/;
    rev = "d17a0dd808464d24e5da8488375727b7c246e1be";
  };
  file = "${src.outPath}" + "/wifi-password.sh";

  phases = "installPhase";

  installPhase = ''
    mkdir -p $out/bin
    cp ${file} $out/bin/wifi-password
    sed 's:security:/usr/bin/security:' $out/bin/wifi-password -i    # This is impure!
    chmod +x $out/bin/wifi-password
  '';

  meta = with stdenv.lib; {
    description = "Get the wifi password. macOS only.";
    homepage = https://github.com/rauchg/wifi-password/;
    platforms = platforms.darwin;
  };
}

# Testing:
# nix-shell -E "with import <nixpkgs> {}; let env = callPackage wifi-password.nix {}; in mkShell { buildInputs = [ env ]; }"
# OR (easier):
# nix-build -E "with import <nixpkgs> {}; callPackage wifi-password.nix {};"
# this will create a ./result link to nix-store.
