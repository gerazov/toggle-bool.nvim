# toggle-bool.nvim

This is a very simple Neovim plugin that can be used to toggle various boolean-like values.

The toggle included by default is
- `True` ←→ `False`

The toggle works for the first match on the current line and does not change the cursor position. Upper, lower and capitalized case are supported and retained.

Additional toggles can be enabled via the setup function, e.g.:
- `Yes` ←→ `No`
- `On` ←→ `Off`
- `1` ←→ `0`
- `Enable(d)` ←→ `Disable(d)`
- `First` ←→ `Last`
- `Before` ←→ `After`
- `Persistent` ←→ `Ephemeral`
- `Internal` ←→ `External`
- `Ingress` ←→ `Egress`
- `Allow` ←→ `Deny`
- `All` ←→ `None`

This plugin is a port of the Vim version [gerazov/vim-toggle-bool](https://github.com/gerazov/vim-toggle-bool).

## Setup

The plugin can be installed via a plugin manager. 

For [packer.nvim](https://github.com/wbthomason/packer.nvim) it's:

```lua
use 'gerazov/toggle-bool.nvim'
```

To setup the plugin run:
```lua
require("nvim-highlight-colors").setup {
    mapping = "<leader>t",
	additional_toggles = {
        Yes = 'No',
        On = 'Off',
        1 = '0',
        Enable = 'Disable',
        Enabled = 'Disabled',
        First = 'Last',
        Before = 'After',
        Persistent = 'Ephemeral',
        Internal = 'External',
        Ingress = 'Egress',
        Allow = 'Deny',
        All = 'None',

    },
}
```

## Usage

The plugin creates a single command `ToggleBool`. 
It can be mapped via the setup function.
