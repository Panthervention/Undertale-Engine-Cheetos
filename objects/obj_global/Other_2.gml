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

audio_master_gain(0.25);
