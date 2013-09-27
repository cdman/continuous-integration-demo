set /P version=<version.txt

"C:\Program Files\NuGet\nuget.exe" install CDDemo\packages.config -OutputDirectory packages
rmdir /S /Q CDDemo\bin
C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild.exe CDDemo.sln /p:Configuration=Debug

rmdir /S /Q .sonar
copy sonar-project.properties.template sonar-project.properties
echo "sonar.projectVersion=%version%" >> sonar-project.properties
call "C:\Program Files\sonar-runner-2.3\bin\sonar-runner.bat"
rmdir /S /Q .sonar
del sonar-project.properties