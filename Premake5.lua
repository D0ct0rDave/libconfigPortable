-- Premake5.lua

workspace "libconfigPortable"
    configurations { "Debug", "Release" }
    location "build" -- Where generated files (like Visual Studio solutions) will be stored
    architecture "x86_64"

project "libconfigPortable"
    kind "StaticLib" -- Change to "SharedLib" for a shared library
    language "C++"
    cppdialect "C++17"
    targetdir "$(ProjectDir)/../lib/x64/%{cfg.buildcfg}" -- Output directory for binaries
    objdir "$(ProjectDir)obj/x64/%{cfg.buildcfg}" -- Output directory for intermediate files
	characterset("ASCII")
	sourceDir = "$(ProjectDir)../src"

	-- Specify the root directory of the library
    local sourceRoot = os.getcwd() .. "/src"

    -- Recursively include all .cpp and .h files from the sourceRoot directory
    files {
        sourceRoot .. "/**.c",
        sourceRoot .. "/**.h"
    }

	-- specific defines for this project
	defines {
		"_MBCS" ,
	}
	
	filter { "system:windows" }
		defines { "WIN32" }
	filter {} -- Reset filter

    -- Add include directories (sourceRoot is included by default)
    includedirs {
		"$(ProjectDir)../src",
    }

    -- Configuration-specific settings
    filter "configurations:Debug"
        defines { "DEBUG" }
        symbols "On" -- Generate debug symbols

    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "On" -- Enable optimizations

	filter {} -- Clear filter for general settings

    -- List of directories to exclude from recursion
    local excludeDirs = { 
        "build",
    }
	
	includeDir = sourceDir .. "/../include"
