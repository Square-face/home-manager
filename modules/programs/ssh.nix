{ pkgs, ... }:
{
  programs.ssh.enable = true;
  programs.ssh.package = pkgs.openssh_hpnWithKerberos;
  programs.ssh.extraConfig = ''
    CanonicalizeHostname yes
    CanonicalDomains dh3.ludd.ltu.se t1.ludd.ltu.se ludd.ltu.se

    Host *.ltu.se
      GSSAPIAuthentication yes
      GSSAPIDelegateCredentials yes
  '';

  programs.ssh.settings = {
    "*" = {
      ForwardAgent = false;
      AddKeysToAgent = "no";
      Compression = false;
      ServerAliveInterval = 0;
      ServerAliveCountMax = 3;
      HashKnownHosts = false;
      UserKnownHostsFile = "~/.ssh/known_hosts";
      ControlMaster = "no";
      ControlPath = "~/.ssh/master-%r@%n:%p";
      ControlPersist = "no";
    };
    "markus" = {
      Hostname = "10.2.0.1";
      User = "root";
    };
    "shitbix" = {
      Hostname = "10.2.1.1";
      User = "root";
    };
    "frank" = {
      Hostname = "10.2.2.1";
      ForwardAgent = true;
      RemoteForward = {
        host.address = "/run/user/1000/gnupg/d.mxiqgwmcfurywf15ry8o1gfm/S.gpg-agent";
        bind.address = "/run/user/1001/gnupg/d.mxiqgwmcfurywf15ry8o1gfm/S.gpg-agent";
      };
    };
    "shrexbox" = {
      Hostname = "10.2.100.1";
      User = "sq8";
      ForwardAgent = true;
      RemoteForward = {
        host.address = "/run/user/1000/gnupg/d.mxiqgwmcfurywf15ry8o1gfm/S.gpg-agent";
        bind.address = "/run/user/1000/gnupg/d.mxiqgwmcfurywf15ry8o1gfm/S.gpg-agent";
      };
    };
  };

  programs.ssh.enableDefaultConfig = false;
}
