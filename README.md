# txtMap
Tool for hexadecimal text data mapping.  
GitHub: https://github.com/YujiSODE/txtMap
>Copyright (c) 2017 Yuji SODE \<yuji.sode@gmail.com\>  
>This software is released under the MIT License.  
>See LICENSE or http://opensource.org/licenses/mit-license.php
______
## 1. Synopsis
### Output
- `::txtMap::outputMap hexTxt W fileName;`  
  it outputs mapping result
- `::txtMap::outputHexMap cMap fileName;`  
  it outputs hexadecimal map converted from unicode character map

**Parameters**  
- `$hexTxt`: utf-8 encoded string that is composed of hexadecimal characters (`0-1` and `a-f`)  
  and newline character (Unicode `U+00000A`)
- `$cMap`: unicode character map output by `::txtMap::outputMap` or `::txtMap::hexToMap`
- `$W`: the maximum integer length for output string
- `$fileName`: name of output file

### Hexadecimal scale
- `scale ?L1 ?R1 ?L2 ?R2????;`  
  it returns hexadecimal scale

**Parameters**  
- `$L1` and `$L2`: optional left characters
- `$R1` and `$R2`: optional right characters

### Others
- `::txtMap::to4bitHex list ?Min ?Max??;`  
  it converts nummerical list into a 4-bit hexadecimal string  
  `to4bitHex` is modified version of `to4bit.tcl` (Yuji SODE,2018)

**Parameters**  
- `$list`: a numerical list
- `$Min` and `$Max`: minimum and maximum integers  
  0 and 15 are default values

- `::txtMap::hexToMap hexTxt W;`  
  it returns unicode character map using given hexadecimal string and width
- `::txtMap::mapToHex cMap;`  
  it returns hexadecimal map converted from unicode character map output by `::txtMap::hexToMap`

**Parameters**  
- `$hexTxt`: utf-8 encoded string that is composed of hexadecimal characters (0-1 and a-f) and newline character (Unicode U+00000A)
- `$cMap`: unicode character map output by `::txtMap::hexToMap`
- `$W`: the maximum integer length for output string

- `::txtMap::rule ?v1 v2?;`  
  it sets a new rule and returns this new rule as a list  
  it returns the current rules a list when arguments are not specified

**Parameters**  
- `$v1` and `$v2`: optional values

## 2. Script
- `txtMap.tcl`

## 3. Library list
- to4bit/to4bit.tcl (Yuji SODE,2018): the MIT License; https://gist.github.com/YujiSODE/448704a261f872865f6bfa9344aaabd9
