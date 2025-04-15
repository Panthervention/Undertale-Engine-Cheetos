Input_Uninit()
Dialog_Uninit();
Flag_Uninit();
Encounter_Uninit();

var _i = 0; while (time_source_exists(_i))
	time_source_destroy(_i++); 
		
delete camera;
delete border;
