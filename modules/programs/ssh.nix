{pkgs, ...}: {
    programs.ssh.enable = true;
    programs.ssh.package = pkgs.openssh_hpnWithKerberos;
    programs.ssh.extraConfig = ''
    CanonicalizeHostname yes
    CanonicalDomains dh3.ludd.ltu.se t1.ludd.ltu.se ludd.ltu.se
    
    Host *.ltu.se
      GSSAPIAuthentication yes
      GSSAPIDelegateCredentials yes
    '';

    programs.ssh.matchBlocks = {
        "*" = {
            forwardAgent = false;
            addKeysToAgent = "no";
            compression = false;
            serverAliveInterval = 0;
            serverAliveCountMax = 3;
            hashKnownHosts = false;
            userKnownHostsFile = "~/.ssh/known_hosts";
            controlMaster = "no";
            controlPath = "~/.ssh/master-%r@%n:%p";
            controlPersist = "no";
        };
        "markus" = {
            hostname = "10.2.0.1";
            user = "root";
            port = 22;
        };
        "shitbix" = {
            hostname = "10.2.1.1";
            user = "root";
            port = 22;
        };
        "frank" = {
            hostname = "10.2.2.1";
            port = 22;
            remoteForwards = [{
                host.address = "/run/user/1000/gnupg/d.mxiqgwmcfurywf15ry8o1gfm/S.gpg-agent.extra";
                bind.address = "/run/user/1001/gnupg/d.mxiqgwmcfurywf15ry8o1gfm/S.gpg-agent";
            }];
        };
        "shrexbox" = {
            hostname = "10.2.100.1";
            user = "sq8";
            port = 22;
            forwardAgent = true;
        };
    };

    programs.ssh.enableDefaultConfig = false;
}
