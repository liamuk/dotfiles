source /usr/local/share/antigen/antigen.zsh

antigen use oh-my-zsh
antigen bundle git
antigen bundle osx
antigen theme ys
antigen apply

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

export ONLINETOWN_GAMESERVERS=root@five.siempre.io,root@six.siempre.io,root@seven.siempre.io,root@eight.siempre.io,root@nine.siempre.io,root@ten.siempre.io,root@eleven.siempre.io,root@twelve.siempre.io,root@thirteen.siempre.io,root@fourteen.siempre.io,root@fifteen.siempre.io,root@sixteen.siempre.io,root@seventeen.siempre.io,root@eighteen.siempre.io,root@nineteen.siempre.io,root@twenty.siempre.io,root@twentyone.siempre.io,root@twentytwo.siempre.io,root@twentythree.siempre.io,root@twentyfour.siempre.io
export ONLINETOWN_HTTPSERVERS=root@one.siempre.io,root@two.siempre.io,root@three.siempre.io,root@four.siempre.io
export ONLINETOWN_GAMESERVERS_DEV=root@thirty.siempre.io
export ONLINETOWN_LOADTESTSERVERS=root@thirtyone.siempre.io,root@thirtytwo.siempre.io,root@thirtythree.siempre.io,root@thirtyfour.siempre.io,root@thirtyfive.siempre.io
