#txtMap
#txtMap.tcl
##===================================================================
#	Copyright (c) 2018 Yuji SODE <yuji.sode@gmail.com>
#
#	This software is released under the MIT License.
#	See LICENSE or http://opensource.org/licenses/mit-license.php
##===================================================================
#Tool for hexadecimal text data mapping.
#=== <Namespace: txtMap> ===
	#== Values ==
		# - $toChar: an array of hexadecimal elements and unicode characters
		# - $toHex: an array of unicode character elements and hexadecimal values
	#== Procedures ==
		#
		#++++++ output ++++++
		# - ::txtMap::outputMap hexTxt W fileName;
			#it outputs mapping result
			# - $hexTxt: utf-8 encoded string that is composed of hexadecimal characters (0-1 and a-f) and newline character (Unicode U+00000A)
			# - $W: the maximum integer length for output string
			# - $fileName: name of output file
		#
		# - ::txtMap::outputHexMap cMap fileName;
			#it outputs hexadecimal map converted from unicode character map
			# - $cMap: unicode character map output by `::txtMap::outputMap` or `::txtMap::hexToMap`
			# - $fileName: name of output file
		#
		#++++++ Hexadecimal scale ++++++  
		# - scale ?L1 ?R1 ?L2 ?R2????;
			#it returns hexadecimal scale
			# - $L1 and $L2: optional left characters
			# - $R1 and $R2: optional right characters
		#
		#++++++++++++++++++++
		# - ::txtMap::to4bitHex list ?Min ?Max??;
			#it converts nummerical list into a 4-bit hexadecimal string
			#`to4bitHex` is modified version of `to4bit.tcl` (Yuji SODE,2018)
			# - $list: a numerical list
			# - $Min and $Max: minimum and maximum integers
			#   0 and 15 are default values
			# - to4bit/to4bit.tcl (Yuji SODE,2018): the MIT License; https://gist.github.com/YujiSODE/448704a261f872865f6bfa9344aaabd9
		#
		# - ::txtMap::hexToMap hexTxt W;
			#it returns unicode character map using given hexadecimal string and width
			# - $hexTxt: utf-8 encoded string that is composed of hexadecimal characters (0-1 and a-f) and newline character (Unicode U+00000A)
			# - $W: the maximum integer length for output string
		#
		# - ::txtMap::mapToHex cMap;
			#it returns hexadecimal map converted from unicode character map output by `::txtMap::hexToMap`
			# - $cMap: unicode character map output by `::txtMap::hexToMap`
