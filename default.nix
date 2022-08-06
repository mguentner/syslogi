{ lib, buildGoModule, fetchFromGitHub, nixosTests }:

buildGoModule rec {
  pname = "syslogi";
  version = "1.0.0";

  src = ./.;
  vendorSha256=null;

  subPackages = [ "." ];

  proxyVendor = true;

  meta = with lib; {
    description = "inspect syslog packages from UDP";
    homepage = "https://github.com/mguentner/syslogi";
    license = licenses.mit;
    maintainers = with maintainers; [ mguentner ];
  };
}
