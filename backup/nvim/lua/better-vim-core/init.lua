local hooks = require "better-vim-core.hooks"
local bettervimrc = require "better-vim-core.bettervimrc"

bettervimrc.init()
hooks.before_setup()

require "better-vim-core.functions"
require "better-vim-core.plugins"
require "better-vim-core.lsp"
require "better-vim-core.normalize"
require "better-vim-core.themes"
require "better-vim-core.shortcuts"
require "better-vim-core.tabs"

hooks.after_setup()

require "better-vim-core.tasks"
