{ ... }:

{
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
    ld = "eza -lD --icons=auto";
    lf = "eza -lF --icons=auto --color=always | grep -v /";
    lh = "eza -dl .* --icons=auto --group-directories-first";
    ll = "eza -al --icons=auto --group-directories-first";
    lss = "eza -alF --icons=auto --color=always --sort=size | grep -v /";
    lt = "eza -al --icons=auto --sort=modified";
    tree = "eza --icons=auto -T";
  };
}
