use re

fn setup {
  E:NIX_USER_PROFILE_DIR = "/nix/var/nix/profiles/per-user/"$E:USER
  nix-profiles = [
    "/run/current-system/sw"
    $E:NIX_USER_PROFILE_DIR
    $E:HOME"/.nix-profile"
  ]
  E:NIX_PROFILES = (joins " " $nix-profiles)

  nix-paths = [
    $E:HOME"/.nix-defexpr/channels"
    "/nix/var/nix/profiles/per-user/root/channels/"
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "nixos-config=/etc/nixos/configuration.nix"
  ]
  E:NIX_PATH = (joins ":" $nix-paths)
  
  paths = [
    /run/wrappers/bin
    ~/.nix-profile/bin
    /run/current-system/sw/bin
    $@paths
  ]
}

fn search [@pkgs]{
  pipecmd = cat
  opts = []
  if (eq $pkgs[0] "--json") {
    pipecmd = json_pp
  }
  nix-env -qa $@opts $@pkgs | $pipecmd
}

fn install [@pkgs]{
  nix-env -i $@pkgs
}

fn info [pkg]{
  # Get data
  install-path = nil
  installed = ?(install-path = [(re:split '\s+' (nix-env -q --out-path $pkg 2>/dev/null))][1])
  flag = (if $installed { put "-q" } else { put "-qa" })
  data = (nix-env $flag --json $pkg | from-json)
  top-key = (keys $data | take 1)
  pkg = $data[$top-key]
  meta = $pkg[meta]

  # Produce the output
  print (styled $pkg[name] yellow)
  if (has-key $meta description) {
    echo ":" $meta[description]
  } else {
    echo ""
  }
  if (has-key $meta homepage) {
    echo (styled "Homepage: " blue) $meta[homepage]
  }
  if $installed {
    echo (styled "Installed:" green) $install-path
  } else {
    echo (styled "Not installed" red)
  }
  echo From: (re:replace ':\d+' "" $meta[position])
  if (has-key $meta longDescription) {
    echo ""
    echo $meta[longDescription] | fmt
  }
}
