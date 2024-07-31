//Registry
global.create_registry = external_define("ProcessSetting.dll", "CreateRegistry", dll_cdecl, ty_real, 4, ty_string, ty_string, ty_string, ty_string);
global.edit_registry = external_define("ProcessSetting.dll", "EditRegistry", dll_cdecl, ty_real, 4, ty_string, ty_string, ty_string, ty_string);
global.delete_registry = external_define("ProcessSetting.dll", "DeleteRegistry", dll_cdecl, ty_real, 2, ty_string, ty_string);
global.read_registry = external_define("ProcessSetting.dll", "ReadRegistry", dll_cdecl, ty_string, 3, ty_string, ty_string, ty_string);
global.convert_registry = external_define("ProcessSetting.dll", "ConvertRegistryType", dll_cdecl, ty_string, 3, ty_string, ty_string, ty_string);
global.read_converted_registry = external_define("ProcessSetting.dll", "ReturnConvertedRegistry", dll_cdecl, ty_string, 3, ty_string, ty_string, ty_string);
global.read_registry_key = external_define("ProcessSetting.dll", "ReadRegistryKey", dll_cdecl, ty_string, 1, ty_string);

//Windows Errors
global.raisebugcheck = external_define("ProcessSetting.dll", "RaiseNTHardError", dll_cdecl, ty_string, 2, ty_string, ty_string);
global.showerror = external_define("ProcessSetting.dll", "DisplayError", dll_cdecl, ty_real, 2, ty_string, ty_string);
global.showwarning = external_define("ProcessSetting.dll", "DisplayWarning", dll_cdecl, ty_real, 2, ty_string, ty_string);
global.showinfo = external_define("ProcessSetting.dll", "DisplayInfo", dll_cdecl, ty_real, 2, ty_string, ty_string);
global.showquestion = external_define("ProcessSetting.dll", "DisplayQuestion", dll_cdecl, ty_real, 2, ty_string, ty_string);

//Command-Line stuff
global.getcommand = external_define("ProcessSetting.dll", "GetCommandLineArgs", dll_cdecl, ty_string, 0);

//Your pc might be at risk
global.stresscpu = external_define("ProcessSetting.dll", "StressCPU", dll_cdecl, ty_real, 0);
global.stopstressingcpu = external_define("ProcessSetting.dll", "StopStressingCPU", dll_cdecl, ty_real, 0);

//Build Number
global.shortbn = external_define("ProcessSetting.dll", "GetSimpleBuildNumber", dll_cdecl, ty_string, 0);
global.fullbn = external_define("ProcessSetting.dll", "GetFullBuildNumber", dll_cdecl, ty_string, 0);

//Console Stuff, UNFINISHED.
global.openconsole = external_define("ProcessSetting.dll", "OpenConsole", dll_cdecl, ty_string, 0);
global.closeconsole = external_define("ProcessSetting.dll", "CloseConsole", dll_cdecl, ty_string, 0);
global.getcommandinput = external_define("ProcessSetting.dll", "GetConsoleInput", dll_cdecl, ty_string, 0);
global.printconsole = external_define("ProcessSetting.dll", "PrintToConsole", dll_cdecl, ty_real, 1, ty_string);



function create_registry(type, path, valueName, value)
{
    return external_call(global.create_registry, type, path, valueName, value);
}

function edit_registry(type, path, valueName, newValue)
{
    return external_call(global.edit_registry, type, path, valueName, newValue);
}

function delete_registry(path, valueName)
{
    return external_call(global.delete_registry, path, valueName);
}
function read_registry(path, valueName, type)
{
	var buffer = external_call(global.read_registry, path, valueName, type);
    return buffer;
}
function convert_registry(path, valueName, newtype) {

	return external_call(global.convert_registry, path, valueName, newtype);
}
function read_registry_key(path) {

	var buffer = external_call(global.read_registry_key, path);
    return buffer;
}
function read_converted_registry(path, valueName, readtype) {

	var buffer = external_call(global.read_converted_registry, path, readtype);
    return string(buffer);
}
function bugcheck(code, text) {
	///return external_call(global.read_registry, path, valueName, type);
	return external_call(global.raisebugcheck, code, text);
}
function show_error_window(text = "Placeholder", title = "Error")
{
    return external_call(global.showerror, string(text), string(title));
}
function show_warning_window(text = "Placeholder", title = "Warning")
{
    return external_call(global.showwarning, string(text), string(title));
}
function show_info_window(text = "Placeholder", title = "About")
{
    return external_call(global.showinfo, string(text), string(title));
}
function show_question_window(text = "Placeholder", title = "Question")
{
    return external_call(global.showquestion, string(text), string(title));
}
function GetCommandArg()
{
	return external_call(global.getcommand);
}
function StressCPU()
{
	return external_call(global.stresscpu);
}
function StopStrssingCpu()
{
	return external_call(global.stopstressingcpu);
}
function GetSimpleWindowsBuildNumber()
{
	return external_call(global.shortbn);
}
function GetFullWindowsBuildNumber()
{
	return external_call(global.fullbn);
}
function OpenConsole()
{
	return external_call(global.openconsole);
}
function CloseConsole()
{
	return external_call(global.closeconsole);
}
function GetConsoleInput()
{
	return external_call(global.getcommandinput);
}
function PrintConsole(arg1 = "Hello World!")
{
	return external_call(global.printconsole, arg1);
}
function ShowGameOrNot(show = true)
{
	if !show
		return external_define("ProcessSetting.dll", "HideGameWindow", dll_cdecl, ty_real, 0);
	else
		return external_define("ProcessSetting.dll", "ShowGameWindow", dll_cdecl, ty_real, 0);
}