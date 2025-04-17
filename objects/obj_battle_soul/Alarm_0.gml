///@desc After Effect
audio_play_sound(snd_ding, 1, false);
part_type_orientation(__after_effect_type, after_effect_angle, after_effect_angle, 0, 0, 0);
part_particles_create_color(__after_effect_system, x, y, __after_effect_type, image_blend, 1);
