function version=checkVersion()

load('_version\_version.mat');

S = dbstack();
if(~system('svn info -rHEAD | find "Last Changed Rev"') && strcmp(S(1).file, 'checkVersion.m'))
    system('svn info -rHEAD | find "Last Changed Rev" > _version\_revision');
    
    fileID = fopen('_version\_version');
    v = textscan(fileID, '%s %s');
    fclose(fileID);
    
    fileID = fopen('_version\_revision');
    r = textscan(fileID, '%s %s %s %s');
    fclose(fileID);
    
    ver.Maj = v{1,2}{1,1};
    ver.Min = v{1,2}{2,1};
    ver.Rev = char(r{1,4});
    
    save('_version\_version.mat', 'ver');
end
version=ver

end %end of function