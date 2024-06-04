if (text != "")
    event_inherited();

Player_Heal(Player_GetHpMax());
audio_play_sound(snd_item_heal, 0, false);

instance_create_depth(0, 0, 0, obj_ui_save);
