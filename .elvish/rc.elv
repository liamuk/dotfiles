use nix
use epm

nix:setup

use github.com/zzamboni/elvish-completions/cd
use github.com/zzamboni/elvish-completions/ssh
use github.com/zzamboni/elvish-completions/git
use github.com/zzamboni/elvish-completions/builtins

use github.com/zzamboni/elvish-modules/alias
-exports- = (alias:export)

use github.com/zzamboni/elvish-modules/terminal-title

edit:insert:binding[Ctrl-A] = { edit:move-dot-sol }
edit:insert:binding[Ctrl-E] = { edit:move-dot-eol }
