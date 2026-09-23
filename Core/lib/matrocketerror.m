function f = matrocketerror(message, f)

path = replace(mfilename("fullpath"), "\lib\matrocketerror","\MatRocketUI\Logos\IMG_7900.jpg");
if ~exist("message", "var"); message = "Error!"; end

if ~exist("f", "var");f = uifigure("Icon",path, "Name",message); end

uialert(f, message, "Error", "Icon", path);

end