{ mkDerivation, base, containers, fetchgit, pandoc-types
, pcre-heavy, stdenv
}:
mkDerivation {
  pname = "pandoc-unicode-math";
  version = "1.2.0";
  src = fetchgit {
    url = "https://github.com/marhop/pandoc-unicode-math.git";
    sha256 = "1q1affb3y5cdriqa6dby3r5mqpgsj0hhlj46gp8sxhd9nsks814a";
    rev = "ce737f26de5f5a23164dc7546103d0f59a40d14a";
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
