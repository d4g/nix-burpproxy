# nix-burpproxy
burp proxy package for nixos

## manual installation

- download the package
- put the package somewhere
- add the following to /etx/nixos/configuration.nix
```nix
    # add to global let block
    burpProxy = pkgs.callPackage /PATH_TO_BURPPACKAGE {
      stdenv = pkgs.stdenv;
      fetchurl = pkgs.fetchurl;
    };  
    ...
    # add package to environment.systemPackages 
    burpProxy
```
- nixos-rebuild switch

