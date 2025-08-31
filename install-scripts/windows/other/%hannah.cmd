
hostname > .hostname 
SET /p name= < .hostname
del .hostname
echo ON
WMIC computersystem where caption='%name%' rename Hannah