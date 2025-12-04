{
  system = {
    nfu = "cd ~/nix-config && sudo nix flake update";
  };

  git = {
    ga = "git add";
    gaa = "git add .";
    gc = "git add --patch";
    gca = "git commit --amend";
    gcg = "git --no-pager log --graph --topo-order --abbrev-commit --date=short --decorate --all --boundary";
    gcl = "git --no-pager log --topo-order --abbrev-commit --date=short --decorate --all --boundary --reverse";
    gco = "git checkout";
    gcob = "git checkout -b";
    gcom = "git checkout main";
    gcm = "git commit --message";
    gd = "git --no-pager diff";
    gD = "git diff";
    gds = "git --no-pager diff --staged";
    gf = "git fetch";
    gfo = "git fetch --origin";
    gfp = "git push --set-upstream origin `git symbolic-ref --short HEAD`";
    gl = "git pull";
    gp = "git push";
    grsh = "git reset --soft HEAD^";
    grh = "git reset";
    grhh = "git reset --hard";
    gru = "git reset --";
    grset = "git remote set-url";
    gsa = "git stash --all";
    gst = "git --no-pager status";
  };

  bat = {
    cat = "bat";
  };

  eza = {
    ls = "eza -l --icons --group-directories-first --git";
    l = "eza --icons -a --group-directories-first -1";
    ll = "eza --icons -a --group-directories-first -1 --no-user --long";
    tree = "eza --icons --tree --group-directories-first";
  };
}
