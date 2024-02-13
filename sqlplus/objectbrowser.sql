local ats, nFileSets;
local objRepos, objReposCollection, objFileSet;
local objFileSetsCollection, arcId, FSsize, FSPath, FSNum;
local ActFileSet;
local num int;
local path char(100);
local loop integer;
local fnum integer;
local checkIfLess int;
local warning int;
local result real;
result = 0;
warning = 3;
ats = createobject('Aspen.IP21.AtIP21HistAdmin');
objReposCollection = ats.getRepositoriesCollection;
write 'Check all repos and filsets. If number of (filsets - acitve)';
write 'If number less than our warning -> or equal to '||warning||'. Then we need more filsets';
write ' - - - - - - - - - - ';
for each objRepos in objReposCollection do
      objFileSetsCollection = objRepos.GetFilesetsCollection;
      nFileSets = objFileSetsCollection.count;
	num = ats.GetSingleRepository(objRepos).NumberOfFilesets;
	--
	--write objRepos||'; Number of fileset;'||nFileSets;

	--
	for loop = 1 to num do
		
    	path = ats.GetSingleRepository(objRepos).GetSingleFileSet(loop).FilesetFilePath;
	fnum = ats.GetSingleRepository(objRepos).GetSingleFileSet(loop).FilesetNumber;
	ActFileSet = ats.GetSingleRepository(objRepos).GetCurrentFileset.FilesetNumber;
	--write loop;
	--write 'Path'||';'||path||'; Fileset num ;'||fnum;;
	end
	--get repso, amount of fileset, active
	checkIfLess = fnum - ActFileSet;
	if(checkIfLess <= warning) then
	write 'Warning!!-> Need more filsets; '||objRepos||' ;'||num||' ;Active; '||ActFileSet||'; Left ;'||(num - ActFileSet);
	result = result + (num - ActFileSet);
	else
	write objRepos||' ; Num of filesets; '||num||' ;Active; '||ActFileSet;
	end
	

end
write 'We need a total of '||result||' new filsets';
