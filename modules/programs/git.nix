{ pkgs, ... }: {
    programs.git = {
        enable = true;
        settings = {
            alias = {
                pu = "push";
                pl = "pull";
                plr = "pull --rebase";

                ra = "rebase --abort";

                s = "status";

                d = "diff";
                dc = "diff --cached";

                aa = "add .";

                cm = "commit -m"; # Commit with Message
                ca = "commit --amend --no-edit"; # Commit Amend
                ce = "commit --amend"; # Commit amend with Edit

                lg = "log --graph --all --oneline";
                lf = "log --graph --all --decorate --pretty=format:'%C(auto)%h%Creset %C(auto)%d%Creset %s
                %C(dim white)%ar by %C(dim blue)%an %C(dim green)(%G? [%GT])%Creset'";
            };

            gpg.program = "${pkgs.gnupg}/bin/gpg";
            init.defaultBranch = "main";
            user.signingKey = "EE2123F59C2880C4";
            user.name = "Linus Michelsson";
            user.email = "linus@sq8.dev";
        };
        signing = {
            format = "openpgp";
            signByDefault = true;
        };
    };
}
