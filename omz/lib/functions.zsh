function zsh_stats() {
  fc -l 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n20
}


function take() {
  mkdir -p $@ && cd ${@:$#}
}



# Required for $langinfo
zmodload zsh/langinfo
