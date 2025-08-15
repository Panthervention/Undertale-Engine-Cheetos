///@desc Name Check 
var _text = "", _valid = true;
switch (string_lower(__naming_name))
{
	default:
		_text = lexicon_text("menu.confirm.title.default");
		break;
	case "aaaaaa":
		_text = lexicon_text("menu.confirm.title.aaaaaa");
		break;
	case "alphys":
		_text = lexicon_text("menu.confirm.title.alphys");
		_valid = false;
		break;
	case "alphy":
		_text = lexicon_text("menu.confirm.title.alphy");
		break;
	case "asgore":
		_text = lexicon_text("menu.confirm.title.asgore");
		_valid = false;
		break;
	case "toriel":
		_text = lexicon_text("menu.confirm.title.toriel");
		_valid = false;
		break;
	case "asriel":
		_text = lexicon_text("menu.confirm.title.asriel");
		_valid = false;
		break;
	case "flowey":
		_text = lexicon_text("menu.confirm.title.flowey");
		_valid = false;
		break;
	case "sans":
		_text = lexicon_text("menu.confirm.title.sans");
		_valid = false;
		break;
	case "papyru":
		_text = lexicon_text("menu.confirm.title.papyru");
		break;
	case "undyne":
		_text = lexicon_text("menu.confirm.title.undyne");
		_valid = false;
		break;
	case "mtt":
	case "metta":
	case "mett":
		_text = lexicon_text("menu.confirm.title.mtt");
		break;
	case "chara":
		_text = lexicon_text("menu.confirm.title.chara");
		break;
	case "frisk":
		_text = lexicon_text("menu.confirm.title.frisk");
		break;
}

__confirm_title = _text;
__confirm_valid = _valid;

// Feather ignore once GM2016
__menu_label_confirm_title = scribble(__confirm_title).starting_format("font_dt_sans", c_white).transform(2, 2, 0);
__menu_label_confirm_title.build(true);
