{ stdenv, fetchurl, pkgs}:

stdenv.mkDerivation { 
  name = "burpproxy" ;
  # src as environment variable
  src = fetchurl {
    url = "https://portswigger.net/burp/releases/download?product=community&version=1.7.30&type=jar";
    #sha256 = "0aisncarsy1ghd0f88fkxhvsm5bwg4c0hzfcjacv96cm7v1q6yrh";
    sha256 = "0ngpbr4di1sw8ypbmdssqx8v2dm2nfqy91ij0izj94f5wmsg1dki";
    name = "burpproxy.jar";
  };
  buildPhase = ''
    mkdir -p $out/lib
    cp $src $out/lib/burpproxy.jar
  '';

  unpackPhase = "true";
  configureFlags = "true";

  installPhase = ''
    mkdir -p "$out/bin"
    echo "#!/bin/sh" > "$out/bin/burpProxy"
    echo "${pkgs.openjdk}/bin/java -Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dsun.java2d.uiScale=2 -Xms1g -Xmx2g -jar $out/lib/burpproxy.jar" >> $out/bin/burpProxy
    chmod +x "$out/bin/burpProxy"
  '';


  meta = {
    description = "Burp Suite Community Edition";
    longDescription = ''
      Burp Proxy is a standard penetration testing proxy server.
      It provides tracking and manipulation of http traffic and
      is extensible via plugins.
    '';
    license = [ stdenv.lib.licenses.unfree https://portswigger.net/burp/eula/community ] ;
    homepage = https://portswigger.net/burp/communitydownload;
    maintainers = with stdenv.lib.maintainers; [ d4g ];
    platforms = stdenv.lib.platforms.unix;
  };


 }
