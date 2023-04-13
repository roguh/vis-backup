# vis-backup

A vis plugin that makes backups of current files before saving.

Writes backups to `~/.vis-backups`.
This backup folder must exist and you need permissions to write to it.

Call `backup.set_directory(path)` to save backups to a different directory.
See below for configuation examples.

# Installing this vis plugin

Copy `backup.lua` next to `visrc.lua`, then add this line to your `visrc.lua`:

```lua
backup = require('backup')
```

```sh
$ ls
visrc.lua backup.lua
```

`visrc.lua` can be found at `XDG_CONFIG_HOME/vis` or `$HOME/.config/vis`.
If not set, use `:help` for instructions on how to initialize `vis`.

You may also install it in Lua's path.
See documentation about the [`require` function](https://www.lua.org/pil/8.1.html).

If the backup plugin is found in another directory, add the path:

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

To configure this module, you may modify the `backup` table, for example:

```lua
backup = require('backup')
backup.byte_limit = 500000
backup.set_directory(getenv('HOME') .. '/.cache/vis-bak')
```

See [Vis' plugins documentation](https://github.com/martanne/vis/wiki/Plugins).

# Configuring backup path and backup filenames

To change where vis writes backups, modify the string
`backup.directory` and the function `backup.get_fname(backup_dir, filepath)`.

Default configuration:

```lua
backup.directory = os.getenv('HOME') .. '/.vis-backups' 
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
