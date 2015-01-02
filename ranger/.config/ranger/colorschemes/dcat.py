#dcat #nixers

from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import *

class dcat(ColorScheme):
    progress_bar_color = yellow

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
                fg = yellow
                bg = black
            if context.border:
                fg = black
            if context.image:
                fg = yellow
            if context.video:
                fg = yellow
            if context.audio:
                fg = yellow
            if context.document:
                fg = black
            if context.container:
                attr |= bold
                fg = red
            if context.directory:
                attr |= normal
                fg = yellow
            elif context.executable and not \
                    any((context.media, context.container,
                       context.fifo, context.socket)):
                attr |= bold
                fg = cyan
            if context.socket:
                fg = yellow
                attr |= bold
            if context.fifo or context.device:
                fg = blue
                if context.device:
                    attr |= bold
            if context.link:
                fg = context.good and white or black
            if context.bad:
                fg = yellow
            if context.tag_marker and not context.selected:
                attr |= bold
                if fg in (black, white):
                    fg = yellow
                else:
                    fg = red
            if not context.selected and (context.cut or context.copied):
                fg = yellow
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
                fg = context.bad and black or yellow
                bg = black
            elif context.directory:
                fg = black
            elif context.tab:
                if context.good:
                    fg = red
            elif context.link:
                fg = white

        elif context.in_statusbar:
            if context.permissions:
                if context.good:
                    fg = yellow
                    bg = black
                elif context.bad:
                    fg = red
            if context.marked:
                attr |= bold | reverse
                fg = black
            if context.message:
                if context.bad:
                    attr |= bold
                    fg = yellow
            if context.loaded:
                bg = self.progress_bar_color
            if context.vcsinfo:
                fg = red
                attr &= ~bold
            if context.vcscommit:
                fg = white
                attr &= ~bold


        if context.text:
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            if context.title:
                fg = yellow

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
                fg = yellow
            elif context.vcschanged:
                fg = red
            elif context.vcsunknown:
                fg = white
            elif context.vcsstaged:
                fg = yellow
            elif context.vcssync:
                fg = black
            elif context.vcsignored:
                fg = default

        elif context.vcsremote and not context.selected:
            attr &= ~bold
            if context.vcssync:
                fg = yellow
            elif context.vcsbehind:
                fg = white
            elif context.vcsahead:
                fg = red
            elif context.vcsdiverged:
                fg = black
            elif context.vcsunknown:
                fg = black

        return fg, bg, attr