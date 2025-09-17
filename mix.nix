{ lib, beamPackages, overrides ? (x: y: {}) }:

let
  buildRebar3 = lib.makeOverridable beamPackages.buildRebar3;
  buildMix = lib.makeOverridable beamPackages.buildMix;
  buildErlangMk = lib.makeOverridable beamPackages.buildErlangMk;

  self = packages // (overrides self packages);

  packages = with beamPackages; with self; {
    ayesql = buildMix rec {
      name = "ayesql";
      version = "1.1.3";

      src = fetchHex {
        pkg = "ayesql";
        version = "${version}";
        sha256 = "c88d4dcd02234c90e4f8ce5c4e1fe601390c1f722a403d7bbccba663854bf587";
      };

      beamDeps = [ postgrex ];
    };

    castore = buildMix rec {
      name = "castore";
      version = "1.0.5";

      src = fetchHex {
        pkg = "castore";
        version = "${version}";
        sha256 = "8d7c597c3e4a64c395980882d4bca3cebb8d74197c590dc272cfd3b6a6310578";
      };

      beamDeps = [];
    };

    cc_precompiler = buildMix rec {
      name = "cc_precompiler";
      version = "0.1.11";

      src = fetchHex {
        pkg = "cc_precompiler";
        version = "${version}";
        sha256 = "3427232caf0835f94680e5bcf082408a70b48ad68a5f5c0b02a3bea9f3a075b9";
      };

      beamDeps = [ elixir_make ];
    };

    connection = buildMix rec {
      name = "connection";
      version = "1.1.0";

      src = fetchHex {
        pkg = "connection";
        version = "${version}";
        sha256 = "722c1eb0a418fbe91ba7bd59a47e28008a189d47e37e0e7bb85585a016b2869c";
      };

      beamDeps = [];
    };

    db_connection = buildMix rec {
      name = "db_connection";
      version = "2.8.1";

      src = fetchHex {
        pkg = "db_connection";
        version = "${version}";
        sha256 = "a61a3d489b239d76f326e03b98794fb8e45168396c925ef25feb405ed09da8fd";
      };

      beamDeps = [ telemetry ];
    };

    decimal = buildMix rec {
      name = "decimal";
      version = "2.3.0";

      src = fetchHex {
        pkg = "decimal";
        version = "${version}";
        sha256 = "a4d66355cb29cb47c3cf30e71329e58361cfcb37c34235ef3bf1d7bf3773aeac";
      };

      beamDeps = [];
    };

    earmark_parser = buildMix rec {
      name = "earmark_parser";
      version = "1.4.12";

      src = fetchHex {
        pkg = "earmark_parser";
        version = "${version}";
        sha256 = "711e2cc4d64abb7d566d43f54b78f7dc129308a63bc103fbd88550d2174b3160";
      };

      beamDeps = [];
    };

    elixir_make = buildMix rec {
      name = "elixir_make";
      version = "0.9.0";

      src = fetchHex {
        pkg = "elixir_make";
        version = "${version}";
        sha256 = "db23d4fd8b757462ad02f8aa73431a426fe6671c80b200d9710caf3d1dd0ffdb";
      };

      beamDeps = [];
    };

    ex_doc = buildMix rec {
      name = "ex_doc";
      version = "0.23.0";

      src = fetchHex {
        pkg = "ex_doc";
        version = "${version}";
        sha256 = "f5e2c4702468b2fd11b10d39416ddadd2fcdd173ba2a0285ebd92c39827a5a16";
      };

      beamDeps = [ earmark_parser makeup_elixir ];
    };

    ex_unicode = buildMix rec {
      name = "ex_unicode";
      version = "1.12.0";

      src = fetchHex {
        pkg = "ex_unicode";
        version = "${version}";
        sha256 = "6bc1cbc70320159eea53812eba3824c7089882cc77636b6de286b301b64ed267";
      };

      beamDeps = [];
    };

    hashids = buildMix rec {
      name = "hashids";
      version = "2.1.0";

      src = fetchHex {
        pkg = "hashids";
        version = "${version}";
        sha256 = "172163b1642d415881ef1c6e1f1be12d4e92b0711d5bbbd8854f82a1ce32d60b";
      };

      beamDeps = [];
    };

    image = buildMix rec {
      name = "image";
      version = "0.62.0";

      src = fetchHex {
        pkg = "image";
        version = "${version}";
        sha256 = "3c28dd98b1d14f5408b5d5c1d46258f54119468979286379033cc1efa87155ac";
      };

      beamDeps = [ phoenix_html sweet_xml vix ];
    };

    makeup = buildMix rec {
      name = "makeup";
      version = "1.0.5";

      src = fetchHex {
        pkg = "makeup";
        version = "${version}";
        sha256 = "cfa158c02d3f5c0c665d0af11512fed3fba0144cf1aadee0f2ce17747fba2ca9";
      };

      beamDeps = [ nimble_parsec ];
    };

    makeup_elixir = buildMix rec {
      name = "makeup_elixir";
      version = "0.14.1";

      src = fetchHex {
        pkg = "makeup_elixir";
        version = "${version}";
        sha256 = "f2438b1a80eaec9ede832b5c41cd4f373b38fd7aa33e3b22d9db79e640cbde11";
      };

      beamDeps = [ makeup ];
    };

    mime = buildMix rec {
      name = "mime";
      version = "1.6.0";

      src = fetchHex {
        pkg = "mime";
        version = "${version}";
        sha256 = "31a1a8613f8321143dde1dafc36006a17d28d02bdfecb9e95a880fa7aabd19a7";
      };

      beamDeps = [];
    };

    nimble_parsec = buildMix rec {
      name = "nimble_parsec";
      version = "0.6.0";

      src = fetchHex {
        pkg = "nimble_parsec";
        version = "${version}";
        sha256 = "27eac315a94909d4dc68bc07a4a83e06c8379237c5ea528a9acff4ca1c873c52";
      };

      beamDeps = [];
    };

    observer_cli = buildMix rec {
      name = "observer_cli";
      version = "1.8.4";

      src = fetchHex {
        pkg = "observer_cli";
        version = "${version}";
        sha256 = "0fcd71ac723bcd2d91266d99b3c3ccd9465c71c9f392d900cea8effdc1a1485c";
      };

      beamDeps = [ recon ];
    };

    phoenix_html = buildMix rec {
      name = "phoenix_html";
      version = "4.2.1";

      src = fetchHex {
        pkg = "phoenix_html";
        version = "${version}";
        sha256 = "cff108100ae2715dd959ae8f2a8cef8e20b593f8dfd031c9cba92702cf23e053";
      };

      beamDeps = [];
    };

    postgrex = buildMix rec {
      name = "postgrex";
      version = "0.15.13";

      src = fetchHex {
        pkg = "postgrex";
        version = "${version}";
        sha256 = "3ffb76e1a97cfefe5c6a95632a27ffb67f28871c9741fb585f9d1c3cd2af70f1";
      };

      beamDeps = [ connection db_connection decimal ];
    };

    recon = buildMix rec {
      name = "recon";
      version = "2.5.6";

      src = fetchHex {
        pkg = "recon";
        version = "${version}";
        sha256 = "96c6799792d735cc0f0fd0f86267e9d351e63339cbe03df9d162010cefc26bb0";
      };

      beamDeps = [];
    };

    sweet_xml = buildMix rec {
      name = "sweet_xml";
      version = "0.7.5";

      src = fetchHex {
        pkg = "sweet_xml";
        version = "${version}";
        sha256 = "193b28a9b12891cae351d81a0cead165ffe67df1b73fe5866d10629f4faefb12";
      };

      beamDeps = [];
    };

    telemetry = buildRebar3 rec {
      name = "telemetry";
      version = "1.3.0";

      src = fetchHex {
        pkg = "telemetry";
        version = "${version}";
        sha256 = "7015fc8919dbe63764f4b4b87a95b7c0996bd539e0d499be6ec9d7f3875b79e6";
      };

      beamDeps = [];
    };

    vix = buildMix rec {
      name = "vix";
      version = "0.35.0";

      src = fetchHex {
        pkg = "vix";
        version = "${version}";
        sha256 = "a3e80067a89d0631b6cf2b93594e03c1b303a2c7cddbbdd28040750d521984e5";
      };

      beamDeps = [ cc_precompiler elixir_make ];
    };
  };
in self

