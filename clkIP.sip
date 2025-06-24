set_global_assignment -entity "clkIP" -library "lib_clkIP" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "clkIP" -library "lib_clkIP" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "clkIP" -library "lib_clkIP" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_clkIP" -name SPD_FILE [file join $::quartus(sip_path) "clkIP.spd"]

set_global_assignment -library "lib_clkIP" -name MISC_FILE [file join $::quartus(sip_path) "clkIP_sim/clkIP.vo"]
