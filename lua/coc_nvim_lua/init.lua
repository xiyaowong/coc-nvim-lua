local doc = require("coc_nvim_lua.doc")

local regex = vim.regex("\\%(\\.\\|\\w\\)\\+$")

local function collect(paths)
  local target = _G
  local target_keys = vim.tbl_keys(_G)

  local this_doc = vim.deepcopy(doc)

  for _, path in ipairs(paths) do
    if vim.tbl_contains(target_keys, path) and type(target[path]) == "table" then
      this_doc = this_doc[path]
      if type(this_doc) ~= "table" then
        this_doc = {}
      end

      target = target[path]
      target_keys = vim.tbl_keys(target)
    elseif path ~= "" then
      return {}
    end
  end

  local candidates = {}
  for _, key in ipairs(target_keys) do
    local info = this_doc[key] or ""
    if type(info) == "table" then
      info = ""
    end

    table.insert(candidates, { word = key, kind = type(target[key]), info = info })
  end

  return candidates
end

local function complete(opt)
  local candidates = {}

  local line = opt.line:sub(0, opt.col) .. opt.input
  local str, _ = regex:match_str(line)
  if str then
    local prefix = line
    prefix = prefix:sub(str + 1)
    prefix = prefix:gsub("[^.]*$", "")
    candidates = collect(vim.split(prefix, ".", true))
  end

  return candidates
end

return { complete = complete }
