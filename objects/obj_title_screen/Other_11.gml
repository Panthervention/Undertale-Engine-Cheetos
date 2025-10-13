///@desc Name Check
var _name = string_lower(__naming_name),
	_text = (lexicon_text($"menu.confirm.title.{_name}") != $"Missing text entry: \"menu.confirm.title.{_name}\"") ? lexicon_text($"menu.confirm.title.{_name}") : lexicon_text("menu.confirm.title.default"),
	_valid = true;

switch (_name)
{
	case "alphys":
	case "asgore":
	case "toriel":
	case "asriel":
	case "flowey":
	case "sans":
	case "undyne":
		_valid = false;
		break;
}

__confirm_title = _text;
__confirm_valid = _valid;

// Feather ignore once GM2016
__menu_label_confirm_title = scribble(__confirm_title).starting_format("font_dt_sans", c_white).transform(2, 2, 0);
__menu_label_confirm_title.build(true);
