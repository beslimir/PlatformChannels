cmake_minimum_required(VERSION 3.4.1)

add_library(#Setsthenameofthelibrary.
        platformTest

        #Setsthelibraryasasharedlibrary.
        SHARED

        #Providesarelativepathtoyoursourcefile(s).
        src/main/cpp/platformTest.cpp)