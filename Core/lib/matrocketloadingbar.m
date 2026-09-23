function [l,f] = matrocketloadingbar(message)
path = replace(mfilename("fullpath"), "\lib\matrocketloadingbar","\MatRocketUI\Logos\MatRocket_logo2 transparent.png");
if ~exist("message", "var"); message = "Loading..."; end

f = uifigure("Icon",path, "Name",message);
l = uiprogressdlg(f, 'Indeterminate','on', "Icon",path);



end