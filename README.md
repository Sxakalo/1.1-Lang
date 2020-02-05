# 1.1-Lang
Perl interpreter for esolang [1.1](https://esolangs.org/wiki/1.1)

More info can be found at: https://esolangs.org/wiki/1.1

Can be run from the commandline in the form: `perl main.pl <commandline args> <scriptfile>`

I have created a very simple batch script for Windows so you can run `1p1 <commandline args> <scriptfile>` instead.
Creating other equally simple shell scripts should not be a problem.

## Commandline Args:
+ `-D` = Turn on debug mode.

## Script Format:

The first line should be:
`1|<starting buffer or nothing>`

+ `1` being the number of the state followed by a pipe `|` then the starting buffer. 
+ If the starting buffer is empty, it takes the starting buffer from STDIN.

The rest of the lines should be in the form:
`#1|<needle>|<replacement>|#t|#f`

+ `#1` is the state number (this should correspond to the line number in the file.)
+ `<needle>` is the string to search the buffer for (without the brackets).
+ `<replacement>` is the string to replace the `<needle>` if the `<needle>` is found.
+ `<#t>` is the state number to jump to if `<needle>` is found.
+ `<#f>` is the state number to jump to if `<needle>` is NOT found.

The last line must be in the form:
`#|Halt`

+ `#` being the final state number

## Examples
These are included in this repo.

### Hello World

    1|Good morning you!
    2|Good morning|Hello|3|4
    3|you|World|4|4
    4|halt

1. The buffer is set to `Good morning you!`.
2. `Good morning` is found and replaced by `Hello`.
3. `you` is found and relaced by `World`.
4. `halt` stops the program.

### Cat

    1|
    2|HALT

### Binary Incrementer
A conversion of the [Thue example](https://esolangs.org/wiki/thue)

    1|_11_
    2|1_|1++|2|3
    3|0_|1|3|4
    4|01++|10|4|5
    5|11++|1++0|5|6
    6|_0|_|6|7
    7|_1++|10|7|8
    8|HALT

### Roman Numeral Converter
Also a conversion of the [Thue example](https://esolangs.org/wiki/thue)

    1|**************
    2|*|I|2|3
    3|IIIII|V|3|4
    4|IIII|IV|4|5
    5|VV|X|5|6
    6|XXXXX|L|6|7
    7|XXXX|XL|7|8
    8|LL|C|8|9
    9|LXL|XC|9|10
    10|CCCCC|D|10|11
    11|CCCC|CD|11|12
    12|DD|M|12|13
    13|DCD|CM|13|14
    14|HALT
