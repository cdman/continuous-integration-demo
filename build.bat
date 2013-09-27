C:\Users\cdman\Documents\nuget.exe install CDDemo\packages.config -OutputDirectory packages
rmdir /S /Q CDDemo\bin
C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild.exe CDDemo.sln /p:Configuration=Debug
