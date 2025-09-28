#macro __CHEETOS_ENGINE_DATE		"29/09/2025"
#macro __CHEETOS_ENGINE_VERSION		"v1.2.1"

#macro __CHEETOS_GAME_NAME			"UNDERTALE ENGINE"
#macro __CHEETOS_GAME_AUTHOR		"Cheetos"
#macro __CHEETOS_GAME_VERSION		"v1.0.0"

#macro __CHEETOS_ALLOW_DEBUG		true

// This automatically set DEBUG to <false> when you build the game
#macro __CHEETOS_DEBUG !game_is_standalone()
#macro __CHEETOS_RELEASE !__CHEETOS_DEBUG