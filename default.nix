{ stdenv, buildGoModule, fetchFromGitHub, nixosTests }:

buildGoModule rec {
  pname = "syslogi";
  version = "1.0.0";

  src = ./.;
  vendorSha256=null;

  subPackages = [ "." ];

  runVend = true;

  meta = with stdenv.lib; {
    description = "inspect syslog packages from UDP";
    homepage = "https://github.com/mguentner/syslogi";
    license = licenses.mit;
    maintainers = with maintainers; [ mguentner ];
  };
}
