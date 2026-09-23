function outpath = step2json(filepath, outpath)
    if ~exist("outpath", "var");outpath = replace(filepath, ".step", "/");end
    path = char(erase(string(mfilename("fullpath")), "step2json"));
    system(['cd /d "',path,'" &&','step2json.bat ','"',  char(filepath), '"  "',  char(outpath), '"'])

end