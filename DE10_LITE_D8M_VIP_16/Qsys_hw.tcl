# _hw.tcl file for Qsys
package require -exact qsys 14.0

# module properties
set_module_property NAME {Qsys_export}
set_module_property DISPLAY_NAME {Qsys_export_display}

# default module properties
set_module_property VERSION {1.0}
set_module_property GROUP {default group}
set_module_property DESCRIPTION {default description}
set_module_property AUTHOR {author}

set_module_property COMPOSITION_CALLBACK compose
set_module_property opaque_address_map false

proc compose { } {
    # Instances and instance parameters
    # (disabled instances are intentionally culled)
    add_instance EEE_IMGPROC_0 EEE_IMGPROC 1.0

    add_instance EEE_IMGPROC_1 EEE_IMGPROC 1.0

    add_instance TERASIC_AUTO_FOCUS_0 TERASIC_AUTO_FOCUS 1.0
    set_instance_parameter_value TERASIC_AUTO_FOCUS_0 {VIDEO_W} {640}
    set_instance_parameter_value TERASIC_AUTO_FOCUS_0 {VIDEO_H} {480}

    add_instance TERASIC_CAMERA_0 TERASIC_CAMERA 1.0
    set_instance_parameter_value TERASIC_CAMERA_0 {VIDEO_W} {640}
    set_instance_parameter_value TERASIC_CAMERA_0 {VIDEO_H} {480}

    add_instance alt_vip_itc_0 alt_vip_itc 14.0
    set_instance_parameter_value alt_vip_itc_0 {NUMBER_OF_COLOUR_PLANES} {3}
    set_instance_parameter_value alt_vip_itc_0 {COLOUR_PLANES_ARE_IN_PARALLEL} {1}
    set_instance_parameter_value alt_vip_itc_0 {BPS} {8}
    set_instance_parameter_value alt_vip_itc_0 {INTERLACED} {0}
    set_instance_parameter_value alt_vip_itc_0 {H_ACTIVE_PIXELS} {640}
    set_instance_parameter_value alt_vip_itc_0 {V_ACTIVE_LINES} {480}
    set_instance_parameter_value alt_vip_itc_0 {ACCEPT_COLOURS_IN_SEQ} {0}
    set_instance_parameter_value alt_vip_itc_0 {FIFO_DEPTH} {640}
    set_instance_parameter_value alt_vip_itc_0 {CLOCKS_ARE_SAME} {0}
    set_instance_parameter_value alt_vip_itc_0 {USE_CONTROL} {0}
    set_instance_parameter_value alt_vip_itc_0 {NO_OF_MODES} {1}
    set_instance_parameter_value alt_vip_itc_0 {THRESHOLD} {639}
    set_instance_parameter_value alt_vip_itc_0 {STD_WIDTH} {1}
    set_instance_parameter_value alt_vip_itc_0 {GENERATE_SYNC} {0}
    set_instance_parameter_value alt_vip_itc_0 {USE_EMBEDDED_SYNCS} {0}
    set_instance_parameter_value alt_vip_itc_0 {AP_LINE} {0}
    set_instance_parameter_value alt_vip_itc_0 {V_BLANK} {0}
    set_instance_parameter_value alt_vip_itc_0 {H_BLANK} {0}
    set_instance_parameter_value alt_vip_itc_0 {H_SYNC_LENGTH} {96}
    set_instance_parameter_value alt_vip_itc_0 {H_FRONT_PORCH} {16}
    set_instance_parameter_value alt_vip_itc_0 {H_BACK_PORCH} {48}
    set_instance_parameter_value alt_vip_itc_0 {V_SYNC_LENGTH} {2}
    set_instance_parameter_value alt_vip_itc_0 {V_FRONT_PORCH} {10}
    set_instance_parameter_value alt_vip_itc_0 {V_BACK_PORCH} {33}
    set_instance_parameter_value alt_vip_itc_0 {F_RISING_EDGE} {0}
    set_instance_parameter_value alt_vip_itc_0 {F_FALLING_EDGE} {0}
    set_instance_parameter_value alt_vip_itc_0 {FIELD0_V_RISING_EDGE} {0}
    set_instance_parameter_value alt_vip_itc_0 {FIELD0_V_BLANK} {0}
    set_instance_parameter_value alt_vip_itc_0 {FIELD0_V_SYNC_LENGTH} {0}
    set_instance_parameter_value alt_vip_itc_0 {FIELD0_V_FRONT_PORCH} {0}
    set_instance_parameter_value alt_vip_itc_0 {FIELD0_V_BACK_PORCH} {0}
    set_instance_parameter_value alt_vip_itc_0 {ANC_LINE} {0}
    set_instance_parameter_value alt_vip_itc_0 {FIELD0_ANC_LINE} {0}

    add_instance alt_vip_vfb_0 alt_vip_vfb 13.1
    set_instance_parameter_value alt_vip_vfb_0 {PARAMETERISATION} {<frameBufferParams><VFB_NAME>MyFrameBuffer</VFB_NAME><VFB_MAX_WIDTH>640</VFB_MAX_WIDTH><VFB_MAX_HEIGHT>480</VFB_MAX_HEIGHT><VFB_BPS>8</VFB_BPS><VFB_CHANNELS_IN_SEQ>1</VFB_CHANNELS_IN_SEQ><VFB_CHANNELS_IN_PAR>3</VFB_CHANNELS_IN_PAR><VFB_WRITER_RUNTIME_CONTROL>false</VFB_WRITER_RUNTIME_CONTROL><VFB_DROP_FRAMES>true</VFB_DROP_FRAMES><VFB_READER_RUNTIME_CONTROL>0</VFB_READER_RUNTIME_CONTROL><VFB_REPEAT_FRAMES>true</VFB_REPEAT_FRAMES><VFB_FRAMEBUFFERS_ADDR>00000000</VFB_FRAMEBUFFERS_ADDR><VFB_MEM_PORT_WIDTH>32</VFB_MEM_PORT_WIDTH><VFB_MEM_MASTERS_USE_SEPARATE_CLOCK>false</VFB_MEM_MASTERS_USE_SEPARATE_CLOCK><VFB_RDATA_FIFO_DEPTH>1024</VFB_RDATA_FIFO_DEPTH><VFB_RDATA_BURST_TARGET>4</VFB_RDATA_BURST_TARGET><VFB_WDATA_FIFO_DEPTH>1024</VFB_WDATA_FIFO_DEPTH><VFB_WDATA_BURST_TARGET>4</VFB_WDATA_BURST_TARGET><VFB_MAX_NUMBER_PACKETS>1</VFB_MAX_NUMBER_PACKETS><VFB_MAX_SYMBOLS_IN_PACKET>10</VFB_MAX_SYMBOLS_IN_PACKET><VFB_INTERLACED_SUPPORT>0</VFB_INTERLACED_SUPPORT><VFB_CONTROLLED_DROP_REPEAT>0</VFB_CONTROLLED_DROP_REPEAT><VFB_BURST_ALIGNMENT>0</VFB_BURST_ALIGNMENT><VFB_DROP_INVALID_FIELDS>false</VFB_DROP_INVALID_FIELDS></frameBufferParams>}

    add_instance altpll_0 altpll 16.1
    set_instance_parameter_value altpll_0 {HIDDEN_CUSTOM_ELABORATION} {altpll_avalon_elaboration}
    set_instance_parameter_value altpll_0 {HIDDEN_CUSTOM_POST_EDIT} {altpll_avalon_post_edit}
    set_instance_parameter_value altpll_0 {INTENDED_DEVICE_FAMILY} {MAX 10}
    set_instance_parameter_value altpll_0 {WIDTH_CLOCK} {5}
    set_instance_parameter_value altpll_0 {WIDTH_PHASECOUNTERSELECT} {}
    set_instance_parameter_value altpll_0 {PRIMARY_CLOCK} {}
    set_instance_parameter_value altpll_0 {INCLK0_INPUT_FREQUENCY} {20000}
    set_instance_parameter_value altpll_0 {INCLK1_INPUT_FREQUENCY} {}
    set_instance_parameter_value altpll_0 {OPERATION_MODE} {NORMAL}
    set_instance_parameter_value altpll_0 {PLL_TYPE} {AUTO}
    set_instance_parameter_value altpll_0 {QUALIFY_CONF_DONE} {}
    set_instance_parameter_value altpll_0 {COMPENSATE_CLOCK} {CLK0}
    set_instance_parameter_value altpll_0 {SCAN_CHAIN} {}
    set_instance_parameter_value altpll_0 {GATE_LOCK_SIGNAL} {}
    set_instance_parameter_value altpll_0 {GATE_LOCK_COUNTER} {}
    set_instance_parameter_value altpll_0 {LOCK_HIGH} {}
    set_instance_parameter_value altpll_0 {LOCK_LOW} {}
    set_instance_parameter_value altpll_0 {VALID_LOCK_MULTIPLIER} {}
    set_instance_parameter_value altpll_0 {INVALID_LOCK_MULTIPLIER} {}
    set_instance_parameter_value altpll_0 {SWITCH_OVER_ON_LOSSCLK} {}
    set_instance_parameter_value altpll_0 {SWITCH_OVER_ON_GATED_LOCK} {}
    set_instance_parameter_value altpll_0 {ENABLE_SWITCH_OVER_COUNTER} {}
    set_instance_parameter_value altpll_0 {SKIP_VCO} {}
    set_instance_parameter_value altpll_0 {SWITCH_OVER_COUNTER} {}
    set_instance_parameter_value altpll_0 {SWITCH_OVER_TYPE} {}
    set_instance_parameter_value altpll_0 {FEEDBACK_SOURCE} {}
    set_instance_parameter_value altpll_0 {BANDWIDTH} {}
    set_instance_parameter_value altpll_0 {BANDWIDTH_TYPE} {AUTO}
    set_instance_parameter_value altpll_0 {SPREAD_FREQUENCY} {}
    set_instance_parameter_value altpll_0 {DOWN_SPREAD} {}
    set_instance_parameter_value altpll_0 {SELF_RESET_ON_GATED_LOSS_LOCK} {}
    set_instance_parameter_value altpll_0 {SELF_RESET_ON_LOSS_LOCK} {}
    set_instance_parameter_value altpll_0 {CLK0_MULTIPLY_BY} {2}
    set_instance_parameter_value altpll_0 {CLK1_MULTIPLY_BY} {2}
    set_instance_parameter_value altpll_0 {CLK2_MULTIPLY_BY} {2}
    set_instance_parameter_value altpll_0 {CLK3_MULTIPLY_BY} {1}
    set_instance_parameter_value altpll_0 {CLK4_MULTIPLY_BY} {2}
    set_instance_parameter_value altpll_0 {CLK5_MULTIPLY_BY} {}
    set_instance_parameter_value altpll_0 {CLK6_MULTIPLY_BY} {}
    set_instance_parameter_value altpll_0 {CLK7_MULTIPLY_BY} {}
    set_instance_parameter_value altpll_0 {CLK8_MULTIPLY_BY} {}
    set_instance_parameter_value altpll_0 {CLK9_MULTIPLY_BY} {}
    set_instance_parameter_value altpll_0 {EXTCLK0_MULTIPLY_BY} {}
    set_instance_parameter_value altpll_0 {EXTCLK1_MULTIPLY_BY} {}
    set_instance_parameter_value altpll_0 {EXTCLK2_MULTIPLY_BY} {}
    set_instance_parameter_value altpll_0 {EXTCLK3_MULTIPLY_BY} {}
    set_instance_parameter_value altpll_0 {CLK0_DIVIDE_BY} {1}
    set_instance_parameter_value altpll_0 {CLK1_DIVIDE_BY} {1}
    set_instance_parameter_value altpll_0 {CLK2_DIVIDE_BY} {1}
    set_instance_parameter_value altpll_0 {CLK3_DIVIDE_BY} {2}
    set_instance_parameter_value altpll_0 {CLK4_DIVIDE_BY} {5}
    set_instance_parameter_value altpll_0 {CLK5_DIVIDE_BY} {}
    set_instance_parameter_value altpll_0 {CLK6_DIVIDE_BY} {}
    set_instance_parameter_value altpll_0 {CLK7_DIVIDE_BY} {}
    set_instance_parameter_value altpll_0 {CLK8_DIVIDE_BY} {}
    set_instance_parameter_value altpll_0 {CLK9_DIVIDE_BY} {}
    set_instance_parameter_value altpll_0 {EXTCLK0_DIVIDE_BY} {}
    set_instance_parameter_value altpll_0 {EXTCLK1_DIVIDE_BY} {}
    set_instance_parameter_value altpll_0 {EXTCLK2_DIVIDE_BY} {}
    set_instance_parameter_value altpll_0 {EXTCLK3_DIVIDE_BY} {}
    set_instance_parameter_value altpll_0 {CLK0_PHASE_SHIFT} {0}
    set_instance_parameter_value altpll_0 {CLK1_PHASE_SHIFT} {7500}
    set_instance_parameter_value altpll_0 {CLK2_PHASE_SHIFT} {0}
    set_instance_parameter_value altpll_0 {CLK3_PHASE_SHIFT} {0}
    set_instance_parameter_value altpll_0 {CLK4_PHASE_SHIFT} {0}
    set_instance_parameter_value altpll_0 {CLK5_PHASE_SHIFT} {}
    set_instance_parameter_value altpll_0 {CLK6_PHASE_SHIFT} {}
    set_instance_parameter_value altpll_0 {CLK7_PHASE_SHIFT} {}
    set_instance_parameter_value altpll_0 {CLK8_PHASE_SHIFT} {}
    set_instance_parameter_value altpll_0 {CLK9_PHASE_SHIFT} {}
    set_instance_parameter_value altpll_0 {EXTCLK0_PHASE_SHIFT} {}
    set_instance_parameter_value altpll_0 {EXTCLK1_PHASE_SHIFT} {}
    set_instance_parameter_value altpll_0 {EXTCLK2_PHASE_SHIFT} {}
    set_instance_parameter_value altpll_0 {EXTCLK3_PHASE_SHIFT} {}
    set_instance_parameter_value altpll_0 {CLK0_DUTY_CYCLE} {50}
    set_instance_parameter_value altpll_0 {CLK1_DUTY_CYCLE} {50}
    set_instance_parameter_value altpll_0 {CLK2_DUTY_CYCLE} {50}
    set_instance_parameter_value altpll_0 {CLK3_DUTY_CYCLE} {50}
    set_instance_parameter_value altpll_0 {CLK4_DUTY_CYCLE} {50}
    set_instance_parameter_value altpll_0 {CLK5_DUTY_CYCLE} {}
    set_instance_parameter_value altpll_0 {CLK6_DUTY_CYCLE} {}
    set_instance_parameter_value altpll_0 {CLK7_DUTY_CYCLE} {}
    set_instance_parameter_value altpll_0 {CLK8_DUTY_CYCLE} {}
    set_instance_parameter_value altpll_0 {CLK9_DUTY_CYCLE} {}
    set_instance_parameter_value altpll_0 {EXTCLK0_DUTY_CYCLE} {}
    set_instance_parameter_value altpll_0 {EXTCLK1_DUTY_CYCLE} {}
    set_instance_parameter_value altpll_0 {EXTCLK2_DUTY_CYCLE} {}
    set_instance_parameter_value altpll_0 {EXTCLK3_DUTY_CYCLE} {}
    set_instance_parameter_value altpll_0 {PORT_clkena0} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_clkena1} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_clkena2} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_clkena3} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_clkena4} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_clkena5} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_extclkena0} {}
    set_instance_parameter_value altpll_0 {PORT_extclkena1} {}
    set_instance_parameter_value altpll_0 {PORT_extclkena2} {}
    set_instance_parameter_value altpll_0 {PORT_extclkena3} {}
    set_instance_parameter_value altpll_0 {PORT_extclk0} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_extclk1} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_extclk2} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_extclk3} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_CLKBAD0} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_CLKBAD1} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_clk0} {PORT_USED}
    set_instance_parameter_value altpll_0 {PORT_clk1} {PORT_USED}
    set_instance_parameter_value altpll_0 {PORT_clk2} {PORT_USED}
    set_instance_parameter_value altpll_0 {PORT_clk3} {PORT_USED}
    set_instance_parameter_value altpll_0 {PORT_clk4} {PORT_USED}
    set_instance_parameter_value altpll_0 {PORT_clk5} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_clk6} {}
    set_instance_parameter_value altpll_0 {PORT_clk7} {}
    set_instance_parameter_value altpll_0 {PORT_clk8} {}
    set_instance_parameter_value altpll_0 {PORT_clk9} {}
    set_instance_parameter_value altpll_0 {PORT_SCANDATA} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_SCANDATAOUT} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_SCANDONE} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_SCLKOUT1} {}
    set_instance_parameter_value altpll_0 {PORT_SCLKOUT0} {}
    set_instance_parameter_value altpll_0 {PORT_ACTIVECLOCK} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_CLKLOSS} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_INCLK1} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_INCLK0} {PORT_USED}
    set_instance_parameter_value altpll_0 {PORT_FBIN} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_PLLENA} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_CLKSWITCH} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_ARESET} {PORT_USED}
    set_instance_parameter_value altpll_0 {PORT_PFDENA} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_SCANCLK} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_SCANACLR} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_SCANREAD} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_SCANWRITE} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_ENABLE0} {}
    set_instance_parameter_value altpll_0 {PORT_ENABLE1} {}
    set_instance_parameter_value altpll_0 {PORT_LOCKED} {PORT_USED}
    set_instance_parameter_value altpll_0 {PORT_CONFIGUPDATE} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_FBOUT} {}
    set_instance_parameter_value altpll_0 {PORT_PHASEDONE} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_PHASESTEP} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_PHASEUPDOWN} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_SCANCLKENA} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_PHASECOUNTERSELECT} {PORT_UNUSED}
    set_instance_parameter_value altpll_0 {PORT_VCOOVERRANGE} {}
    set_instance_parameter_value altpll_0 {PORT_VCOUNDERRANGE} {}
    set_instance_parameter_value altpll_0 {DPA_MULTIPLY_BY} {}
    set_instance_parameter_value altpll_0 {DPA_DIVIDE_BY} {}
    set_instance_parameter_value altpll_0 {DPA_DIVIDER} {}
    set_instance_parameter_value altpll_0 {VCO_MULTIPLY_BY} {}
    set_instance_parameter_value altpll_0 {VCO_DIVIDE_BY} {}
    set_instance_parameter_value altpll_0 {SCLKOUT0_PHASE_SHIFT} {}
    set_instance_parameter_value altpll_0 {SCLKOUT1_PHASE_SHIFT} {}
    set_instance_parameter_value altpll_0 {VCO_FREQUENCY_CONTROL} {}
    set_instance_parameter_value altpll_0 {VCO_PHASE_SHIFT_STEP} {}
    set_instance_parameter_value altpll_0 {USING_FBMIMICBIDIR_PORT} {}
    set_instance_parameter_value altpll_0 {SCAN_CHAIN_MIF_FILE} {}
    set_instance_parameter_value altpll_0 {AVALON_USE_SEPARATE_SYSCLK} {NO}
    set_instance_parameter_value altpll_0 {HIDDEN_CONSTANTS} {CT#CLK2_DIVIDE_BY 1 CT#PORT_clk5 PORT_UNUSED CT#PORT_clk4 PORT_USED CT#PORT_clk3 PORT_USED CT#PORT_clk2 PORT_USED CT#PORT_clk1 PORT_USED CT#PORT_clk0 PORT_USED CT#CLK0_MULTIPLY_BY 2 CT#PORT_SCANWRITE PORT_UNUSED CT#PORT_SCANACLR PORT_UNUSED CT#PORT_PFDENA PORT_UNUSED CT#CLK3_DUTY_CYCLE 50 CT#CLK3_DIVIDE_BY 2 CT#PORT_PLLENA PORT_UNUSED CT#PORT_SCANDATA PORT_UNUSED CT#CLK3_PHASE_SHIFT 0 CT#PORT_SCANCLKENA PORT_UNUSED CT#CLK4_DIVIDE_BY 5 CT#WIDTH_CLOCK 5 CT#PORT_SCANDATAOUT PORT_UNUSED CT#CLK4_MULTIPLY_BY 2 CT#LPM_TYPE altpll CT#PLL_TYPE AUTO CT#CLK0_PHASE_SHIFT 0 CT#CLK1_DUTY_CYCLE 50 CT#PORT_PHASEDONE PORT_UNUSED CT#OPERATION_MODE NORMAL CT#PORT_CONFIGUPDATE PORT_UNUSED CT#CLK1_MULTIPLY_BY 2 CT#COMPENSATE_CLOCK CLK0 CT#PORT_CLKSWITCH PORT_UNUSED CT#CLK4_PHASE_SHIFT 0 CT#INCLK0_INPUT_FREQUENCY 20000 CT#CLK4_DUTY_CYCLE 50 CT#PORT_SCANDONE PORT_UNUSED CT#PORT_CLKLOSS PORT_UNUSED CT#PORT_INCLK1 PORT_UNUSED CT#AVALON_USE_SEPARATE_SYSCLK NO CT#PORT_INCLK0 PORT_USED CT#PORT_clkena5 PORT_UNUSED CT#PORT_clkena4 PORT_UNUSED CT#PORT_clkena3 PORT_UNUSED CT#PORT_clkena2 PORT_UNUSED CT#PORT_clkena1 PORT_UNUSED CT#PORT_clkena0 PORT_UNUSED CT#CLK1_PHASE_SHIFT 7500 CT#PORT_ARESET PORT_USED CT#BANDWIDTH_TYPE AUTO CT#CLK2_MULTIPLY_BY 2 CT#INTENDED_DEVICE_FAMILY {MAX 10} CT#PORT_SCANREAD PORT_UNUSED CT#CLK2_DUTY_CYCLE 50 CT#PORT_PHASESTEP PORT_UNUSED CT#PORT_SCANCLK PORT_UNUSED CT#PORT_CLKBAD1 PORT_UNUSED CT#PORT_CLKBAD0 PORT_UNUSED CT#PORT_FBIN PORT_UNUSED CT#PORT_PHASEUPDOWN PORT_UNUSED CT#PORT_extclk3 PORT_UNUSED CT#PORT_extclk2 PORT_UNUSED CT#PORT_extclk1 PORT_UNUSED CT#PORT_PHASECOUNTERSELECT PORT_UNUSED CT#PORT_extclk0 PORT_UNUSED CT#PORT_ACTIVECLOCK PORT_UNUSED CT#CLK2_PHASE_SHIFT 0 CT#CLK0_DUTY_CYCLE 50 CT#CLK0_DIVIDE_BY 1 CT#CLK1_DIVIDE_BY 1 CT#CLK3_MULTIPLY_BY 1 CT#PORT_LOCKED PORT_USED}
    set_instance_parameter_value altpll_0 {HIDDEN_PRIVATES} {PT#GLOCKED_FEATURE_ENABLED 0 PT#SPREAD_FEATURE_ENABLED 0 PT#BANDWIDTH_FREQ_UNIT MHz PT#CUR_DEDICATED_CLK c0 PT#INCLK0_FREQ_EDIT 50.000 PT#BANDWIDTH_PRESET Low PT#PLL_LVDS_PLL_CHECK 0 PT#BANDWIDTH_USE_PRESET 0 PT#AVALON_USE_SEPARATE_SYSCLK NO PT#OUTPUT_FREQ_UNIT4 MHz PT#OUTPUT_FREQ_UNIT3 MHz PT#PLL_ENHPLL_CHECK 0 PT#OUTPUT_FREQ_UNIT2 MHz PT#OUTPUT_FREQ_UNIT1 MHz PT#OUTPUT_FREQ_UNIT0 MHz PT#PHASE_RECONFIG_FEATURE_ENABLED 1 PT#CREATE_CLKBAD_CHECK 0 PT#CLKSWITCH_CHECK 0 PT#INCLK1_FREQ_EDIT 100.000 PT#NORMAL_MODE_RADIO 1 PT#SRC_SYNCH_COMP_RADIO 0 PT#PLL_ARESET_CHECK 1 PT#LONG_SCAN_RADIO 1 PT#SCAN_FEATURE_ENABLED 1 PT#USE_CLK4 1 PT#USE_CLK3 1 PT#USE_CLK2 1 PT#PHASE_RECONFIG_INPUTS_CHECK 0 PT#USE_CLK1 1 PT#USE_CLK0 1 PT#PRIMARY_CLK_COMBO inclk0 PT#BANDWIDTH 1.000 PT#GLOCKED_COUNTER_EDIT_CHANGED 1 PT#PLL_FASTPLL_CHECK 0 PT#SPREAD_FREQ_UNIT KHz PT#LVDS_PHASE_SHIFT_UNIT4 deg PT#LVDS_PHASE_SHIFT_UNIT3 deg PT#PLL_AUTOPLL_CHECK 1 PT#OUTPUT_FREQ_MODE4 1 PT#LVDS_PHASE_SHIFT_UNIT2 deg PT#OUTPUT_FREQ_MODE3 1 PT#LVDS_PHASE_SHIFT_UNIT1 deg PT#OUTPUT_FREQ_MODE2 1 PT#LVDS_PHASE_SHIFT_UNIT0 deg PT#OUTPUT_FREQ_MODE1 1 PT#SWITCHOVER_FEATURE_ENABLED 0 PT#MIG_DEVICE_SPEED_GRADE Any PT#OUTPUT_FREQ_MODE0 1 PT#BANDWIDTH_FEATURE_ENABLED 1 PT#INCLK0_FREQ_UNIT_COMBO MHz PT#ZERO_DELAY_RADIO 0 PT#OUTPUT_FREQ4 20.00000000 PT#OUTPUT_FREQ3 25.00000000 PT#OUTPUT_FREQ2 100.00000000 PT#OUTPUT_FREQ1 100.00000000 PT#OUTPUT_FREQ0 100.00000000 PT#SHORT_SCAN_RADIO 0 PT#LVDS_MODE_DATA_RATE_DIRTY 0 PT#CUR_FBIN_CLK c0 PT#PLL_ADVANCED_PARAM_CHECK 0 PT#CLKBAD_SWITCHOVER_CHECK 0 PT#PHASE_SHIFT_STEP_ENABLED_CHECK 0 PT#DEVICE_SPEED_GRADE 6 PT#PLL_FBMIMIC_CHECK 0 PT#LVDS_MODE_DATA_RATE {Not Available} PT#PHASE_SHIFT4 0.00000000 PT#LOCKED_OUTPUT_CHECK 1 PT#SPREAD_PERCENT 0.500 PT#PHASE_SHIFT3 0.00000000 PT#DIV_FACTOR4 1 PT#PHASE_SHIFT2 0.00000000 PT#DIV_FACTOR3 1 PT#PHASE_SHIFT1 270.00000000 PT#DIV_FACTOR2 1 PT#PHASE_SHIFT0 0.00000000 PT#DIV_FACTOR1 1 PT#DIV_FACTOR0 1 PT#CNX_NO_COMPENSATE_RADIO 0 PT#USE_CLKENA4 0 PT#USE_CLKENA3 0 PT#USE_CLKENA2 0 PT#USE_CLKENA1 0 PT#USE_CLKENA0 0 PT#CREATE_INCLK1_CHECK 0 PT#GLOCK_COUNTER_EDIT 1048575 PT#INCLK1_FREQ_UNIT_COMBO MHz PT#EFF_OUTPUT_FREQ_VALUE4 20.000000 PT#EFF_OUTPUT_FREQ_VALUE3 25.000000 PT#EFF_OUTPUT_FREQ_VALUE2 100.000000 PT#EFF_OUTPUT_FREQ_VALUE1 100.000000 PT#EFF_OUTPUT_FREQ_VALUE0 100.000000 PT#SPREAD_FREQ 50.000 PT#USE_MIL_SPEED_GRADE 0 PT#EXPLICIT_SWITCHOVER_COUNTER 0 PT#STICKY_CLK4 1 PT#STICKY_CLK3 1 PT#STICKY_CLK2 1 PT#STICKY_CLK1 1 PT#STICKY_CLK0 1 PT#MIRROR_CLK4 0 PT#EXT_FEEDBACK_RADIO 0 PT#MIRROR_CLK3 0 PT#MIRROR_CLK2 0 PT#MIRROR_CLK1 0 PT#SWITCHOVER_COUNT_EDIT 1 PT#MIRROR_CLK0 0 PT#SELF_RESET_LOCK_LOSS 0 PT#PLL_PFDENA_CHECK 0 PT#INT_FEEDBACK__MODE_RADIO 1 PT#INCLK1_FREQ_EDIT_CHANGED 1 PT#SYNTH_WRAPPER_GEN_POSTFIX 0 PT#CLKLOSS_CHECK 0 PT#PHASE_SHIFT_UNIT4 deg PT#PHASE_SHIFT_UNIT3 deg PT#PHASE_SHIFT_UNIT2 deg PT#PHASE_SHIFT_UNIT1 deg PT#PHASE_SHIFT_UNIT0 deg PT#BANDWIDTH_USE_AUTO 1 PT#HAS_MANUAL_SWITCHOVER 1 PT#MULT_FACTOR4 1 PT#MULT_FACTOR3 1 PT#MULT_FACTOR2 1 PT#MULT_FACTOR1 1 PT#MULT_FACTOR0 1 PT#SPREAD_USE 0 PT#GLOCKED_MODE_CHECK 0 PT#DUTY_CYCLE4 50.00000000 PT#DUTY_CYCLE3 50.00000000 PT#DUTY_CYCLE2 50.00000000 PT#SACN_INPUTS_CHECK 0 PT#DUTY_CYCLE1 50.00000000 PT#INTENDED_DEVICE_FAMILY {MAX 10} PT#DUTY_CYCLE0 50.00000000 PT#PLL_TARGET_HARCOPY_CHECK 0 PT#INCLK1_FREQ_UNIT_CHANGED 1 PT#RECONFIG_FILE ALTPLL1472001986172141.mif PT#ACTIVECLK_CHECK 0}
    set_instance_parameter_value altpll_0 {HIDDEN_USED_PORTS} {UP#locked used UP#c4 used UP#c3 used UP#c2 used UP#c1 used UP#c0 used UP#areset used UP#inclk0 used}
    set_instance_parameter_value altpll_0 {HIDDEN_IS_NUMERIC} {IN#WIDTH_CLOCK 1 IN#CLK0_DUTY_CYCLE 1 IN#CLK2_DIVIDE_BY 1 IN#PLL_TARGET_HARCOPY_CHECK 1 IN#CLK3_DIVIDE_BY 1 IN#CLK4_MULTIPLY_BY 1 IN#CLK1_MULTIPLY_BY 1 IN#CLK3_DUTY_CYCLE 1 IN#CLK4_DIVIDE_BY 1 IN#SWITCHOVER_COUNT_EDIT 1 IN#INCLK0_INPUT_FREQUENCY 1 IN#PLL_LVDS_PLL_CHECK 1 IN#PLL_AUTOPLL_CHECK 1 IN#PLL_FASTPLL_CHECK 1 IN#CLK1_DUTY_CYCLE 1 IN#PLL_ENHPLL_CHECK 1 IN#CLK2_MULTIPLY_BY 1 IN#DIV_FACTOR4 1 IN#DIV_FACTOR3 1 IN#DIV_FACTOR2 1 IN#DIV_FACTOR1 1 IN#DIV_FACTOR0 1 IN#LVDS_MODE_DATA_RATE_DIRTY 1 IN#CLK4_DUTY_CYCLE 1 IN#GLOCK_COUNTER_EDIT 1 IN#CLK2_DUTY_CYCLE 1 IN#CLK0_DIVIDE_BY 1 IN#CLK3_MULTIPLY_BY 1 IN#MULT_FACTOR4 1 IN#MULT_FACTOR3 1 IN#MULT_FACTOR2 1 IN#MULT_FACTOR1 1 IN#MULT_FACTOR0 1 IN#CLK0_MULTIPLY_BY 1 IN#USE_MIL_SPEED_GRADE 1 IN#CLK1_DIVIDE_BY 1}
    set_instance_parameter_value altpll_0 {HIDDEN_MF_PORTS} {MF#areset 1 MF#clk 1 MF#locked 1 MF#inclk 1}
    set_instance_parameter_value altpll_0 {HIDDEN_IF_PORTS} {IF#phasecounterselect {input 3} IF#locked {output 0} IF#reset {input 0} IF#clk {input 0} IF#phaseupdown {input 0} IF#scandone {output 0} IF#readdata {output 32} IF#write {input 0} IF#scanclk {input 0} IF#phasedone {output 0} IF#c4 {output 0} IF#c3 {output 0} IF#address {input 2} IF#c2 {output 0} IF#c1 {output 0} IF#c0 {output 0} IF#writedata {input 32} IF#read {input 0} IF#areset {input 0} IF#scanclkena {input 0} IF#scandataout {output 0} IF#configupdate {input 0} IF#phasestep {input 0} IF#scandata {input 0}}
    set_instance_parameter_value altpll_0 {HIDDEN_IS_FIRST_EDIT} {0}

    add_instance clk_50 clock_source 16.1
    set_instance_parameter_value clk_50 {clockFrequency} {50000000.0}
    set_instance_parameter_value clk_50 {clockFrequencyKnown} {1}
    set_instance_parameter_value clk_50 {resetSynchronousEdges} {NONE}

    add_instance i2c_opencores_camera i2c_opencores 12.0

    add_instance i2c_opencores_mipi i2c_opencores 12.0

    add_instance jtag_uart altera_avalon_jtag_uart 16.1
    set_instance_parameter_value jtag_uart {allowMultipleConnections} {0}
    set_instance_parameter_value jtag_uart {hubInstanceID} {0}
    set_instance_parameter_value jtag_uart {readBufferDepth} {64}
    set_instance_parameter_value jtag_uart {readIRQThreshold} {8}
    set_instance_parameter_value jtag_uart {simInputCharacterStream} {}
    set_instance_parameter_value jtag_uart {simInteractiveOptions} {NO_INTERACTIVE_WINDOWS}
    set_instance_parameter_value jtag_uart {useRegistersForReadBuffer} {0}
    set_instance_parameter_value jtag_uart {useRegistersForWriteBuffer} {0}
    set_instance_parameter_value jtag_uart {useRelativePathForSimFile} {0}
    set_instance_parameter_value jtag_uart {writeBufferDepth} {64}
    set_instance_parameter_value jtag_uart {writeIRQThreshold} {8}

    add_instance key altera_avalon_pio 16.1
    set_instance_parameter_value key {bitClearingEdgeCapReg} {0}
    set_instance_parameter_value key {bitModifyingOutReg} {0}
    set_instance_parameter_value key {captureEdge} {0}
    set_instance_parameter_value key {direction} {Input}
    set_instance_parameter_value key {edgeType} {RISING}
    set_instance_parameter_value key {generateIRQ} {0}
    set_instance_parameter_value key {irqType} {LEVEL}
    set_instance_parameter_value key {resetValue} {0.0}
    set_instance_parameter_value key {simDoTestBenchWiring} {0}
    set_instance_parameter_value key {simDrivenValue} {0.0}
    set_instance_parameter_value key {width} {2}

    add_instance led altera_avalon_pio 16.1
    set_instance_parameter_value led {bitClearingEdgeCapReg} {0}
    set_instance_parameter_value led {bitModifyingOutReg} {0}
    set_instance_parameter_value led {captureEdge} {0}
    set_instance_parameter_value led {direction} {Output}
    set_instance_parameter_value led {edgeType} {RISING}
    set_instance_parameter_value led {generateIRQ} {0}
    set_instance_parameter_value led {irqType} {LEVEL}
    set_instance_parameter_value led {resetValue} {0.0}
    set_instance_parameter_value led {simDoTestBenchWiring} {0}
    set_instance_parameter_value led {simDrivenValue} {0.0}
    set_instance_parameter_value led {width} {10}

    add_instance mipi_pwdn_n altera_avalon_pio 16.1
    set_instance_parameter_value mipi_pwdn_n {bitClearingEdgeCapReg} {0}
    set_instance_parameter_value mipi_pwdn_n {bitModifyingOutReg} {0}
    set_instance_parameter_value mipi_pwdn_n {captureEdge} {0}
    set_instance_parameter_value mipi_pwdn_n {direction} {Output}
    set_instance_parameter_value mipi_pwdn_n {edgeType} {RISING}
    set_instance_parameter_value mipi_pwdn_n {generateIRQ} {0}
    set_instance_parameter_value mipi_pwdn_n {irqType} {LEVEL}
    set_instance_parameter_value mipi_pwdn_n {resetValue} {0.0}
    set_instance_parameter_value mipi_pwdn_n {simDoTestBenchWiring} {0}
    set_instance_parameter_value mipi_pwdn_n {simDrivenValue} {0.0}
    set_instance_parameter_value mipi_pwdn_n {width} {1}

    add_instance mipi_reset_n altera_avalon_pio 16.1
    set_instance_parameter_value mipi_reset_n {bitClearingEdgeCapReg} {0}
    set_instance_parameter_value mipi_reset_n {bitModifyingOutReg} {0}
    set_instance_parameter_value mipi_reset_n {captureEdge} {0}
    set_instance_parameter_value mipi_reset_n {direction} {Output}
    set_instance_parameter_value mipi_reset_n {edgeType} {RISING}
    set_instance_parameter_value mipi_reset_n {generateIRQ} {0}
    set_instance_parameter_value mipi_reset_n {irqType} {LEVEL}
    set_instance_parameter_value mipi_reset_n {resetValue} {0.0}
    set_instance_parameter_value mipi_reset_n {simDoTestBenchWiring} {0}
    set_instance_parameter_value mipi_reset_n {simDrivenValue} {0.0}
    set_instance_parameter_value mipi_reset_n {width} {1}

    add_instance nios2_gen2 altera_nios2_gen2 16.1
    set_instance_parameter_value nios2_gen2 {tmr_enabled} {0}
    set_instance_parameter_value nios2_gen2 {setting_disable_tmr_inj} {0}
    set_instance_parameter_value nios2_gen2 {setting_showUnpublishedSettings} {0}
    set_instance_parameter_value nios2_gen2 {setting_showInternalSettings} {0}
    set_instance_parameter_value nios2_gen2 {setting_preciseIllegalMemAccessException} {0}
    set_instance_parameter_value nios2_gen2 {setting_exportPCB} {0}
    set_instance_parameter_value nios2_gen2 {setting_exportdebuginfo} {0}
    set_instance_parameter_value nios2_gen2 {setting_clearXBitsLDNonBypass} {1}
    set_instance_parameter_value nios2_gen2 {setting_bigEndian} {0}
    set_instance_parameter_value nios2_gen2 {setting_export_large_RAMs} {0}
    set_instance_parameter_value nios2_gen2 {setting_asic_enabled} {0}
    set_instance_parameter_value nios2_gen2 {register_file_por} {0}
    set_instance_parameter_value nios2_gen2 {setting_asic_synopsys_translate_on_off} {0}
    set_instance_parameter_value nios2_gen2 {setting_asic_third_party_synthesis} {0}
    set_instance_parameter_value nios2_gen2 {setting_asic_add_scan_mode_input} {0}
    set_instance_parameter_value nios2_gen2 {setting_oci_version} {1}
    set_instance_parameter_value nios2_gen2 {setting_fast_register_read} {0}
    set_instance_parameter_value nios2_gen2 {setting_exportHostDebugPort} {0}
    set_instance_parameter_value nios2_gen2 {setting_oci_export_jtag_signals} {0}
    set_instance_parameter_value nios2_gen2 {setting_avalonDebugPortPresent} {0}
    set_instance_parameter_value nios2_gen2 {setting_alwaysEncrypt} {1}
    set_instance_parameter_value nios2_gen2 {io_regionbase} {0}
    set_instance_parameter_value nios2_gen2 {io_regionsize} {0}
    set_instance_parameter_value nios2_gen2 {setting_support31bitdcachebypass} {1}
    set_instance_parameter_value nios2_gen2 {setting_activateTrace} {0}
    set_instance_parameter_value nios2_gen2 {setting_allow_break_inst} {0}
    set_instance_parameter_value nios2_gen2 {setting_activateTestEndChecker} {0}
    set_instance_parameter_value nios2_gen2 {setting_ecc_sim_test_ports} {0}
    set_instance_parameter_value nios2_gen2 {setting_disableocitrace} {0}
    set_instance_parameter_value nios2_gen2 {setting_activateMonitors} {1}
    set_instance_parameter_value nios2_gen2 {setting_HDLSimCachesCleared} {1}
    set_instance_parameter_value nios2_gen2 {setting_HBreakTest} {0}
    set_instance_parameter_value nios2_gen2 {setting_breakslaveoveride} {0}
    set_instance_parameter_value nios2_gen2 {mpu_useLimit} {0}
    set_instance_parameter_value nios2_gen2 {mpu_enabled} {0}
    set_instance_parameter_value nios2_gen2 {mmu_enabled} {0}
    set_instance_parameter_value nios2_gen2 {mmu_autoAssignTlbPtrSz} {1}
    set_instance_parameter_value nios2_gen2 {cpuReset} {0}
    set_instance_parameter_value nios2_gen2 {resetrequest_enabled} {1}
    set_instance_parameter_value nios2_gen2 {setting_removeRAMinit} {0}
    set_instance_parameter_value nios2_gen2 {setting_tmr_output_disable} {0}
    set_instance_parameter_value nios2_gen2 {setting_shadowRegisterSets} {0}
    set_instance_parameter_value nios2_gen2 {mpu_numOfInstRegion} {8}
    set_instance_parameter_value nios2_gen2 {mpu_numOfDataRegion} {8}
    set_instance_parameter_value nios2_gen2 {mmu_TLBMissExcOffset} {0}
    set_instance_parameter_value nios2_gen2 {resetOffset} {0}
    set_instance_parameter_value nios2_gen2 {exceptionOffset} {32}
    set_instance_parameter_value nios2_gen2 {cpuID} {0}
    set_instance_parameter_value nios2_gen2 {breakOffset} {32}
    set_instance_parameter_value nios2_gen2 {userDefinedSettings} {}
    set_instance_parameter_value nios2_gen2 {tracefilename} {}
    set_instance_parameter_value nios2_gen2 {resetSlave} {onchip_memory2_0.s1}
    set_instance_parameter_value nios2_gen2 {mmu_TLBMissExcSlave} {None}
    set_instance_parameter_value nios2_gen2 {exceptionSlave} {onchip_memory2_0.s1}
    set_instance_parameter_value nios2_gen2 {breakSlave} {None}
    set_instance_parameter_value nios2_gen2 {setting_interruptControllerType} {Internal}
    set_instance_parameter_value nios2_gen2 {setting_branchpredictiontype} {Dynamic}
    set_instance_parameter_value nios2_gen2 {setting_bhtPtrSz} {8}
    set_instance_parameter_value nios2_gen2 {cpuArchRev} {1}
    set_instance_parameter_value nios2_gen2 {mul_shift_choice} {0}
    set_instance_parameter_value nios2_gen2 {mul_32_impl} {2}
    set_instance_parameter_value nios2_gen2 {mul_64_impl} {0}
    set_instance_parameter_value nios2_gen2 {shift_rot_impl} {1}
    set_instance_parameter_value nios2_gen2 {dividerType} {no_div}
    set_instance_parameter_value nios2_gen2 {mpu_minInstRegionSize} {12}
    set_instance_parameter_value nios2_gen2 {mpu_minDataRegionSize} {12}
    set_instance_parameter_value nios2_gen2 {mmu_uitlbNumEntries} {4}
    set_instance_parameter_value nios2_gen2 {mmu_udtlbNumEntries} {6}
    set_instance_parameter_value nios2_gen2 {mmu_tlbPtrSz} {7}
    set_instance_parameter_value nios2_gen2 {mmu_tlbNumWays} {16}
    set_instance_parameter_value nios2_gen2 {mmu_processIDNumBits} {8}
    set_instance_parameter_value nios2_gen2 {impl} {Fast}
    set_instance_parameter_value nios2_gen2 {icache_size} {4096}
    set_instance_parameter_value nios2_gen2 {fa_cache_line} {2}
    set_instance_parameter_value nios2_gen2 {fa_cache_linesize} {0}
    set_instance_parameter_value nios2_gen2 {icache_tagramBlockType} {Automatic}
    set_instance_parameter_value nios2_gen2 {icache_ramBlockType} {Automatic}
    set_instance_parameter_value nios2_gen2 {icache_numTCIM} {0}
    set_instance_parameter_value nios2_gen2 {icache_burstType} {None}
    set_instance_parameter_value nios2_gen2 {dcache_bursts} {false}
    set_instance_parameter_value nios2_gen2 {dcache_victim_buf_impl} {ram}
    set_instance_parameter_value nios2_gen2 {dcache_size} {2048}
    set_instance_parameter_value nios2_gen2 {dcache_tagramBlockType} {Automatic}
    set_instance_parameter_value nios2_gen2 {dcache_ramBlockType} {Automatic}
    set_instance_parameter_value nios2_gen2 {dcache_numTCDM} {0}
    set_instance_parameter_value nios2_gen2 {setting_exportvectors} {0}
    set_instance_parameter_value nios2_gen2 {setting_usedesignware} {0}
    set_instance_parameter_value nios2_gen2 {setting_ecc_present} {0}
    set_instance_parameter_value nios2_gen2 {setting_ic_ecc_present} {1}
    set_instance_parameter_value nios2_gen2 {setting_rf_ecc_present} {1}
    set_instance_parameter_value nios2_gen2 {setting_mmu_ecc_present} {1}
    set_instance_parameter_value nios2_gen2 {setting_dc_ecc_present} {1}
    set_instance_parameter_value nios2_gen2 {setting_itcm_ecc_present} {1}
    set_instance_parameter_value nios2_gen2 {setting_dtcm_ecc_present} {1}
    set_instance_parameter_value nios2_gen2 {regfile_ramBlockType} {Automatic}
    set_instance_parameter_value nios2_gen2 {ocimem_ramBlockType} {Automatic}
    set_instance_parameter_value nios2_gen2 {ocimem_ramInit} {0}
    set_instance_parameter_value nios2_gen2 {mmu_ramBlockType} {Automatic}
    set_instance_parameter_value nios2_gen2 {bht_ramBlockType} {Automatic}
    set_instance_parameter_value nios2_gen2 {cdx_enabled} {0}
    set_instance_parameter_value nios2_gen2 {mpx_enabled} {0}
    set_instance_parameter_value nios2_gen2 {debug_enabled} {1}
    set_instance_parameter_value nios2_gen2 {debug_triggerArming} {1}
    set_instance_parameter_value nios2_gen2 {debug_debugReqSignals} {0}
    set_instance_parameter_value nios2_gen2 {debug_assignJtagInstanceID} {0}
    set_instance_parameter_value nios2_gen2 {debug_jtagInstanceID} {0}
    set_instance_parameter_value nios2_gen2 {debug_OCIOnchipTrace} {_128}
    set_instance_parameter_value nios2_gen2 {debug_hwbreakpoint} {0}
    set_instance_parameter_value nios2_gen2 {debug_datatrigger} {0}
    set_instance_parameter_value nios2_gen2 {debug_traceType} {none}
    set_instance_parameter_value nios2_gen2 {debug_traceStorage} {onchip_trace}
    set_instance_parameter_value nios2_gen2 {master_addr_map} {0}
    set_instance_parameter_value nios2_gen2 {instruction_master_paddr_base} {0}
    set_instance_parameter_value nios2_gen2 {instruction_master_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2 {flash_instruction_master_paddr_base} {0}
    set_instance_parameter_value nios2_gen2 {flash_instruction_master_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2 {data_master_paddr_base} {0}
    set_instance_parameter_value nios2_gen2 {data_master_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_instruction_master_0_paddr_base} {0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_instruction_master_0_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_instruction_master_1_paddr_base} {0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_instruction_master_1_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_instruction_master_2_paddr_base} {0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_instruction_master_2_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_instruction_master_3_paddr_base} {0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_instruction_master_3_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_data_master_0_paddr_base} {0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_data_master_0_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_data_master_1_paddr_base} {0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_data_master_1_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_data_master_2_paddr_base} {0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_data_master_2_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_data_master_3_paddr_base} {0}
    set_instance_parameter_value nios2_gen2 {tightly_coupled_data_master_3_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2 {instruction_master_high_performance_paddr_base} {0}
    set_instance_parameter_value nios2_gen2 {instruction_master_high_performance_paddr_size} {0.0}
    set_instance_parameter_value nios2_gen2 {data_master_high_performance_paddr_base} {0}
    set_instance_parameter_value nios2_gen2 {data_master_high_performance_paddr_size} {0.0}

    add_instance onchip_memory2_0 altera_avalon_onchip_memory2 16.1
    set_instance_parameter_value onchip_memory2_0 {allowInSystemMemoryContentEditor} {0}
    set_instance_parameter_value onchip_memory2_0 {blockType} {AUTO}
    set_instance_parameter_value onchip_memory2_0 {dataWidth} {32}
    set_instance_parameter_value onchip_memory2_0 {dataWidth2} {32}
    set_instance_parameter_value onchip_memory2_0 {dualPort} {0}
    set_instance_parameter_value onchip_memory2_0 {enableDiffWidth} {0}
    set_instance_parameter_value onchip_memory2_0 {initMemContent} {0}
    set_instance_parameter_value onchip_memory2_0 {initializationFileName} {onchip_mem.hex}
    set_instance_parameter_value onchip_memory2_0 {enPRInitMode} {0}
    set_instance_parameter_value onchip_memory2_0 {instanceID} {NONE}
    set_instance_parameter_value onchip_memory2_0 {memorySize} {100000.0}
    set_instance_parameter_value onchip_memory2_0 {readDuringWriteMode} {DONT_CARE}
    set_instance_parameter_value onchip_memory2_0 {simAllowMRAMContentsFile} {0}
    set_instance_parameter_value onchip_memory2_0 {simMemInitOnlyFilename} {0}
    set_instance_parameter_value onchip_memory2_0 {singleClockOperation} {0}
    set_instance_parameter_value onchip_memory2_0 {slave1Latency} {1}
    set_instance_parameter_value onchip_memory2_0 {slave2Latency} {1}
    set_instance_parameter_value onchip_memory2_0 {useNonDefaultInitFile} {0}
    set_instance_parameter_value onchip_memory2_0 {copyInitFile} {0}
    set_instance_parameter_value onchip_memory2_0 {useShallowMemBlocks} {0}
    set_instance_parameter_value onchip_memory2_0 {writable} {1}
    set_instance_parameter_value onchip_memory2_0 {ecc_enabled} {0}
    set_instance_parameter_value onchip_memory2_0 {resetrequest_enabled} {1}

    add_instance sdram altera_avalon_new_sdram_controller 16.1
    set_instance_parameter_value sdram {TAC} {5.5}
    set_instance_parameter_value sdram {TRCD} {20.0}
    set_instance_parameter_value sdram {TRFC} {70.0}
    set_instance_parameter_value sdram {TRP} {20.0}
    set_instance_parameter_value sdram {TWR} {14.0}
    set_instance_parameter_value sdram {casLatency} {3}
    set_instance_parameter_value sdram {columnWidth} {10}
    set_instance_parameter_value sdram {dataWidth} {16}
    set_instance_parameter_value sdram {generateSimulationModel} {1}
    set_instance_parameter_value sdram {initRefreshCommands} {2}
    set_instance_parameter_value sdram {model} {single_Micron_MT48LC4M32B2_7_chip}
    set_instance_parameter_value sdram {numberOfBanks} {4}
    set_instance_parameter_value sdram {numberOfChipSelects} {1}
    set_instance_parameter_value sdram {pinsSharedViaTriState} {0}
    set_instance_parameter_value sdram {powerUpDelay} {100.0}
    set_instance_parameter_value sdram {refreshPeriod} {15.625}
    set_instance_parameter_value sdram {rowWidth} {13}
    set_instance_parameter_value sdram {masteredTristateBridgeSlave} {0}
    set_instance_parameter_value sdram {TMRD} {3.0}
    set_instance_parameter_value sdram {initNOPDelay} {0.0}
    set_instance_parameter_value sdram {registerDataIn} {1}

    add_instance sw altera_avalon_pio 16.1
    set_instance_parameter_value sw {bitClearingEdgeCapReg} {0}
    set_instance_parameter_value sw {bitModifyingOutReg} {0}
    set_instance_parameter_value sw {captureEdge} {0}
    set_instance_parameter_value sw {direction} {Input}
    set_instance_parameter_value sw {edgeType} {RISING}
    set_instance_parameter_value sw {generateIRQ} {0}
    set_instance_parameter_value sw {irqType} {LEVEL}
    set_instance_parameter_value sw {resetValue} {0.0}
    set_instance_parameter_value sw {simDoTestBenchWiring} {0}
    set_instance_parameter_value sw {simDrivenValue} {0.0}
    set_instance_parameter_value sw {width} {10}

    add_instance sysid_qsys altera_avalon_sysid_qsys 16.1
    set_instance_parameter_value sysid_qsys {id} {0}

    add_instance timer altera_avalon_timer 16.1
    set_instance_parameter_value timer {alwaysRun} {0}
    set_instance_parameter_value timer {counterSize} {32}
    set_instance_parameter_value timer {fixedPeriod} {0}
    set_instance_parameter_value timer {period} {1}
    set_instance_parameter_value timer {periodUnits} {MSEC}
    set_instance_parameter_value timer {resetOutput} {0}
    set_instance_parameter_value timer {snapshot} {1}
    set_instance_parameter_value timer {timeoutPulseOutput} {0}
    set_instance_parameter_value timer {watchdogPulse} {2}

    add_instance uart_0 altera_avalon_uart 16.1
    set_instance_parameter_value uart_0 {baud} {115200}
    set_instance_parameter_value uart_0 {dataBits} {8}
    set_instance_parameter_value uart_0 {fixedBaud} {1}
    set_instance_parameter_value uart_0 {parity} {NONE}
    set_instance_parameter_value uart_0 {simCharStream} {}
    set_instance_parameter_value uart_0 {simInteractiveInputEnable} {0}
    set_instance_parameter_value uart_0 {simInteractiveOutputEnable} {0}
    set_instance_parameter_value uart_0 {simTrueBaud} {0}
    set_instance_parameter_value uart_0 {stopBits} {1}
    set_instance_parameter_value uart_0 {syncRegDepth} {2}
    set_instance_parameter_value uart_0 {useCtsRts} {0}
    set_instance_parameter_value uart_0 {useEopRegister} {0}
    set_instance_parameter_value uart_0 {useRelativePathForSimFile} {0}

    add_instance video_csc_0 altera_up_avalon_video_csc 16.1
    set_instance_parameter_value video_csc_0 {csc_type} {24-bit RGB to 444 YCrCb}

    add_instance video_csc_1 altera_up_avalon_video_csc 16.1
    set_instance_parameter_value video_csc_1 {csc_type} {444 YCrCb to 24-bit RGB}

    # connections and connection parameters
    add_connection nios2_gen2.data_master jtag_uart.avalon_jtag_slave avalon
    set_connection_parameter_value nios2_gen2.data_master/jtag_uart.avalon_jtag_slave arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2.data_master/jtag_uart.avalon_jtag_slave baseAddress {0x000410e8}
    set_connection_parameter_value nios2_gen2.data_master/jtag_uart.avalon_jtag_slave defaultConnection {0}

    add_connection nios2_gen2.data_master i2c_opencores_mipi.avalon_slave_0 avalon
    set_connection_parameter_value nios2_gen2.data_master/i2c_opencores_mipi.avalon_slave_0 arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2.data_master/i2c_opencores_mipi.avalon_slave_0 baseAddress {0x00041060}
    set_connection_parameter_value nios2_gen2.data_master/i2c_opencores_mipi.avalon_slave_0 defaultConnection {0}

    add_connection nios2_gen2.data_master i2c_opencores_camera.avalon_slave_0 avalon
    set_connection_parameter_value nios2_gen2.data_master/i2c_opencores_camera.avalon_slave_0 arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2.data_master/i2c_opencores_camera.avalon_slave_0 baseAddress {0x00041040}
    set_connection_parameter_value nios2_gen2.data_master/i2c_opencores_camera.avalon_slave_0 defaultConnection {0}

    add_connection nios2_gen2.data_master sysid_qsys.control_slave avalon
    set_connection_parameter_value nios2_gen2.data_master/sysid_qsys.control_slave arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2.data_master/sysid_qsys.control_slave baseAddress {0x000410e0}
    set_connection_parameter_value nios2_gen2.data_master/sysid_qsys.control_slave defaultConnection {0}

    add_connection nios2_gen2.data_master nios2_gen2.debug_mem_slave avalon
    set_connection_parameter_value nios2_gen2.data_master/nios2_gen2.debug_mem_slave arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2.data_master/nios2_gen2.debug_mem_slave baseAddress {0x00040800}
    set_connection_parameter_value nios2_gen2.data_master/nios2_gen2.debug_mem_slave defaultConnection {0}

    add_connection nios2_gen2.data_master TERASIC_AUTO_FOCUS_0.mm_ctrl avalon
    set_connection_parameter_value nios2_gen2.data_master/TERASIC_AUTO_FOCUS_0.mm_ctrl arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2.data_master/TERASIC_AUTO_FOCUS_0.mm_ctrl baseAddress {0x00041020}
    set_connection_parameter_value nios2_gen2.data_master/TERASIC_AUTO_FOCUS_0.mm_ctrl defaultConnection {0}

    add_connection nios2_gen2.data_master altpll_0.pll_slave avalon
    set_connection_parameter_value nios2_gen2.data_master/altpll_0.pll_slave arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2.data_master/altpll_0.pll_slave baseAddress {0x000410d0}
    set_connection_parameter_value nios2_gen2.data_master/altpll_0.pll_slave defaultConnection {0}

    add_connection nios2_gen2.data_master onchip_memory2_0.s1 avalon
    set_connection_parameter_value nios2_gen2.data_master/onchip_memory2_0.s1 arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2.data_master/onchip_memory2_0.s1 baseAddress {0x00020000}
    set_connection_parameter_value nios2_gen2.data_master/onchip_memory2_0.s1 defaultConnection {0}

    add_connection nios2_gen2.data_master timer.s1 avalon
    set_connection_parameter_value nios2_gen2.data_master/timer.s1 arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2.data_master/timer.s1 baseAddress {0x00041000}
    set_connection_parameter_value nios2_gen2.data_master/timer.s1 defaultConnection {0}

    add_connection nios2_gen2.data_master led.s1 avalon
    set_connection_parameter_value nios2_gen2.data_master/led.s1 arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2.data_master/led.s1 baseAddress {0x000410c0}
    set_connection_parameter_value nios2_gen2.data_master/led.s1 defaultConnection {0}

    add_connection nios2_gen2.data_master sw.s1 avalon
    set_connection_parameter_value nios2_gen2.data_master/sw.s1 arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2.data_master/sw.s1 baseAddress {0x000410b0}
    set_connection_parameter_value nios2_gen2.data_master/sw.s1 defaultConnection {0}

    add_connection nios2_gen2.data_master key.s1 avalon
    set_connection_parameter_value nios2_gen2.data_master/key.s1 arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2.data_master/key.s1 baseAddress {0x000410a0}
    set_connection_parameter_value nios2_gen2.data_master/key.s1 defaultConnection {0}

    add_connection nios2_gen2.data_master mipi_reset_n.s1 avalon
    set_connection_parameter_value nios2_gen2.data_master/mipi_reset_n.s1 arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2.data_master/mipi_reset_n.s1 baseAddress {0x00041090}
    set_connection_parameter_value nios2_gen2.data_master/mipi_reset_n.s1 defaultConnection {0}

    add_connection nios2_gen2.data_master mipi_pwdn_n.s1 avalon
    set_connection_parameter_value nios2_gen2.data_master/mipi_pwdn_n.s1 arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2.data_master/mipi_pwdn_n.s1 baseAddress {0x00041080}
    set_connection_parameter_value nios2_gen2.data_master/mipi_pwdn_n.s1 defaultConnection {0}

    add_connection nios2_gen2.data_master EEE_IMGPROC_0.s1 avalon
    set_connection_parameter_value nios2_gen2.data_master/EEE_IMGPROC_0.s1 arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2.data_master/EEE_IMGPROC_0.s1 baseAddress {0x00042000}
    set_connection_parameter_value nios2_gen2.data_master/EEE_IMGPROC_0.s1 defaultConnection {0}

    add_connection nios2_gen2.data_master uart_0.s1 avalon
    set_connection_parameter_value nios2_gen2.data_master/uart_0.s1 arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2.data_master/uart_0.s1 baseAddress {0x00042020}
    set_connection_parameter_value nios2_gen2.data_master/uart_0.s1 defaultConnection {0}

    add_connection nios2_gen2.instruction_master nios2_gen2.debug_mem_slave avalon
    set_connection_parameter_value nios2_gen2.instruction_master/nios2_gen2.debug_mem_slave arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2.instruction_master/nios2_gen2.debug_mem_slave baseAddress {0x00040800}
    set_connection_parameter_value nios2_gen2.instruction_master/nios2_gen2.debug_mem_slave defaultConnection {0}

    add_connection nios2_gen2.instruction_master onchip_memory2_0.s1 avalon
    set_connection_parameter_value nios2_gen2.instruction_master/onchip_memory2_0.s1 arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2.instruction_master/onchip_memory2_0.s1 baseAddress {0x00020000}
    set_connection_parameter_value nios2_gen2.instruction_master/onchip_memory2_0.s1 defaultConnection {0}

    add_connection nios2_gen2.instruction_master uart_0.s1 avalon
    set_connection_parameter_value nios2_gen2.instruction_master/uart_0.s1 arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2.instruction_master/uart_0.s1 baseAddress {0x00042020}
    set_connection_parameter_value nios2_gen2.instruction_master/uart_0.s1 defaultConnection {0}

    add_connection nios2_gen2.instruction_master EEE_IMGPROC_1.s1 avalon
    set_connection_parameter_value nios2_gen2.instruction_master/EEE_IMGPROC_1.s1 arbitrationPriority {1}
    set_connection_parameter_value nios2_gen2.instruction_master/EEE_IMGPROC_1.s1 baseAddress {0x00042040}
    set_connection_parameter_value nios2_gen2.instruction_master/EEE_IMGPROC_1.s1 defaultConnection {0}

    add_connection alt_vip_vfb_0.read_master sdram.s1 avalon
    set_connection_parameter_value alt_vip_vfb_0.read_master/sdram.s1 arbitrationPriority {50}
    set_connection_parameter_value alt_vip_vfb_0.read_master/sdram.s1 baseAddress {0x04000000}
    set_connection_parameter_value alt_vip_vfb_0.read_master/sdram.s1 defaultConnection {0}

    add_connection alt_vip_vfb_0.write_master sdram.s1 avalon
    set_connection_parameter_value alt_vip_vfb_0.write_master/sdram.s1 arbitrationPriority {30}
    set_connection_parameter_value alt_vip_vfb_0.write_master/sdram.s1 baseAddress {0x04000000}
    set_connection_parameter_value alt_vip_vfb_0.write_master/sdram.s1 defaultConnection {0}

    add_connection video_csc_0.avalon_csc_source EEE_IMGPROC_1.avalon_streaming_sink avalon_streaming

    add_connection video_csc_1.avalon_csc_source EEE_IMGPROC_0.avalon_streaming_sink avalon_streaming

    add_connection EEE_IMGPROC_1.avalon_streaming_source video_csc_1.avalon_csc_sink avalon_streaming

    add_connection TERASIC_CAMERA_0.avalon_streaming_source alt_vip_vfb_0.din avalon_streaming

    add_connection EEE_IMGPROC_0.avalon_streaming_source alt_vip_itc_0.din avalon_streaming

    add_connection TERASIC_AUTO_FOCUS_0.dout video_csc_0.avalon_csc_sink avalon_streaming

    add_connection alt_vip_vfb_0.dout TERASIC_AUTO_FOCUS_0.din avalon_streaming

    add_connection altpll_0.c2 sdram.clk clock

    add_connection altpll_0.c2 video_csc_0.clk clock

    add_connection altpll_0.c2 video_csc_1.clk clock

    add_connection altpll_0.c2 TERASIC_AUTO_FOCUS_0.clock clock

    add_connection altpll_0.c2 alt_vip_vfb_0.clock clock

    add_connection altpll_0.c2 EEE_IMGPROC_0.clock clock

    add_connection altpll_0.c2 EEE_IMGPROC_1.clock clock

    add_connection altpll_0.c2 TERASIC_CAMERA_0.clock_reset clock

    add_connection altpll_0.c2 alt_vip_itc_0.is_clk_rst clock

    add_connection clk_50.clk jtag_uart.clk clock

    add_connection clk_50.clk sysid_qsys.clk clock

    add_connection clk_50.clk timer.clk clock

    add_connection clk_50.clk led.clk clock

    add_connection clk_50.clk sw.clk clock

    add_connection clk_50.clk key.clk clock

    add_connection clk_50.clk mipi_reset_n.clk clock

    add_connection clk_50.clk mipi_pwdn_n.clk clock

    add_connection clk_50.clk nios2_gen2.clk clock

    add_connection clk_50.clk uart_0.clk clock

    add_connection clk_50.clk onchip_memory2_0.clk1 clock

    add_connection clk_50.clk i2c_opencores_mipi.clock clock

    add_connection clk_50.clk i2c_opencores_camera.clock clock

    add_connection clk_50.clk altpll_0.inclk_interface clock

    add_connection nios2_gen2.irq i2c_opencores_mipi.interrupt_sender interrupt
    set_connection_parameter_value nios2_gen2.irq/i2c_opencores_mipi.interrupt_sender irqNumber {0}

    add_connection nios2_gen2.irq i2c_opencores_camera.interrupt_sender interrupt
    set_connection_parameter_value nios2_gen2.irq/i2c_opencores_camera.interrupt_sender irqNumber {1}

    add_connection nios2_gen2.irq jtag_uart.irq interrupt
    set_connection_parameter_value nios2_gen2.irq/jtag_uart.irq irqNumber {2}

    add_connection nios2_gen2.irq timer.irq interrupt
    set_connection_parameter_value nios2_gen2.irq/timer.irq irqNumber {3}

    add_connection nios2_gen2.irq uart_0.irq interrupt
    set_connection_parameter_value nios2_gen2.irq/uart_0.irq irqNumber {4}

    add_connection clk_50.clk_reset i2c_opencores_mipi.clock_reset reset

    add_connection clk_50.clk_reset i2c_opencores_camera.clock_reset reset

    add_connection clk_50.clk_reset TERASIC_CAMERA_0.clock_reset_reset reset

    add_connection clk_50.clk_reset altpll_0.inclk_interface_reset reset

    add_connection clk_50.clk_reset alt_vip_itc_0.is_clk_rst_reset reset

    add_connection clk_50.clk_reset sdram.reset reset

    add_connection clk_50.clk_reset nios2_gen2.reset reset

    add_connection clk_50.clk_reset alt_vip_vfb_0.reset reset

    add_connection clk_50.clk_reset jtag_uart.reset reset

    add_connection clk_50.clk_reset key.reset reset

    add_connection clk_50.clk_reset led.reset reset

    add_connection clk_50.clk_reset mipi_pwdn_n.reset reset

    add_connection clk_50.clk_reset mipi_reset_n.reset reset

    add_connection clk_50.clk_reset sw.reset reset

    add_connection clk_50.clk_reset sysid_qsys.reset reset

    add_connection clk_50.clk_reset timer.reset reset

    add_connection clk_50.clk_reset TERASIC_AUTO_FOCUS_0.reset reset

    add_connection clk_50.clk_reset EEE_IMGPROC_0.reset reset

    add_connection clk_50.clk_reset uart_0.reset reset

    add_connection clk_50.clk_reset video_csc_0.reset reset

    add_connection clk_50.clk_reset video_csc_1.reset reset

    add_connection clk_50.clk_reset EEE_IMGPROC_1.reset reset

    add_connection clk_50.clk_reset onchip_memory2_0.reset1 reset

    add_connection nios2_gen2.debug_reset_request i2c_opencores_mipi.clock_reset reset

    add_connection nios2_gen2.debug_reset_request i2c_opencores_camera.clock_reset reset

    add_connection nios2_gen2.debug_reset_request TERASIC_CAMERA_0.clock_reset_reset reset

    add_connection nios2_gen2.debug_reset_request alt_vip_itc_0.is_clk_rst_reset reset

    add_connection nios2_gen2.debug_reset_request jtag_uart.reset reset

    add_connection nios2_gen2.debug_reset_request sysid_qsys.reset reset

    add_connection nios2_gen2.debug_reset_request timer.reset reset

    add_connection nios2_gen2.debug_reset_request led.reset reset

    add_connection nios2_gen2.debug_reset_request sw.reset reset

    add_connection nios2_gen2.debug_reset_request key.reset reset

    add_connection nios2_gen2.debug_reset_request mipi_reset_n.reset reset

    add_connection nios2_gen2.debug_reset_request mipi_pwdn_n.reset reset

    add_connection nios2_gen2.debug_reset_request nios2_gen2.reset reset

    add_connection nios2_gen2.debug_reset_request sdram.reset reset

    add_connection nios2_gen2.debug_reset_request alt_vip_vfb_0.reset reset

    add_connection nios2_gen2.debug_reset_request TERASIC_AUTO_FOCUS_0.reset reset

    add_connection nios2_gen2.debug_reset_request EEE_IMGPROC_0.reset reset

    add_connection nios2_gen2.debug_reset_request onchip_memory2_0.reset1 reset

    # exported interfaces
    add_interface alt_vip_itc_0_clocked_video conduit end
    set_interface_property alt_vip_itc_0_clocked_video EXPORT_OF alt_vip_itc_0.clocked_video
    add_interface altpll_0_areset_conduit conduit end
    set_interface_property altpll_0_areset_conduit EXPORT_OF altpll_0.areset_conduit
    add_interface altpll_0_locked_conduit conduit end
    set_interface_property altpll_0_locked_conduit EXPORT_OF altpll_0.locked_conduit
    add_interface clk clock sink
    set_interface_property clk EXPORT_OF clk_50.clk_in
    add_interface clk_sdram clock source
    set_interface_property clk_sdram EXPORT_OF altpll_0.c1
    add_interface clk_vga clock source
    set_interface_property clk_vga EXPORT_OF altpll_0.c3
    add_interface d8m_xclkin clock source
    set_interface_property d8m_xclkin EXPORT_OF altpll_0.c4
    add_interface eee_imgproc_0_conduit_mode conduit end
    set_interface_property eee_imgproc_0_conduit_mode EXPORT_OF EEE_IMGPROC_0.conduit_mode
    add_interface eee_imgproc_1_conduit_mode conduit end
    set_interface_property eee_imgproc_1_conduit_mode EXPORT_OF EEE_IMGPROC_1.conduit_mode
    add_interface i2c_opencores_camera_export conduit end
    set_interface_property i2c_opencores_camera_export EXPORT_OF i2c_opencores_camera.export
    add_interface i2c_opencores_mipi_export conduit end
    set_interface_property i2c_opencores_mipi_export EXPORT_OF i2c_opencores_mipi.export
    add_interface key_external_connection conduit end
    set_interface_property key_external_connection EXPORT_OF key.external_connection
    add_interface led_external_connection conduit end
    set_interface_property led_external_connection EXPORT_OF led.external_connection
    add_interface mipi_pwdn_n_external_connection conduit end
    set_interface_property mipi_pwdn_n_external_connection EXPORT_OF mipi_pwdn_n.external_connection
    add_interface mipi_reset_n_external_connection conduit end
    set_interface_property mipi_reset_n_external_connection EXPORT_OF mipi_reset_n.external_connection
    add_interface reset reset sink
    set_interface_property reset EXPORT_OF clk_50.clk_in_reset
    add_interface sdram_wire conduit end
    set_interface_property sdram_wire EXPORT_OF sdram.wire
    add_interface sw_external_connection conduit end
    set_interface_property sw_external_connection EXPORT_OF sw.external_connection
    add_interface terasic_auto_focus_0_conduit conduit end
    set_interface_property terasic_auto_focus_0_conduit EXPORT_OF TERASIC_AUTO_FOCUS_0.Conduit
    add_interface terasic_camera_0_conduit_end conduit end
    set_interface_property terasic_camera_0_conduit_end EXPORT_OF TERASIC_CAMERA_0.conduit_end
    add_interface uart_0_external_connection conduit end
    set_interface_property uart_0_external_connection EXPORT_OF uart_0.external_connection

    # interconnect requirements
    set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
    set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}
    set_interconnect_requirement {$system} {qsys_mm.enableEccProtection} {FALSE}
    set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}
}
