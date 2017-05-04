function [srcdir foldernames n] =  folderList(path)
% After heavily tested, this file should be moved into my toolbox/matlab
% [srcdir foldernames n] =  folderList(path)

listing = dir(path);
idxvalid = cellfun(@(x) strcmp(x(1),'.'),{listing.name});
listing = listing(~idxvalid);
% listing = listing(3:end);
srcdir = path;

n = 0;  foldernames = [];
for i = 1 : length(listing)
    if listing(i).isdir
        n = n + 1;
        foldernames = cat(1, foldernames, {listing(i).name});
    end
end