vim
===

Plugins are loaded as vim packages. You can see the plugin list at
https://github.com/james-w/setup/blob/master/roles/vim/tasks/main.yml

The config is inspired by spacemacs, and built around the leader
key and vim-which-key to provide that experience.

Structure
---------

There is the core vimrc that should be symlinked to ~/.vimrc. This then loads
various config files from the config dir. This should be symlinked to
~/.vim/config/

This means that there is not one massive config file, but a more modular approach.
