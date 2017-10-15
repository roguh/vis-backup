# vis-backup

A vis plugin that makes backups of current files before saving.

Writes backups to `~/.vis-backup`.
Change the variable `backup.directory` to save them to a different directory.

# Installing

Copy `backup.lua` to somewhere `visrc.lua` can load it, then add
this line to your `visrc.lua`:

```
backup = require('backup')
```

See [Vis' plugins documentation](https://github.com/martanne/vis/wiki/Plugins).

# Configuring Backup Path and Backup Filenames

To change where vis writes backups, modify the string
`backup.directory` and the function `backup.get_fname(backup_dir, filepath)`.

By default, `backup.directory` is set to `~/.vis-backup` and
`backup.get_fname` is set to `backup.entire_path`.

## Save to another directory (with timestamp)

Add this to your `visrc.lua`:

```
backup.get_fname = backup.entire_path_with_timestamp
```

## Save to current directory (Emacs/Vim style)

Add this to your `visrc.lua`:

```
backup.get_fname = function(_, filepath)
  return filepath .. "~"
end
```

This should write a copy of your file to `filename~` before saving it. 

## Do not create `backup.directory` on startup

Add this to your `visrc.lua`:

```
backup.mkdir = false
```
