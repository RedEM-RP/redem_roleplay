Citizen.CreateThread(function()
	TriggerEvent("chat:addSuggestion", "/listitems", "List all items in the inventory system (staff)", {})

	TriggerEvent("chat:addSuggestion", "/lookupitem", "Look up an item in the inventory system (staff)", {
		{name = "Partial Name", help = "The partial name of an item"}
	})

	TriggerEvent("chat:addSuggestion", "/giveitem", "Give an item or items to a player (staff)", {
		{name = "Player ID", help = "The ID of the player"},
		{name = "Item Name", help = "The item to give"},
		{name = "Amount", help = "Amount of the item to give"}
	})

    TriggerEvent("chat:addSuggestion", "/removeitem", "Remove an item or items from a player (staff)", {
		{name = "Player ID", help = "The ID of the player"},
		{name = "Item Name", help = "The item to remove"},
		{name = "Amount", help = "Amount of the item to remove"}
	})

    TriggerEvent("chat:addSuggestion", "/tp", "Teleport to a player (staff)", {
		{name = "Player ID / X", help = "The ID of the player, or X coordinate"},
		{name = "Y", help = "Y coordinate"},
		{name = "Z", help = "Z coordinate"}
	})
	
    TriggerEvent("chat:addSuggestion", "/goto", "Teleport to a player (staff)", {
		{name = "Player ID / X", help = "The ID of the player, or X coordinate"},
		{name = "Y", help = "Y coordinate"},
		{name = "Z", help = "Z coordinate"}
	})
    TriggerEvent("chat:addSuggestion", "/bring", "Bring a player to you (staff)", {
		{name = "Player ID", help = "The ID of the player"}
	})
	TriggerEvent("chat:addSuggestion", "/trash", "Open a trash (staff)", {})

    TriggerEvent("chat:addSuggestion", "/tpm", "Teleport to marker (staff)", {})

	TriggerEvent("chat:addSuggestion", "/invis", "Toggle invisibility (staff)", {})

    TriggerEvent("chat:addSuggestion", "/announce", "Send a chat message to all players (staff)", {
		{name = "Message", help = "The message to send"}
	})
    TriggerEvent("chat:addSuggestion", "/kick", "Kick a player from the server (staff)", {
		{name = "Player ID", help = "The ID of the player"},
		{name = "Reason", help = "Reason for the kick"}
	})
	TriggerEvent("chat:addSuggestion", "/ban", "Ban a player from the server (staff)", {
		{name = "Player ID", help = "The ID of the player"},
		{name = "Hours", help = "Amount of hours for the ban (99999 for permanent)"},
		{name = "Reason", help = "Reason for the ban"}
	})
	TriggerEvent("chat:addSuggestion", "/openinv", "Open a player's inventory (staff)", {
		{name = "Player ID", help = "The ID of the player"}
	})
	TriggerEvent("chat:addSuggestion", "/spec", "Spectate a player (staff)", {
		{name = "Player ID / off", help = "The ID of the player, or off to stop spectating"}
	})
	TriggerEvent("chat:addSuggestion", "/floadskin", "Force-load a player's skin (staff)", {
		{name = "Player ID", help = "Force load a player's skin"}
	})

	TriggerEvent("chat:addSuggestion", "/bills", "View and pay your bills", {})
	TriggerEvent("chat:addSuggestion", "/bill", "Bill a player for an item or service", {
		{name = "Player ID", help = "The player to bill"}
	})

	TriggerEvent("chat:addSuggestion", "/checkbills", "See if a player has paid their bills", {
		{name = "Player ID", help = "The player to check"}
	})

	TriggerEvent("chat:addSuggestion", "/fine", "Fine a player (police)", {
		{name = "Player ID", help = "The player to fine"},
		{name = "Amount", help = "Amount of the fine"}
	})
	
	TriggerEvent("chat:addSuggestion", "/openstash", "Open a stash (staff)", {
		{name = "Stash ID", help = "The stash ID to open"}
	})

	TriggerEvent("chat:addSuggestion", "/balances", "View a player's money (staff)", {
		{name = "Player ID", help = "The player to check"}
	})

	TriggerEvent("chat:addSuggestion", "/steamid", "View a player's steamid (staff)", {
		{name = "Player ID", help = "The player to check"}
	})

	TriggerEvent("chat:addSuggestion", "/pedscale", "Set your ped scale (staff)", {
		{name = "Scale Factor", help = "The scale to set (0.2-2.0)"}
	})

	TriggerEvent("chat:addSuggestion", "/pedmodel", "Set your ped model (staff)", {
		{name = "Model Name", help = "The model to set (be careful with this!)"}
	})

	TriggerEvent("chat:addSuggestion", "/report", "Send a report to server Staff", {
		{name = "Message", help = "The report message to send to staff (be descriptive)"}
	})

	TriggerEvent("chat:addSuggestion", "/setmoney", "Set a player's money (staff)", {
		{name = "Player ID", help = "The player's Server ID"},
		{name = "Amount", help = "The amount of money to set"},
	})
	TriggerEvent("chat:addSuggestion", "/setjob", "Set a player's job (staff)", {
		{name = "Player ID", help = "The player's Server ID"},
		{name = "Job ID/Name", help = "The name of the job to set (script name)"},
		{name = "Rank ID", help = "The job rank to set"},
	})
	TriggerEvent("chat:addSuggestion", "/addmoney", "Give a player money (staff)", {
		{name = "Player ID", help = "The player's Server ID"},
		{name = "Amount", help = "The amount of money to add"},
	})
	TriggerEvent("chat:addSuggestion", "/addgold", "Give a player gold (staff)", {
		{name = "Player ID", help = "The player's Server ID"},
		{name = "Amount", help = "The amount of gold to add"},
	})
	TriggerEvent("chat:addSuggestion", "/addxp", "Give a player XP (staff)", {
		{name = "Player ID", help = "The player's Server ID"},
		{name = "Amount", help = "The amount of XP to add"},
	})
	TriggerEvent("chat:addSuggestion", "/setgroup", "Set a player's permission group (staff)", {
		{name = "Player ID", help = "The player's Server ID"},
		{name = "Group", help = "The group to set (user, admin, superadmin)"},
	})

	TriggerEvent("chat:addSuggestion", "/me", "3d Action Text", {
		{name = "Message", help = "The 3d message to be displayed on yourself"},
	})

end)

RegisterCommand("creator", function()
	TriggerEvent("rdr_creator:OpenCreator")
end)