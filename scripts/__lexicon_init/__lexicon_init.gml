#macro __LEXICON_STRUCT (__lexicon_init())
#macro __LEXICON_VERSION "3.0.8"
#macro __LEXICON_CREDITS "@TabularElf - https://tabelf.link/"

// Setup Lexicon well before anything else

// Init Lexicon

__lexicon_init();

/// @ignore
/// feather ignore all
function __lexicon_init() {
	static _inst =  undefined;
	if (_inst == undefined) {
		_inst = {
			languageMap: {},
			localeMap: {},
			fallbackLocaleMap: {},
			fallbackLanguage: "",
			forceLoadFile: false,
			textEntries: {},
			textEntriesArray: {},
			language: "unknown",
			locale: "unknown",
			isReady: false,
			replaceChrLegacy: "%s",
            jsonData: undefined,
			replaceChr: __LEXICON_STRUCT_REPLACE_CHR_SYMBOLS,
			fileAsyncList: [],
			cacheUpdate: true,
			cacheMap: ds_map_create(),
			cacheList: ds_list_create(),
			//langDB: __lexicon_localization_map_init()[$ lexicon_get_os_locale()] ?? __lexicon_localization_map_init()[$ "en"],
			dateTimeFunc: undefined,
			dateLength: lexicon_length.FULL,
			timeLength: lexicon_length.FULL,
			frame: 0,
			dynamicMap: {},
			hashAvailable: true
		}
		
		// Check if hash is available
		try {
            // Prevents GM from just optimizing this out.
            // Which is weird, but for genuine valid reasons!
            var _key = "foo";
			variable_get_hash(_key);	
		} catch(_) {
			_inst.hashAvailable = false;	
		}
		
		
		time_source_start(time_source_create(time_source_global, 1, time_source_units_frames, method(undefined, __lexicon_gc_cache), [], -1));
	}
	
	return _inst;
}

__lexicon_trace("v" + __LEXICON_VERSION + " initialized! Created by " + __LEXICON_CREDITS);