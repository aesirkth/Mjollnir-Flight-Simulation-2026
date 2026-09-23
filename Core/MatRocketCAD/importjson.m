function outobj = importjson(filepath)

outobj = jsondecode(fileread(filepath+"hierarchy.json"));
outobj.path = filepath;

end