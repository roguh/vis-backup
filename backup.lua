local backup = {}


-- Return the backup path concatenated with the filename, replace / with %
backup.entire_path_with_double_percentage_signs = function(backup_dir, path)
  return backup_dir .. "/" .. string.gsub(path, "/", "%%")
end


-- Return the backup path concatenated with the filename, replace / with %
-- and append the current time using time_format
backup.entire_path_with_double_percentage_signs_and_timestamp = function(backup_dir, path)
  return backup_dir .. "/" .. os.date(backup.time_format) .. string.gsub(path, "/", "%%")
end

-- Before saving the file, copy the current contents of the file to a backup file
vis.events.subscribe(vis.events.FILE_SAVE_PRE, function (file, path)
  if file.size > backup.byte_limit then
    return
  end

  -- E.g. when editing stdin as an interactive filter
  -- `vis -`
  if path == nil then
    return
  end

  local backup_path = backup.get_fname(backup.directory, path)
  
  local backup_file = io.open(backup_path, "w")
  local current_file = io.open(path)
  if backup_file == nil or current_file == nil then 
    return
  end

  for line in current_file:lines() do
    backup_file:write(line .. "\n")
  end
  
  backup_file:close()
end)

backup.create_directory = function()
  os.execute('mkdir -p ' .. backup.directory)
end

backup.set_directory = function(new_value)
  backup.directory = new_value
  backup.create_directory()
end


-- Set defaults
backup.directory = os.getenv("HOME") .. "/.vis-backups" 

backup.get_fname = backup.entire_path_with_double_percentage_signs

backup.time_format = "%H-%M-"

-- Do not make backups if the file is greater than this
-- 1MB by default
backup.byte_limit = 1000000


return backup
