T = readtable('urls.csv', 'TextType', 'string');
urls = T.(1);

tables = cell(numel(urls),1);

for k = 1:numel(urls)
    tables{k} = readtable(urls(k));   % download table
end

save('test.mat','tables');    % save for later