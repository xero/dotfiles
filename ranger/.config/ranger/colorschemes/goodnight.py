# Good Night America

from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import *

class GoodNightAmerica(ColorScheme):
    progress_bar_color = white

    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        elif context.in_browser:
            if context.selected:
                attr = reverse
            else:
                attr = normal
            if context.empty or context.error:
                fg = black
                bg = white
            if context.border:
                fg = white
            if context.image:
                fg = cyan
            if context.video:
                fg = cyan
            if context.audio:
                fg = cyan
            if context.document:
                fg = black
            if context.container:
                attr |= bold
                fg = red
            if context.directory:
                attr |= normal
                fg = white
            elif context.executable and not \
                    any((context.media, context.container,
                       context.fifo, context.socket)):
                attr |= bold
                fg = red
            if context.socket:
                fg = cyan
                attr |= bold
            if context.fifo or context.device:
                fg = cyan
                if context.device:
                    attr |= bold
            if context.link:
                fg = context.good and red or blue
            if context.bad:
                fg = red
            if context.tag_marker and not context.selected:
                attr |= bold
                if fg in (red, white):
                    fg = blue
                else:
                    fg = cyan
            if not context.selected and (context.cut or context.copied):
                fg = cyan
                bg = black
            if context.main_column:
                if context.selected:
                    attr |= bold
                if context.marked:
                    attr |= bold
                    fg = black
            if context.badinfo:
                if attr & reverse:
                    bg = red
                else:
                    fg = white

        elif context.in_titlebar:
            attr |= bold
            if context.hostname:
                fg = context.bad and red or cyan
            elif context.directory:
                fg = red
            elif context.tab:
                if context.good:
                    bg = blue
            elif context.link:
                fg = white

        elif context.in_statusbar:
            if context.permissions:
                if context.good:
                    fg = cyan
                    bg = black
                elif context.bad:
                    fg = red
            if context.marked:
                attr |= bold | reverse
                fg = black
            if context.message:
                if context.bad:
                    attr |= bold
                    fg = cyan
            if context.loaded:
                bg = self.progress_bar_color
            if context.vcsinfo:
                fg = blue
                attr &= ~bold
            if context.vcscommit:
                fg = blue
                attr &= ~bold


        if context.text:
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            if context.title:
                fg = blue

            if context.selected:
                attr |= reverse

            if context.loaded:
                if context.selected:
                    fg = self.progress_bar_color
                else:
                    bg = self.progress_bar_color


        if context.vcsfile and not context.selected:
            attr &= ~bold
            if context.vcsconflict:
                fg = cyan
            elif context.vcschanged:
                fg = blue
            elif context.vcsunknown:
                fg = red
            elif context.vcsstaged:
                fg = white
            elif context.vcssync:
                fg = black
            elif context.vcsignored:
                fg = default

        elif context.vcsremote and not context.selected:
            attr &= ~bold
            if context.vcssync:
                fg = cyan
            elif context.vcsbehind:
                fg = blue
            elif context.vcsahead:
                fg = red
            elif context.vcsdiverged:
                fg = white
            elif context.vcsunknown:
                fg = black

        return fg, bg, attr
