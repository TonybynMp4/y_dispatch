---@class vehicleOptions
---@field model? boolean
---@field class? boolean
---@field color? boolean
---@field plate? boolean
---@field doors? boolean
---@field speed? boolean

---@class weaponOptions
---@field weaponName? boolean
---@field weaponclass? boolean

---@class personOptions
---@field callsign? boolean
---@field name? boolean
---@field gender? boolean
---@field phone? boolean

---@class dispatchCallDetails
---@field distance? boolean
---@field heading? boolean
---@field location? boolean
---@field camId? boolean
---@field weapon? weaponOptions
---@field vehicle? vehicleOptions
---@field person personOptions
---@field information? boolean

---@class dispatchCallJobs
---@field jobs string[]
---@field types string[]

---@class dispatchCallBlipOffset
---@field min integer
---@field max integer

---@class jobCallBlipOffset
---@field x integer
---@field y integer

---@class dispatchCallBlipRadius
---@field radius integer
---@field Color integer

---@class dispatchCallBlip
---@field radius? dispatchCallBlipRadius
---@field sprite? integer
---@field color? integer
---@field scale? number
---@field length? number
---@field offset? dispatchCallBlipOffset
---@field flash? boolean

---@class jobCallBlip : dispatchCallBlip
---@field offset? jobCallBlipOffset

---@class dispatchCallSound
---@field ref string
---@field name string
---@field playOnPed boolean

---@class jobCallData
--- @field code string
--- @field title string
--- @field description string
--- @field blip? jobCallBlip
--- @field sound? dispatchCallSound
--- @field details dispatchCallDetails

--- @class tempCallData : jobCallData
--- @field blip? dispatchCallBlip

---@class jobCall
---@field source integer
---@field internalId integer Id used to identify the call no matter what job it's in
---@field time integer
---@field data jobCallData
---@field unitsIgnoring integer[]


--- @class dispatchCall : jobCallData
--- @field jobs dispatchCallJobs | string[]
--- @field blip dispatchCallBlip
