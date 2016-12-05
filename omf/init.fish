set -x PATH $HOME/bin/ $PATH
set -x EDITOR vim
set -x CUCUMBER_FORMAT pretty

# Load fishmarks (http://github.com/techwizrd/fishmarks)
. ~/.fishmarks/marks.fish

# Go to dailydrip content
function drips
  cd ~/Dropbox\ \(DailyDrip\)/DailyDrip\ Content
end

### git ################
function gfo
  git fetch origin
end

function gpsom
  git push origin master
end

function gcom
  git checkout origin master
end

function gmom
  git merge origin master
end

function gs
  git status
end

function ga
  git add .
end

function gc
  git commit -v
end
### end git ############

function servedir
  ruby -run -e httpd . -p 9091
end

function fs
  foreman start -f Procfile.dev.osx
end

function elmloc
  find . -name '\''*.elm'\'' | grep -v elm-stuff | xargs cloc
end

function vim
  nvim $argv
end

function ctags
  set brew_prefix (brew --prefix)
  eval $brew_prefix/bin/ctags $argv
end

eval (direnv hook fish)
source ~/.asdf/asdf.fish
