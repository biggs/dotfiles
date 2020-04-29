# Felix' Fish Configuration Init File.

# Import a .profile file if it exists.
# This requires fish-foreign-env (a nix package) to interpret
# bash commands, and can be used to get nix into the PATH.
function import-dot-profile
  set fenv_path /Users/felix/.nix-profile/share/fish-foreign-env/functions
  set fish_function_path $fenv_path $fish_function_path
  fenv source $HOME/.profile > /dev/null
end
if test -e ~/.profile; import-dot-profile; end


# Better Greeting.
function fish_greeting
    begin
        echo (date) " @ " (hostname)
        echo
        fortune -a
        echo
    end | lolcat
end

# Fix a problem with paging on nixos, will be resolved once fish version is
# updated. https://github.com/NixOS/nixpkgs/issues/85158

set PAGER less
set LESS "-R"


function awaketime -d "Display time since last waking."
    echo "Awake Since " \
    (pmset -g log | awk -e '/ Wake  /{print $2}' | tail -n 1)
end


function gitlog -d "More detailed, prettified output for git."
    git log --graph --abbrev-commit \
    --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"
end


function ghci-nix -d "Nix shell with haskell and packages."
    set PCKS ""
    for s in $argv
        set PCKS "$s $PCKS"
    end
    nix-shell -p "haskellPackages.ghcWithPackages (ps: with ps; [ $PCKS ])" \
    --command ghci
end


function ranger-cd                                                               
  set tempfile '/tmp/chosendir'                                                  
  ranger --choosedir=$tempfile (pwd)                                    

  if test -f $tempfile                                                           
      if [ (cat $tempfile) != (pwd) ]                                            
        cd (cat $tempfile)                                                       
      end                                                                        
  end                                                                            

  rm -f $tempfile                                                                
end

function fish_user_key_bindings                                                  
    bind \co 'ranger-cd ; fish_prompt'                                           
end
