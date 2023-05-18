/*
 *                        .
 *       .__      .______/|    .____ ____.          .___ __.
 *  _____\  \ ___/_   \  _|____\____Y  __/____ _____\   Y  /__.
 * /  _   \  X    /    \       X    |  \      X  _   \  |  ___/---.
 * |  \      |   /     l____    >   |         |  \      |  \      |
 * | ::..  __l__/ ::.__|  / .: /:.__l__  ..:: | ::..  __l__  ..:: |
 * l______ /  \______/   /___ /| _/   \ ______l______ /   \ ______|
 *       \/                 \/ |/      \/           \/     \/   x0!
 *
 * ansicat: cp437 decoder. display ansi art in modern utf8 shells
 * cc0 / kopimi: unixbros (dcat & x0)
 * install:
 *  $ printf "all: ansicat\n" > Makefile && make
 * usage:
 *  $ ansicat < rad-shit.ans
 */

#include <locale.h>
#include <stdio.h>
#include <wchar.h>

int table[] = {
    /* ascii */
    '\x00', '\x01', '\x02', '\x03', '\x04', '\x05', '\x06', '\x07', '\x08',
    '\t',   '\n',   '\x0b', '\x0c', '\r',   '\x0e', '\x0f', '\x10', '\x11',
    '\x12', '\x13', '\x14', '\x15', '\x16', '\x17', '\x18', '\x19', '\x1a',
    '\x1b', '\x1c', '\x1d', '\x1e', '\x1f', ' ',    '!',    '"',    '#',
    '$',    '%',    '&',    '\'',   '(',    ')',    '*',    '+',    ',',
    '-',    '.',    '/',    '0',    '1',    '2',    '3',    '4',    '5',
    '6',    '7',    '8',    '9',    ':',    ';',    '<',    '=',    '>',
    '?',    '@',    'A',    'B',    'C',    'D',    'E',    'F',    'G',
    'H',    'I',    'J',    'K',    'L',    'M',    'N',    'O',    'P',
    'Q',    'R',    'S',    'T',    'U',    'V',    'W',    'X',    'Y',
    'Z',    '[',    '\\',   ']',    '^',    '_',    '`',    'a',    'b',
    'c',    'd',    'e',    'f',    'g',    'h',    'i',    'j',    'k',
    'l',    'm',    'n',    'o',    'p',    'q',    'r',    's',    't',
    'u',    'v',    'w',    'x',    'y',    'z',    '{',    '|',    '}',
    '~',    '\x7f',

    '\xc7', /* 0x0080 -> LATIN CAPITAL LETTER C WITH CEDILLA*/
    '\xfc', /* 0x0081 -> LATIN SMALL LETTER U WITH DIAERESIS*/
    '\xe9', /* 0x0082 -> LATIN SMALL LETTER E WITH ACUTE*/
    '\xe2', /* 0x0083 -> LATIN SMALL LETTER A WITH CIRCUMFLEX*/
    '\xe4', /* 0x0084 -> LATIN SMALL LETTER A WITH DIAERESIS*/
    '\xe0', /* 0x0085 -> LATIN SMALL LETTER A WITH GRAVE*/
    '\xe5', /* 0x0086 -> LATIN SMALL LETTER A WITH RING ABOVE*/
    '\xe7', /* 0x0087 -> LATIN SMALL LETTER C WITH CEDILLA*/
    '\xea', /* 0x0088 -> LATIN SMALL LETTER E WITH CIRCUMFLEX*/
    '\xeb', /* 0x0089 -> LATIN SMALL LETTER E WITH DIAERESIS*/
    '\xe8', /* 0x008a -> LATIN SMALL LETTER E WITH GRAVE*/
    '\xef', /* 0x008b -> LATIN SMALL LETTER I WITH DIAERESIS*/
    '\xee', /* 0x008c -> LATIN SMALL LETTER I WITH CIRCUMFLEX*/
    '\xec', /* 0x008d -> LATIN SMALL LETTER I WITH GRAVE*/
    '\xc4', /* 0x008e -> LATIN CAPITAL LETTER A WITH DIAERESIS*/
    '\xc5', /* 0x008f -> LATIN CAPITAL LETTER A WITH RING ABOVE*/
    '\xc9', /* 0x0090 -> LATIN CAPITAL LETTER E WITH ACUTE*/
    '\xe6', /* 0x0091 -> LATIN SMALL LIGATURE AE*/
    '\xc6', /* 0x0092 -> LATIN CAPITAL LIGATURE AE*/
    '\xf4', /* 0x0093 -> LATIN SMALL LETTER O WITH CIRCUMFLEX*/
    '\xf6', /* 0x0094 -> LATIN SMALL LETTER O WITH DIAERESIS*/
    '\xf2', /* 0x0095 -> LATIN SMALL LETTER O WITH GRAVE*/
    '\xfb', /* 0x0096 -> LATIN SMALL LETTER U WITH CIRCUMFLEX*/
    '\xf9', /* 0x0097 -> LATIN SMALL LETTER U WITH GRAVE*/
    '\xff', /* 0x0098 -> LATIN SMALL LETTER Y WITH DIAERESIS*/
    '\xd6', /* 0x0099 -> LATIN CAPITAL LETTER O WITH DIAERESIS*/
    '\xdc', /* 0x009a -> LATIN CAPITAL LETTER U WITH DIAERESIS*/
    '\xa2', /* 0x009b -> CENT SIGN*/
    '\xa3', /* 0x009c -> POUND SIGN*/
    '\xa5', /* 0x009d -> YEN SIGN*/
    0x20a7, /* 0x009e -> PESETA SIGN*/
    0x0192, /* 0x009f -> LATIN SMALL LETTER F WITH HOOK*/
    '\xe1', /* 0x00a0 -> LATIN SMALL LETTER A WITH ACUTE*/
    '\xed', /* 0x00a1 -> LATIN SMALL LETTER I WITH ACUTE*/
    '\xf3', /* 0x00a2 -> LATIN SMALL LETTER O WITH ACUTE*/
    '\xfa', /* 0x00a3 -> LATIN SMALL LETTER U WITH ACUTE*/
    '\xf1', /* 0x00a4 -> LATIN SMALL LETTER N WITH TILDE*/
    '\xd1', /* 0x00a5 -> LATIN CAPITAL LETTER N WITH TILDE*/
    '\xaa', /* 0x00a6 -> FEMININE ORDINAL INDICATOR*/
    '\xba', /* 0x00a7 -> MASCULINE ORDINAL INDICATOR*/
    '\xbf', /* 0x00a8 -> INVERTED QUESTION MARK*/
    0x2310, /* 0x00a9 -> REVERSED NOT SIGN*/
    '\xac', /* 0x00aa -> NOT SIGN*/
    '\xbd', /* 0x00ab -> VULGAR FRACTION ONE HALF*/
    '\xbc', /* 0x00ac -> VULGAR FRACTION ONE QUARTER*/
    '\xa1', /* 0x00ad -> INVERTED EXCLAMATION MARK*/
    '\xab', /* 0x00ae -> LEFT-POINTING DOUBLE ANGLE QUOTATION MARK*/
    '\xbb', /* 0x00af -> RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK*/
    0x2591, /* 0x00b0 -> LIGHT SHADE*/
    0x2592, /* 0x00b1 -> MEDIUM SHADE*/
    0x2593, /* 0x00b2 -> DARK SHADE*/
    0x2502, /* 0x00b3 -> BOX DRAWINGS LIGHT VERTICAL*/
    0x2524, /* 0x00b4 -> BOX DRAWINGS LIGHT VERTICAL AND LEFT*/
    0x2561, /* 0x00b5 -> BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE*/
    0x2562, /* 0x00b6 -> BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE*/
    0x2556, /* 0x00b7 -> BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE*/
    0x2555, /* 0x00b8 -> BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE*/
    0x2563, /* 0x00b9 -> BOX DRAWINGS DOUBLE VERTICAL AND LEFT*/
    0x2551, /* 0x00ba -> BOX DRAWINGS DOUBLE VERTICAL*/
    0x2557, /* 0x00bb -> BOX DRAWINGS DOUBLE DOWN AND LEFT*/
    0x255d, /* 0x00bc -> BOX DRAWINGS DOUBLE UP AND LEFT*/
    0x255c, /* 0x00bd -> BOX DRAWINGS UP DOUBLE AND LEFT SINGLE*/
    0x255b, /* 0x00be -> BOX DRAWINGS UP SINGLE AND LEFT DOUBLE*/
    0x2510, /* 0x00bf -> BOX DRAWINGS LIGHT DOWN AND LEFT*/
    0x2514, /* 0x00c0 -> BOX DRAWINGS LIGHT UP AND RIGHT*/
    0x2534, /* 0x00c1 -> BOX DRAWINGS LIGHT UP AND HORIZONTAL*/
    0x252c, /* 0x00c2 -> BOX DRAWINGS LIGHT DOWN AND HORIZONTAL*/
    0x251c, /* 0x00c3 -> BOX DRAWINGS LIGHT VERTICAL AND RIGHT*/
    0x2500, /* 0x00c4 -> BOX DRAWINGS LIGHT HORIZONTAL*/
    0x253c, /* 0x00c5 -> BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL*/
    0x255e, /* 0x00c6 -> BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE*/
    0x255f, /* 0x00c7 -> BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE*/
    0x255a, /* 0x00c8 -> BOX DRAWINGS DOUBLE UP AND RIGHT*/
    0x2554, /* 0x00c9 -> BOX DRAWINGS DOUBLE DOWN AND RIGHT*/
    0x2569, /* 0x00ca -> BOX DRAWINGS DOUBLE UP AND HORIZONTAL*/
    0x2566, /* 0x00cb -> BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL*/
    0x2560, /* 0x00cc -> BOX DRAWINGS DOUBLE VERTICAL AND RIGHT*/
    0x2550, /* 0x00cd -> BOX DRAWINGS DOUBLE HORIZONTAL*/
    0x256c, /* 0x00ce -> BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL*/
    0x2567, /* 0x00cf -> BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE*/
    0x2568, /* 0x00d0 -> BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE*/
    0x2564, /* 0x00d1 -> BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE*/
    0x2565, /* 0x00d2 -> BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE*/
    0x2559, /* 0x00d3 -> BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE*/
    0x2558, /* 0x00d4 -> BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE*/
    0x2552, /* 0x00d5 -> BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE*/
    0x2553, /* 0x00d6 -> BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE*/
    0x256b, /* 0x00d7 -> BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE*/
    0x256a, /* 0x00d8 -> BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE*/
    0x2518, /* 0x00d9 -> BOX DRAWINGS LIGHT UP AND LEFT*/
    0x250c, /* 0x00da -> BOX DRAWINGS LIGHT DOWN AND RIGHT*/
    0x2588, /* 0x00db -> FULL BLOCK*/
    0x2584, /* 0x00dc -> LOWER HALF BLOCK*/
    0x258c, /* 0x00dd -> LEFT HALF BLOCK*/
    0x2590, /* 0x00de -> RIGHT HALF BLOCK*/
    0x2580, /* 0x00df -> UPPER HALF BLOCK*/
    0x03b1, /* 0x00e0 -> GREEK SMALL LETTER ALPHA*/
    '\xdf', /* 0x00e1 -> LATIN SMALL LETTER SHARP S*/
    0x0393, /* 0x00e2 -> GREEK CAPITAL LETTER GAMMA*/
    0x03c0, /* 0x00e3 -> GREEK SMALL LETTER PI*/
    0x03a3, /* 0x00e4 -> GREEK CAPITAL LETTER SIGMA*/
    0x03c3, /* 0x00e5 -> GREEK SMALL LETTER SIGMA*/
    '\xb5', /* 0x00e6 -> MICRO SIGN*/
    0x03c4, /* 0x00e7 -> GREEK SMALL LETTER TAU*/
    0x03a6, /* 0x00e8 -> GREEK CAPITAL LETTER PHI*/
    0x0398, /* 0x00e9 -> GREEK CAPITAL LETTER THETA*/
    0x03a9, /* 0x00ea -> GREEK CAPITAL LETTER OMEGA*/
    0x03b4, /* 0x00eb -> GREEK SMALL LETTER DELTA*/
    0x221e, /* 0x00ec -> INFINITY*/
    0x03c6, /* 0x00ed -> GREEK SMALL LETTER PHI*/
    0x03b5, /* 0x00ee -> GREEK SMALL LETTER EPSILON*/
    0x2229, /* 0x00ef -> INTERSECTION*/
    0x2261, /* 0x00f0 -> IDENTICAL TO*/
    '\xb1', /* 0x00f1 -> PLUS-MINUS SIGN*/
    0x2265, /* 0x00f2 -> GREATER-THAN OR EQUAL TO*/
    0x2264, /* 0x00f3 -> LESS-THAN OR EQUAL TO*/
    0x2320, /* 0x00f4 -> TOP HALF INTEGRAL*/
    0x2321, /* 0x00f5 -> BOTTOM HALF INTEGRAL*/
    '\xf7', /* 0x00f6 -> DIVISION SIGN*/
    0x2248, /* 0x00f7 -> ALMOST EQUAL TO*/
    '\xb0', /* 0x00f8 -> DEGREE SIGN*/
    0x2219, /* 0x00f9 -> BULLET OPERATOR*/
    '\xb7', /* 0x00fa -> MIDDLE DOT*/
    0x221a, /* 0x00fb -> SQUARE ROOT*/
    0x207f, /* 0x00fc -> SUPERSCRIPT LATIN SMALL LETTER N*/
    '\xb2', /* 0x00fd -> SUPERSCRIPT TWO*/
    0x25a0, /* 0x00fe -> BLACK SQUARE*/
    '\xa0', /* 0x00ff -> NO-BREAK SPACE*/
};


int
main(int argc, char **argv) {
	int chr;

	setlocale(LC_ALL, "");

	while ((chr = getchar()) != 0x1a)
		if (feof(stdin))
			break;
		else if (table[chr])
			printf("%lc", table[chr]);

	return 0;
}