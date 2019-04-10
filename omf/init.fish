eval (direnv hook fish)

set -x ERL_AFLAGS "-kernel shell_history enabled"
set -x PATH $HOME/bin/ $HOME/.cargo/bin $PATH
set -x PATH $HOME/Library/Python/3.7/bin $PATH
set -x PATH $HOME/.pulumi/bin $PATH
set -x PATH /usr/local/opt/flex/bin $PATH
set -x PATH /usr/local/opt/openssl/bin $PATH
set -x PATH $PATH $HOME/.linkerd2/bin
set -x ANDROID_HOME /Users/jadams/Library/Android/sdk
set -x PATH $ANDROID_HOME/tools $ANDROID_HOME/platform-tools $PATH
set -x PATH /Users/jadams/.cabal/bin $PATH
set -x GOPATH /Users/jadams/.asdf/installs/golang/1.9.5/packages
set -x PATH $PATH $GOPATH"/bin"
set -x EDITOR nvim
set -x CUCUMBER_FORMAT pretty
# Sigh yarn bins go somewhere weird, let's put them in the path anyway
set -x PATH $HOME"/.config/yarn/global/node_modules/.bin" $HOME"/.yarn/bin" $PATH
# brew bins
set -x PATH "/usr/local/sbin" $PATH
set -x PATH "/usr/local/opt/mariadb@10.1/bin" $PATH
# fzf will ignore files
set -x FZF_DEFAULT_COMMAND 'ag -g ""'
set -x NVM_DIR ~/.nvm
set -x TNS_ADMIN ~/oracle

# Load personal fish config (secrets and whatnot)
source ~/.private.fish

# Load fishmarks (http://github.com/techwizrd/fishmarks)
source ~/.fishmarks/marks.fish

# Go to dailydrip content
function drips
    cd ~/Google\ Drive/Daily\ Drip/Content/
end

# Adam's silly 'back' shortcut
function b
    pushd ..
end

function f
    popd
end

function flushdns
    sudo dscacheutil -flushcache
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
    find . -name \*.elm | grep -v elm-stuff | xargs cloc
end

function vim
    nvim $argv
end

function ctags
    set brew_prefix (brew --prefix)
    eval $brew_prefix/bin/ctags $argv
end

function randomPassword
    openssl rand -base64 30
end

function flushdns
    sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache
end

function dlog
    aws ecr get-login --no-include-email --region us-west-2 | bash
end

source ~/.asdf/asdf.fish
# Uncomment the next line to have /usr/local/bin override asdf shims
#set -x PATH /usr/local/bin $PATH
source ~/.fzf/shell/key-bindings.fish

# Load perlbrew.fish
#source ~/perl5/perlbrew/etc/perlbrew.fish

function cbuild
    eval 'watchmedo shell-command --patterns="*.py;*.qss" --recursive --command='"'"'echo "" && osascript -e "quit app \"Python\"" && python3 main.py'"'"
end

function ctest
    eval 'watchmedo shell-command --patterns="*.py;*.qss" --recursive --command='"'"'echo "" && python3 -m pytest'"'"
end

function ccov
    eval 'watchmedo shell-command --patterns="*.py;*.qss" --recursive --command='"'"'echo "" && python3 -m pytest --cov=. --cov-report term-missing'"'"
end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jadams/software/google-cloud-sdk/path.fish.inc' ]
    if type source >/dev/null
        source '/Users/jadams/software/google-cloud-sdk/path.fish.inc'
    else
        . '/Users/jadams/software/google-cloud-sdk/path.fish.inc'
    end
end
