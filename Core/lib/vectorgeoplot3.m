function vectorgeoplot3(g,lla0, v, varargin)
llapos = enu2lla(v', lla0, "flat");
geoplot3(g, llapos(:,1), llapos(:,2), llapos(:,3), varargin{:})


end