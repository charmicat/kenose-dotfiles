-- ~/.config/conky/lib/util.lua
local M = {}

function M.merge(a, b)
  if type(a) == "table" and type(b) == "table" then
    for k, v in pairs(b) do
      if type(v) == "table" and type(a[k]) == "table" then
        M.merge(a[k], v)
      else
        a[k] = v
      end
    end
  end
  return a
end

function M.deepcopy(t)
  if type(t) ~= "table" then return t end
  local out = {}
  for k, v in pairs(t) do out[k] = M.deepcopy(v) end
  return out
end

function M.is_wayland()
  local session = os.getenv("XDG_SESSION_TYPE")
  return (session == "wayland") or (os.getenv("WAYLAND_DISPLAY") ~= nil)
end

return M
