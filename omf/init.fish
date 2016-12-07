set -x PATH $HOME/bin/ $PATH
set -x EDITOR nvim
set -x CUCUMBER_FORMAT pretty
# fzf will ignore files
set -x FZF_DEFAULT_COMMAND 'ag -g ""'

# Load fishmarks (http://github.com/techwizrd/fishmarks)
source ~/.fishmarks/marks.fish

# Go to dailydrip content
function drips
  cd ~/Dropbox\ \(DailyDrip\)/DailyDrip\ Content
end

# Adam's silly 'back' shortcut
function b
  pushd ..
end

function f
  popd
end

### rails ##############
function rdb
  rake db:migrate
end
### end rails ##########

### git ################
function gfo
  git fetch origin
end

function gpsom
  git push origin master
end

function gco
  git checkout $argv
end

function gcom
  git checkout master
end

function gmom
  git merge origin/master
end

function gs
  git status
end

function ga
  git add .
end

function gc
  git commit -v $argv
end

# delete local branches that have been merged into master
function git_clean
  git branch --merged master | grep -v "\* master" | xargs -n 1 git branch -d
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
source ~/.fzf/shell/key-bindings.fish
