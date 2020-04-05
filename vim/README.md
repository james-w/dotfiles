vim
===

Plugins are loaded as vim packages. You can see the plugin list at
https://github.com/james-w/setup/blob/master/roles/vim/tasks/main.yml

The config is inspired by spacemacs, and built around the leader
key and vim-which-key to provide that experience.

Dependencies
------------

This requires:

  * vim-which-key
  * fzf.vim
  * taboo
  
before it will do much. Other plugins are used when available.

Structure
---------

There is the core vimrc that should be symlinked to ~/.vimrc. This then loads
various config files from the config dir. This should be symlinked to
~/.vim/config/. It uses autoload for some library functions, these should be
linked at ~/.vim/autoload/.

This means that there is not one massive config file, but a more modular approach.

Configuration is done either by the config files or the after plugin files. Each
is responsible for configuring one set of related functionality.

The primary goal of the config is to wire up lost of functions using mnemonic
leader key sequences. Each of these defines an action, along with the binding
and the name for display by vim-which-key.

Lots of the actions make use of fzf for fuzzy selection from lists.

Also it uses "transient states" which are an attempt to provide sub-modes.
They allow for much easier sequences of actions without having to repeat
lots of prefixes. They put you in a sub-mode dedicated to a particular
topic, with keys that bind to common actions, and you remain in that state
until you leave, or one of the actions ends the state.

Ideas
-----

  * Have a binding that shows top-level keys (e.g. y=yank) (<leader>hk in spacemacs)
  * Use vim-which-key on other prefixes to show e.g. possible motions
    for a yank
    - https://github.com/liuchengxu/vim-which-key/issues/14
    - https://github.com/SpaceVim/SpaceVim/blob/331139505ad257bb2e1df6f44557aeda8b247a24/autoload/SpaceVim/mapping/g.vimhttps://github.com/neoclide/coc.nvim
  * NerdCommenter https://github.com/preservim/nerdcommenter
  * coc for completion? https://github.com/neoclide/coc.nvim
  * peeakboo for registers: https://github.com/junegunn/vim-peekaboo
  * quicklist bindings
  * filetype bindings (<leader>m in spacemacs)
  * compilation
  * Fix transient states hiding on tab change
  * Fix last buffer (<leader><tab> trying to show closed buffers) 
    - https://stackoverflow.com/questions/3706958/vim-navigating-to-previous-and-next-buffers-in-edit-history maybe
  * Ability to relaunch greps with same query
  * quickfix list manipulation (compile group?)
  * fzf project files sorted by recency
  * git conflict helper
