#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# opam configuration
test -r /home/travis/.opam/opam-init/init.sh && . /home/travis/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
