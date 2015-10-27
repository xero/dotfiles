# -*- coding: utf-8 -*-
"""
    pygments.styles.sourcerer
    ~~~~~~~~~~~~~~~~~~~~~~~

    ██████  ██████  ██   ██ ██████  █████   █████  ██████  █████  ██████
   ██░░░░  ██░░░░██░██  ░██░░██░░████░░░██ ██░░░██░░██░░████░░░██░░██░░██
  ░░█████ ░██   ░██░██  ░██ ░██ ░░░██  ░░ ░███████ ░██ ░░░███████ ░██ ░░
   ░░░░░██░██   ░██░██  ░██ ░██   ░██   ██░██░░░░  ░██   ░██░░░░  ░██
   ██████ ░░██████ ░░██████░███   ░░█████ ░░██████░███   ░░██████░███
  ░░░░░░   ░░░░░░   ░░░░░░ ░░░     ░░░░░   ░░░░░░ ░░░     ░░░░░░ ░░░
   r  e  a  d     c  o  d  e     l  i  k  e     a     w  i  z  a  r  d

    sourcerer by xero harrison (http://sourcerer.xero.nu)
     ├─ based on sorcerer by Jeet Sukumaran (http://jeetworks.org)
     └─ based on mustang by Henrique C. Alves (hcarvalhoalves@gmail.com)

    :copyright: none
    :license: free
"""

from pygments.style import Style
from pygments.token import Keyword, Name, Comment, String, Error, Text, \
     Number, Operator, Generic, Whitespace, Punctuation, Other, Literal

class SourcererStyle(Style):
    """
    This style mimics the sourcerer color scheme.
    """

    background_color = "#222222"
    highlight_color = "#49483e"

    styles = {
        # No corresponding class for the following:
        Text:                      "#AFAFAF", # class:  ''
        Whitespace:                "",        # class: 'w'
        Error:                     "#960050 bg:#1e0010", # class: 'err'
        Other:                     "",        # class 'x'

        Comment:                   "#5f5f5f", # class: 'c'
        Comment.Multiline:         "#5f5f5f", # class: 'cm'
        Comment.Preproc:           "",        # class: 'cp'
        Comment.Single:            "",        # class: 'c1'
        Comment.Special:           "",        # class: 'cs'

        Keyword:                   "#90B0D1", # class: 'k'
        Keyword.Constant:          "",        # class: 'kc'
        Keyword.Declaration:       "",        # class: 'kd'
        Keyword.Namespace:         "#6688AA", # class: 'kn'
        Keyword.Pseudo:            "",        # class: 'kp'
        Keyword.Reserved:          "",        # class: 'kr'
        Keyword.Type:              "",        # class: 'kt'

        Operator:                  "#D0D0D0", # class: 'o'
        Operator.Word:             "",        # class: 'ow' - like keywords

        Punctuation:               "#D0D0D0", # class: 'p'

        Name:                      "#AfAfAf", # class: 'n'
        Name.Attribute:            "#87875f", # class: 'na' - to be revised
        Name.Builtin:              "",        # class: 'nb'
        Name.Builtin.Pseudo:       "",        # class: 'bp'
        Name.Class:                "#87875f", # class: 'nc' - to be revised
        Name.Constant:             "#90B0D1", # class: 'no' - to be revised
        Name.Decorator:            "#87875f", # class: 'nd' - to be revised
        Name.Entity:               "",        # class: 'ni'
        Name.Exception:            "#87875f", # class: 'ne'
        Name.Function:             "#87875f", # class: 'nf'
        Name.Property:             "",        # class: 'py'
        Name.Label:                "",        # class: 'nl'
        Name.Namespace:            "",        # class: 'nn' - to be revised
        Name.Other:                "#87875f", # class: 'nx'
        Name.Tag:                  "#D0D0D0", # class: 'nt' - like a keyword
        Name.Variable:             "",        # class: 'nv' - to be revised
        Name.Variable.Class:       "",        # class: 'vc' - to be revised
        Name.Variable.Global:      "",        # class: 'vg' - to be revised
        Name.Variable.Instance:    "",        # class: 'vi' - to be revised

        Number:                    "#8181A6", # class: 'm'
        Number.Float:              "",        # class: 'mf'
        Number.Hex:                "",        # class: 'mh'
        Number.Integer:            "",        # class: 'mi'
        Number.Integer.Long:       "",        # class: 'il'
        Number.Oct:                "",        # class: 'mo'

        Literal:                   "#8181A6", # class: 'l'
        Literal.Date:              "#87875f", # class: 'ld'

        String:                    "#87875f", # class: 's'
        String.Backtick:           "",        # class: 'sb'
        String.Char:               "",        # class: 'sc'
        String.Doc:                "",        # class: 'sd' - like a comment
        String.Double:             "",        # class: 's2'
        String.Escape:             "#8181A6", # class: 'se'
        String.Heredoc:            "",        # class: 'sh'
        String.Interpol:           "",        # class: 'si'
        String.Other:              "",        # class: 'sx'
        String.Regex:              "",        # class: 'sr'
        String.Single:             "",        # class: 's1'
        String.Symbol:             "",        # class: 'ss'

        Generic:                   "",        # class: 'g'
        Generic.Deleted:           "#D0D0D0", # class: 'gd',
        Generic.Emph:              "",        # class: 'ge'
        Generic.Error:             "",        # class: 'gr'
        Generic.Heading:           "",        # class: 'gh'
        Generic.Inserted:          "#87875f", # class: 'gi'
        Generic.Output:            "",        # class: 'go'
        Generic.Prompt:            "",        # class: 'gp'
        Generic.Strong:            "",        # class: 'gs'
        Generic.Subheading:        "#FF9800", # class: 'gu'
        Generic.Traceback:         "",        # class: 'gt'
    }
