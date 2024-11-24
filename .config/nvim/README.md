**How to use**
- Clone this repo to your nvim config directory (usually ~/.config/nvim)
- Run :MasonInstallAll to install all of the required plugins
- Run :TSInstall <language> to install nvim-tresitter syntax highlighting for that language 
  - `:TSInstall dockerfile go html css javascript json lua markdown php typescript yaml angular bash rust`
  - `./install-lsp.sh` to install all the language servers
  - `:Copilot setup` to setup copilot

**This repo is supposed to used as config by NvChad users!**

- The main nvchad repo (NvChad/NvChad) is used as a plugin by this repo.
- So you just import its modules , like `require "nvchad.options" , require "nvchad.mappings"`
- So you can delete the .git from this repo ( when you clone it locally ) or fork it :)

# Credits

1) Lazyvim starter https://github.com/LazyVim/starter as nvchad's starter was inspired by Lazyvim's . It made a lot of things easier!
