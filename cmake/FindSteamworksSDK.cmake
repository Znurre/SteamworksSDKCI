include(FindPackageHandleStandardArgs)

if (NOT SteamworksSDK_FOUND)
	find_library(
		SteamworksSDK_LIBRARY
		steam_api
		steam_api64
		PATH_SUFFIXES
		lib/steam
		vendor/lib/steam
	)

	find_path(
		SteamworksSDK_INCLUDE_DIR
		steam
		PATH_SUFFIXES
		include
		vendor/include
	)

	add_library(SteamworksSDK::SteamworksSDK SHARED IMPORTED)

	set_target_properties(SteamworksSDK::SteamworksSDK PROPERTIES
		INTERFACE_INCLUDE_DIRECTORIES "${SteamworksSDK_INCLUDE_DIR}"
	)

 	if(WIN32)
		find_file(SteamworksSDK_DLL
	    	NAMES steam_api64.dll
		)
 
    	set_target_properties(SteamworksSDK::SteamworksSDK PROPERTIES
        	IMPORTED_IMPLIB "${SteamworksSDK_LIBRARY}"
			IMPORTED_LOCATION "${SteamworksSDK_DLL}"
    	)
	else()
    	set_target_properties(SteamworksSDK::SteamworksSDK PROPERTIES
			IMPORTED_LOCATION "${SteamworksSDK_LIBRARY}"
    	)
 	endif()

	#-----------------------------------------

	find_library(
		SteamworksSDK_AppTicket_LIBRARY
		sdkencryptedappticket
		sdkencryptedappticket64
		PATH_SUFFIXES
		lib/steam
		vendor/lib/steam
	)

	add_library(SteamworksSDK::AppTicket STATIC IMPORTED)

	set_target_properties(
		SteamworksSDK::AppTicket
		PROPERTIES
		IMPORTED_LOCATION
		"${SteamworksSDK_AppTicket_LIBRARY}"
	)

	#-----------------------------------------

	find_package_handle_standard_args(SteamworksSDK DEFAULT_MSG SteamworksSDK_LIBRARY SteamworksSDK_AppTicket_LIBRARY SteamworksSDK_INCLUDE_DIR)
endif()
