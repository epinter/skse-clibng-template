# ***Template Project for SKSE - CommonLibSSE-NG***

## ***Runtime requirements***

- [Skyrim Script Extender (SKSE)](https://skse.silverlock.org/)
- [Address Library for SKSE Plugins](https://www.nexusmods.com/skyrimspecialedition/mods/32444)

## ***Build requirements***

- [CMake](https://cmake.org/)
- [vcpkg](https://vcpkg.io/en/)
- [Visual Studio Community 2022](https://visualstudio.microsoft.com/vs/community/)
- [CommonLibSSE-NG](https://github.com/CharmedBaryon/CommonLibSSE-NG)

## ***Building***

In `Developer Command Prompt for VS 2022` or `Developer PowerShell for VS 2022`, run:

~~~
git clone https://github.com/epinter/skse-clibng-template.git
cd skse-clibng-template
~~~

then

~~~
.\cmake\build.ps1
~~~

or

~~~
.\cmake\build.ps1 -buildType ALL-release -preset ALL
~~~

or

~~~
.\cmake\build.ps1 -buildType ALL-debug
~~~

or

~~~
cmake -B build -S . --preset ALL --fresh
cmake --build build --preset ALL-release
~~~

Then get the .dll in build/Release, or the .zip (ready to install using mod manager) in build.
