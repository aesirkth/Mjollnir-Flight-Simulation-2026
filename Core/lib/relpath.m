function p = relpath(targetPath, basePath)

    base   = java.io.File(basePath);
    target = java.io.File(targetPath);

    p = char(base.toURI().relativize(target.toURI()).getPath());
    p = strrep(p, '/', filesep);

end
