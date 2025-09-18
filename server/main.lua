AddEventHandler("weaponDamageEvent", function(id, args)
    print(json.encode(args))
    local user = id
end)