##===================================================================
set auto_noexec 1;
package require Tcl 8.6;
#=== <Namespace: txtMap> ===
namespace eval ::txtMap {
	#****** Variables ******
	# - $toChar: an array of hexadecimal elements and unicode characters
	# - $toHex: an array of unicode character elements and hexadecimal values
	variable toChar;array set toChar {};
	variable toHex;array set toHex {};
	#+++ hexadecimal values to unicode characters +++
	set toChar(0) \u2b1a;
	set toChar(1) \u25a1;
	set toChar(2) \u25eb;
	set toChar(3) \u25a4;
	set toChar(4) \u25a5;
	set toChar(5) \u25a6;
	set toChar(6) \u25a7;
	set toChar(7) \u25a8;
	set toChar(8) \u25a9;
	set toChar(9) \u25a3;
	set toChar(a) \u25a0;
	set toChar(b) \u25e9;
	set toChar(c) \u25c6;
	set toChar(d) \u25c7;
	set toChar(e) \u25c8;
	set toChar(f) \u25ec;
	set toChar(\u0020) \u0020;
	#+++ unicode characters to hexadecimal values +++
	set toHex(\u2b1a) 0;
	set toHex(\u25a1) 1;
	set toHex(\u25eb) 2;
	set toHex(\u25a4) 3;
	set toHex(\u25a5) 4;
	set toHex(\u25a6) 5;
	set toHex(\u25a7) 6;
	set toHex(\u25a8) 7;
	set toHex(\u25a9) 8;
	set toHex(\u25a3) 9;
	set toHex(\u25a0) a;
	set toHex(\u25e9) b;
	set toHex(\u25c6) c;
	set toHex(\u25c7) d;
	set toHex(\u25c8) e;
	set toHex(\u25ec) f;
	set toHex(\u0020) \u0020;
	#****** Procedures ******
	#it converts nummerical list into a 4-bit hexadecimal string
	#`to4bitHex` is modified version of `to4bit.tcl` (Yuji SODE,2018)
	# - to4bit/to4bit.tcl (Yuji SODE,2018): the MIT License; https://gist.github.com/YujiSODE/448704a261f872865f6bfa9344aaabd9
	proc to4bitHex {list {Min 0} {Max 15}} {
		# - $list: a numerical list
		# - $Min and $Max: minimum and maximum integers
		#   0 and 15 are default values
		set dx [expr {(int($Max)-int($Min)+1)/16.0}];
		set L {};
		set i 0;set v 0;
		foreach e $list {
			set i 0;set v 0;
			#classifing into 0 to 15
			set v [expr {!($Min+$dx>$e)&&($Min+2*$dx>$e)?1:$v}];
			set v [expr {!($Min+2*$dx>$e)&&($Min+3*$dx>$e)?2:$v}];
			set v [expr {!($Min+3*$dx>$e)&&($Min+4*$dx>$e)?3:$v}];
			set v [expr {!($Min+4*$dx>$e)&&($Min+5*$dx>$e)?4:$v}];
			set v [expr {!($Min+5*$dx>$e)&&($Min+6*$dx>$e)?5:$v}];
			set v [expr {!($Min+6*$dx>$e)&&($Min+7*$dx>$e)?6:$v}];
			set v [expr {!($Min+7*$dx>$e)&&($Min+8*$dx>$e)?7:$v}];
			set v [expr {!($Min+8*$dx>$e)&&($Min+9*$dx>$e)?8:$v}];
			set v [expr {!($Min+9*$dx>$e)&&($Min+10*$dx>$e)?9:$v}];
			set v [expr {!($Min+10*$dx>$e)&&($Min+11*$dx>$e)?10:$v}];
			set v [expr {!($Min+11*$dx>$e)&&($Min+12*$dx>$e)?11:$v}];
			set v [expr {!($Min+12*$dx>$e)&&($Min+13*$dx>$e)?12:$v}];
			set v [expr {!($Min+13*$dx>$e)&&($Min+14*$dx>$e)?13:$v}];
			set v [expr {!($Min+14*$dx>$e)&&($Min+15*$dx>$e)?14:$v}];
			set v [expr {!($Min+15*$dx>$e)?15:$v}];
			append L [format %x $v];
		};
		unset dx;return $L;
	};
	#it returns hexadecimal scale
	proc scale {{L1 {}} {R1 {}} {L2 {}} {R2 {}}} {
		# - $L1 and $L2: optional left characters
		# - $R1 and $R2: optional right characters
		return "${L1}0123456789abcdef${R1}\n${L2}\u2b1a\u25a1\u25eb\u25a4\u25a5\u25a6\u25a7\u25a8\u25a9\u25a3\u25a0\u25e9\u25c6\u25c7\u25c8\u25ec${R2}";
	};
	#it returns unicode character map using given hexadecimal string and width
	proc hexToMap {hexTxt W} {
		# - $hexTxt: utf-8 encoded string that is composed of hexadecimal characters (0-1 and a-f) and newline character (Unicode U+00000A)
		# - $W: the maximum integer length for output string
		variable toChar;
		#output width is 2 or longer
		set W [expr {$W<2?2:int($W)}];
		set charMap [array get toChar];
		set L 0;
		set txt {};
		#formatting output data list
		foreach e [split [string map $charMap $hexTxt] \n] {
			set L [string length $e];
			set L [expr {$L%$W>0?$L+$W-$L%$W:$L}];
			set i 0;
			while {$i<$L} {
				lappend txt [string range $e $i [expr {$i+$W-1}]];
				incr i $W;
			};
		};
		return [join $txt \n];
	};
	#it returns hexadecimal map converted from unicode character map output by `::txtMap::hexToMap`
	proc mapToHex {cMap} {
		# - $cMap: unicode character map output by `::txtMap::hexToMap`
		variable toHex;
		set charMap [array get toHex];
		return [string map $charMap $cMap];
	};
	#it outputs mapping result
	proc outputMap {hexTxt W fileName} {
		# - $hexTxt: utf-8 encoded string that is composed of hexadecimal characters (0-1 and a-f) and newline character (Unicode U+00000A)
		# - $W: the maximum integer length for output string
		# - $fileName: name of output file
		set C [open $fileName w];
		fconfigure $C -encoding utf-8;
		puts -nonewline $C [::txtMap::hexToMap $hexTxt $W];
		close $C;unset C;
		return $fileName;
	};
	#it outputs hexadecimal map converted from unicode character map
	proc outputHexMap {cMap fileName} {
		# - $cMap: unicode character map output by `::txtMap::outputMap` or `::txtMap::hexToMap`
		# - $fileName: name of output file
		set C [open $fileName w];
		fconfigure $C -encoding utf-8;
		puts -nonewline $C [::txtMap::mapToHex $cMap];
		close $C;unset C;
		return $fileName;
	};
};
