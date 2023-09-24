#importonce 

// Colors

.const BLACK = 0
.const WHITE = 1
.const RED = 2
.const CYAN = 3
.const PURPLE = 4
.const GREEN = 5
.const BLUE = 6
.const YELLOW = 7
.const ORANGE = 8
.const BROWN = 9
.const LIGHT_RED = 10
.const DARK_GRAY = 11
.const GRAY = 12
.const LIGHT_GREEN = 13
.const LIGHT_BLUE = 14
.const LIGHT_GRAY = 15

// SID Chip (Kernel ROM must be enabled)

.const SID_VOICE3_LB = $d40e                // Voice 3 lowbyte frequency
.const SID_VOICE3_CTRL = $d412              // Voice 3 control register ( to select wave type )
.const SID_WAV_NOISE = $80                  // 128 dec, when put in voice 3 control register it will select noise wave type
.const SID_OSC3_R0 = $d41b                  // this will contain the amplitude value of the noise at the moment of reading ( because wave is noise )

