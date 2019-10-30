{ mkDerivation, base, containers, fetchgit, pandoc-types
, pcre-heavy, stdenv
}:
mkDerivation {
  pname = "pandoc-unicode-math";
  version = "1.1.0";
  src = fetchgit {
    url = "https://github.com/marhop/pandoc-unicode-math.git";
    sha256 = "1rsaslq43cv74q1cdkjxg45fdvvkwjmwhd3v7bngszv1js8mkjs0";
    rev = "e0dfed06b03b03a3f23db9d19fd5547655a38626";
    fetchSubmodules = true;
  };
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    base containers pandoc-types pcre-heavy
  ];
  homepage = "https://github.com/marhop/pandoc-unicode-math";
  description = "Replace Unicode symbols by equivalent Latex commands";
  license = stdenv.lib.licenses.bsd3;
}
