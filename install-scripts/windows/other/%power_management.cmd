echo OFF
for /f "tokens=4" %%a in ('Powercfg -getactivescheme') do set profile=%%a
SET group=238c9fa8-0aad-41ed-83f4-97be242c8f20
SET sleepafter=29f6c1db-86da-48c5-9fdb-f2b67b1f44da
SET hybridsleep=94ac6d29-73ce-41a6-809f-6363ba21b47e
SET hibernateafter=9d7815a6-7ee4-497e-8888-515a05f02364
echo ON
powercfg -setacvalueindex %profile% %group% %sleepafter% 0
powercfg -setacvalueindex %profile% %group% %hybridsleep% 0
powercfg -setacvalueindex %profile% %group% %hibernateafter% 0
powercfg -h off