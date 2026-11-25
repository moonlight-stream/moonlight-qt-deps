rem Add Strawberry Perl to PATH (Git's Perl won't work)
set PATH=C:\Strawberry\perl\bin;%PATH%

cd ..\openssl || exit /b 1

rem Build OpenSSL
mkdir ..\build\openssl\build_%1
perl Configure --config=..\openssl-configs\moonlight-win.conf --prefix=%CD%\..\build\openssl\build_%1 --openssldir=%CD%\..\build\openssl\build_%1 %2 no-tests no-engine no-apps no-legacy no-dso || exit /b 1
jom || exit /b 1
nmake install_sw || exit /b 1

rem Clean up in-tree build
git reset --hard || exit /b 1
git clean -f -d -x -e NUL || exit /b 1