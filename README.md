# vis-backup

A vis plugin that makes backups of current files before saving.

Writes backups to `~/.vis-backups`.
This backup folder must exist and you need permissions to write to it.

Call `backup.set_directory(path)` to save backups to a different directory.
See below for configuation examples.

## Installing this vis plugin

Download the repository. One way is with the git CLI:

```
git clone https://github.com/roguh/vis-backup
```

Ensure the directory `vis-backup/` is next to `visrc.lua`.

```sh
$ ls
visrc.lua vis-backup/
```

Add this line to your `visrc.lua` to load the `backup.lua` file:

```lua
require('vis-backup/backup')
```

It may be simpler to copy the `backup.lua` file adjacent to `visrc.lua` and run `require('backup')`.

`visrc.lua` can be found at `XDG_CONFIG_HOME/vis` or `$HOME/.config/vis`.
If not set, use `:help` for instructions on how to initialize `vis`.
You may also install it in Lua's path.
See documentation about the [`require` function](https://www.lua.org/pil/8.1.html).

If the backup.lua file is found in another directory, use the different path:

```lua
backup = require('plugins-directory/vis-backup/backup')
-- Call this if the backup directory doesn't exist
backup.set_directory(os.getenv('HOME') .. '/.cache/bak')
```

```sh
$ tree
.
├── vis-backup
│   ├── README.md
│   └── backup.lua
└── visrc.lua
```

## Configuration

To configure this module, you may modify the `backup` table, for example:

```lua
backup = require('backup')
backup.byte_limit = 500000
backup.set_directory(getenv('HOME') .. '/.cache/vis-bak')
```

## Configuring backup path and backup filenames

Default configuration:

```lua
backup.set_directory(os.getenv('HOME') .. '/.vis-backups')
backup.get_fname = backup.entire_path_with_double_percentage_signs
backup.time_format = '%H-%M-'
-- 1MB
backup.byte_limit = 1000000
```

## Save to another directory (with timestamp)

Add this to your `visrc.lua`:

```lua
backup.get_fname = backup.entire_path_with_double_percentage_signs_and_timestamp
```

## Save to current directory with a tilde at the end (Emacs/Vim style)

Add this to your `visrc.lua`:

```lua
backup.get_fname = function(_, filepath)
  return filepath .. '~'
end
```

`filepath` will not be `nil`.

This should write a copy of your file to `filename~` before saving it. 

## Configuring size limit

Files longer than `backup.byte_limit` bytes are not backed up.
Default is 1MB.

## Other plugins

See [Vis' plugins documentation](https://github.com/martanne/vis/wiki/Plugins).
