function outlist = pop(list, index)
if index == 1
outlist = list(2:end);
elseif index == numel(list)
outlist = list(1:end-1);
else
outlist = [list(1:index-1), list(index+1:end)];
end

end