# vis-backup

A vis plugin that makes backups of current files before saving.

Writes backups to `~/.vis-backups`.
This backup folder must exist and you need permissions to write to it.

Change the variable `backup.directory` to save backups to a different directory.
See below for configuation examples.

# Installing

Copy `backup.lua` to somewhere `visrc.lua` can load it, then add
this line to your `visrc.lua`:

```
backup = require('backup')
```

To configure this module, you may modify the `backup` table, for example:

```
backup = require('backup')
backup.byte_limit = 500000
backup.directory = os.getenv("HOME") .. "/.cache/vis-bak"
```

See [Vis' plugins documentation](https://github.com/martanne/vis/wiki/Plugins).

# Configuring backup path and backup filenames

To change where vis writes backups, modify the string
`backup.directory` and the function `backup.get_fname(backup_dir, filepath)`.

Default configuration:

```
backup.directory = os.getenv("HOME") .. "/.vis-backups" 
backup.get_fname = backup.entire_path_with_double_percentage_signs
backup.time_format = "%H-%M-"
-- 1MB
backup.byte_limit = 1000000
```

## Save to another directory (with timestamp)

Add this to your `visrc.lua`:

```
backup.get_fname = backup.entire_path_with_double_percentage_signs_and_timestamp
```

## Save to current directory with a tilde at the end (Emacs/Vim style)

Add this to your `visrc.lua`:

```
backup.get_fname = function(_, filepath)
  return filepath .. "~"
end
```

This should write a copy of your file to `filename~` before saving it. 

# Configuring size limit

Files longer than `backup.byte_limit` bytes are not backed up.
Default is 1MB.
