randomize();

#region		Localization Initialize
lexicon_index_definitions("./locale/definitions.json");
lexicon_language_set("English");
lexicon_index_fallback_language_set("English");
#endregion

Input_Init();
Flag_Init();
Encounter_Init();
Dialog_Init();

application_surface_draw_enable(false);

texturegroup_set_mode(true, false, spr_fallback_default);

//show_debug_overlay(true);

alarm[1] = 1;

gml_pragma("PNGCrush");
gml_release_mode(released);

game_set_speed(60, gamespeed_fps);

#region Loading settings
Flag_Load(FLAG_TYPE.SETTINGS);

var _volume = Flag_Get(FLAG_TYPE.SETTINGS, FLAG_SETTINGS.LANGUAGE, 100) / 100,
	_border = Flag_Get(FLAG_TYPE.SETTINGS, FLAG_SETTINGS.BORDER);

audio_master_gain(_volume);

Border_SetEnabled(_border != 0, _border == 2);
// feather ignore once GM1063
// -1 is the empty version of Asset
Border_SetSprite(_border == 2 ? -1 : spr_border, _border == 3 ? 2 : (_border > 4 ? _border + 4 : 0));
#endregion

