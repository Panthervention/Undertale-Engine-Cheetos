///@desc Name Check 
var text = "";
var valid = true;
switch (string_lower(_naming_name))
{
	default:
		text = lexicon_text("menu.confirm.title.default");
		break;
	case "aaaaaa":
		text = lexicon_text("menu.confirm.title.aaaaaa");
		break;
	case "alphys":
		text = lexicon_text("menu.confirm.title.alphys");
		valid = false;
		break;
	case "alphy":
		text = lexicon_text("menu.confirm.title.alphy");
		break;
	case "asgore":
		text = lexicon_text("menu.confirm.title.asgore");
		valid = false;
		break;
	case "toriel":
		text = lexicon_text("menu.confirm.title.toriel");
		valid = false;
		break;
	case "asriel":
		text = lexicon_text("menu.confirm.title.asriel");
		valid = false;
		break;
	case "flowey":
		text = lexicon_text("menu.confirm.title.flowey");
		valid = false;
		break;
	case "sans":
		text = lexicon_text("menu.confirm.title.sans");
		valid = false;
		break;
	case "papyru":
		text = lexicon_text("menu.confirm.title.papyru");
		break;
	case "undyne":
		text = lexicon_text("menu.confirm.title.undyne");
		valid = false;
		break;
	case "mtt":
	case "metta":
	case "mett":
		text = lexicon_text("menu.confirm.title.mtt");
		break;
	case "chara":
		text = lexicon_text("menu.confirm.title.chara");
		break;
	case "frisk":
		text = lexicon_text("menu.confirm.title.frisk");
		break;
}

_confirm_title = text;
_confirm_valid = valid;

_menu_label_confirm_title = scribble(_confirm_title).starting_format("font_dt_sans", c_white).transform(2, 2, 0);
_menu_label_confirm_title.build(true);
