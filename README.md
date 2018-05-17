# txtMap
Tool for hexadecimal text data mapping.  
https://github.com/YujiSODE/txtMap
>Copyright (c) 2017 Yuji SODE \<yuji.sode@gmail.com\>  
>This software is released under the MIT License.  
>See LICENSE or http://opensource.org/licenses/mit-license.php
______
## 1. Synopsis
- `::txtMap::outputMap hexTxt W fileName;`  
  it outputs mapping result
- `::txtMap::outputHexMap cMap fileName;`  
  it outputs mapping result in hexadecimals

**Parameters**  
- `$hexTxt`: utf-8 encoded string that is composed of hexadecimal characters (`0-1` and `a-f`)  
  and newline character (Unicode `U+00000A`)
- `$cMap`: unicode character map output by `::txtMap::outputMap` or `::txtMap::hexToMap`
- `$W`: the maximum integer length for output string
- `$fileName`: name of output file

**Script**  
- `txtMap.tcl`

## 2. Library list
- to4bit/to4bit.tcl (Yuji SODE,2018): the MIT License; https://gist.github.com/YujiSODE/448704a261f872865f6bfa9344aaabd9
