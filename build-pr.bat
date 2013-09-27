REM Save current state

git rev-parse --short HEAD > sha1.txt
set /P sha1=<sha1.txt
del sha1.txt
set /P version=<version.txt

REM First build the master as reference point

git checkout master
call :BUILD

REM Now build the actual PR

git checkout %sha1%
set version=%version%-%sha1%
call :BUILD

goto :EOF

:BUILD

"C:\Program Files\NuGet\nuget.exe" install CDDemo\packages.config -OutputDirectory packages
rmdir /S /Q CDDemo\bin
C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild.exe CDDemo.sln /p:Configuration=Debug

rmdir /S /Q .sonar
copy sonar-project.properties.template sonar-project.properties
echo sonar.branch=%sha1%>> sonar-project.properties
echo sonar.projectVersion=%version%>> sonar-project.properties
call "C:\Program Files\sonar-runner-2.3\bin\sonar-runner.bat"
rmdir /S /Q .sonar
del sonar-project.properties

:EOF
