//
/*
  Pet base AI
  by Nautical
*/

ENT.Base = "base_nextbot"
ENT.Spawnable = true

function ENT:SetupDataTables()

  self:NetworkVar("String", 0, "DisplayName");
end

function string.FormatName(name)

  local ex = string.Explode(" ", name)

  for k,v in next,ex do

    local arr = string.Explode("", v)
    arr[1] = string.upper(arr[1])

    ex[k] = string.Implode("", arr)
  end

  return string.Implode(" ", ex)
end
