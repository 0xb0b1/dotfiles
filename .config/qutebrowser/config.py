# Autogenerated config.py
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# Uncomment this to still load settings configured via autoconfig.yml
# config.load_autoconfig()

# Background color of the completion widget category headers.
# Type: QssColor
#c.colors.completion.category.bg = '#2F2B2A'
c.colors.completion.category.bg = '#313131'

# Bottom border color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.border.bottom = '#FFFFFF'

# Top border color of the completion widget category headers.
# Type: QssColor
#c.colors.completion.category.border.top = '#2F2B2A'
c.colors.completion.category.border.top =  '#FFFFFF'


# Foreground color of completion widget category headers.
# Type: QtColor
c.colors.completion.category.fg = '#FFFFFF'

# Background color of the completion widget for even rows.
# Type: QssColor
#c.colors.completion.even.bg = '#0B0806'
c.colors.completion.even.bg = '#000000'

# Background color of the selected completion item.
# Type: QssColor
#c.colors.completion.item.selected.bg = '#A19782'
c.colors.completion.item.selected.bg = '#FFFFFF'

# Bottom border color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.border.bottom = '#FFFFFF'

# Top border color of the completion widget category headers.
# Type: QssColor
c.colors.completion.item.selected.border.top = '#FFFFFF'

# Foreground color of the selected completion item.
# Type: QtColor
c.colors.completion.item.selected.fg = '#000000'

# Background color of the completion widget for odd rows.
# Type: QssColor
c.colors.completion.odd.bg = '#0B0806'

# Background color for hints. Note that you can use a `rgba(...)` value
# for transparency.
# Type: QssColor
c.colors.hints.bg = '#0B0806'

# Font color for hints.
# Type: QssColor
c.colors.hints.fg = '#FFFFFF'

# Background color of the statusbar in insert mode.
# Type: QssColor
c.colors.statusbar.insert.bg = '#FFFFFF'

# Foreground color of the statusbar in insert mode.
# Type: QssColor
c.colors.statusbar.insert.fg = '#000000'

# Background color of the statusbar.
# Type: QssColor
c.colors.statusbar.normal.bg = '#000000'

# Foreground color of the statusbar.
# Type: QssColor
c.colors.statusbar.normal.fg = '#FFFFFF'

# Foreground color of the URL in the statusbar on successful load
# (https).
# Type: QssColor
c.colors.statusbar.url.success.https.fg = 'white'

# Background color of the tab bar.
# Type: QtColor
c.colors.tabs.bar.bg = '#FFFFFF'

# Background color of unselected even tabs.
# Type: QtColor
c.colors.tabs.even.bg = '#000000'

# Foreground color of unselected even tabs.
# Type: QtColor
c.colors.tabs.even.fg = '#FFFFFF'

# Background color of unselected odd tabs.
# Type: QtColor
c.colors.tabs.odd.bg = '#000000'

# Foreground color of unselected odd tabs.
# Type: QtColor
c.colors.tabs.odd.fg = '#FFFFFF'

# Background color of selected even tabs.
# Type: QtColor
c.colors.tabs.selected.even.bg = '#FFFFFF'

# Foreground color of selected even tabs.
# Type: QtColor
c.colors.tabs.selected.even.fg = '#000000'

# Background color of selected odd tabs.
# Type: QtColor
c.colors.tabs.selected.odd.bg = '#FFFFFF'

# Foreground color of selected odd tabs.
# Type: QtColor
c.colors.tabs.selected.odd.fg = '#000000'

# How many commands to save in the command history. 0: no history / -1:
# unlimited
# Type: Int
c.completion.cmd_history_max_items = 100

# Padding of scrollbar handle in the completion window (in px).
# Type: Int
c.completion.scrollbar.padding = 0

# Width of the scrollbar in the completion window (in px).
# Type: Int
c.completion.scrollbar.width = 0

# When to show the autocompletion window.
# Type: String
# Valid values:
#   - always: Whenever a completion is available.
#   - auto: Whenever a completion is requested.
#   - never: Never.
c.completion.show = 'always'

# Shrink the completion to be smaller than the configured size if there
# are no scrollbars.
# Type: Bool
c.completion.shrink = False

# How to format timestamps (e.g. for the history completion).
# Type: TimestampTemplate
c.completion.timestamp_format = '%Y-%m-%d'

# How many URLs to show in the web history. 0: no history / -1:
# unlimited
# Type: Int
# c.completion.web_history_max_items = -1

# Whether quitting the application requires a confirmation.
# Type: ConfirmQuit
# Valid values:
#   - always: Always show a confirmation.
#   - multiple-tabs: Show a confirmation if multiple tabs are opened.
#   - downloads: Show a confirmation if downloads are running
#   - never: Never show a confirmation.
c.confirm_quit = ['always']

# Store cookies. Note this option needs a restart with QtWebEngine on Qt
# < 5.9.
# Type: Bool
c.content.cookies.store = True

# Default encoding to use for websites. The encoding must be a string
# describing an encoding such as _utf-8_, _iso-8859-1_, etc.
# Type: String
c.content.default_encoding = 'utf-8'

# Allow websites to request geolocations.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
c.content.geolocation = False

# Value to send in the `Accept-Language` header.
# Type: String
c.content.headers.accept_language = 'en-GB'

# Set custom headers for qutebrowser HTTP requests.
# Type: Dict
c.content.headers.custom = {}

# Value to send in the `DNT` header. When this is set to true,
# qutebrowser asks websites to not track your identity. If set to null,
# the DNT header is not sent at all.
# Type: Bool
c.content.headers.do_not_track = True

# Whether host blocking is enabled.
# Type: Bool
c.content.host_blocking.enabled = True

# List of URLs of lists which contain hosts to block.  The file can be
# in one of the following formats:  - An `/etc/hosts`-like file - One
# host per line - A zip-file of any of the above, with either only one
# file, or a file named   `hosts` (with any extension).
# Type: List of Url
c.content.host_blocking.lists = ['https://www.malwaredomainlist.com/hostslist/hosts.txt', 'http://someonewhocares.org/hosts/hosts', 'http://winhelp2002.mvps.org/hosts.zip', 
'http://malwaredomains.lehigh.edu/files/justdomains.zip', 'https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&mimetype=plaintext']

# List of domains that should always be loaded, despite being ad-
# blocked. Domains may contain * and ? wildcards and are otherwise
# required to exactly match the requested domain. Local domains are
# always exempt from hostblocking.
# Type: List of String
c.content.host_blocking.whitelist = []

# Enable or disable hyperlink auditing (`<a ping>`).
# Type: Bool
c.content.hyperlink_auditing = False

# Whether JavaScript can read from or write to the clipboard. With
# QtWebEngine, writing the clipboard as response to a user interaction
# is always allowed.
# Type: Bool
c.content.javascript.can_access_clipboard = False

# Whether JavaScript can open new tabs without user interaction.
# Type: Bool
c.content.javascript.can_open_tabs_automatically = False

# Enables or disables JavaScript.
# Type: Bool
c.content.javascript.enabled = True

# Whether locally loaded documents are allowed to access other local
# urls.
# Type: Bool
c.content.local_content_can_access_file_urls = True

# Whether locally loaded documents are allowed to access remote urls.
# Type: Bool
c.content.local_content_can_access_remote_urls = False

# Whether support for HTML 5 local storage and Web SQL is enabled.
# Type: Bool
c.content.local_storage = True

# Allow websites to record audio/video.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
c.content.media_capture = False

# Enables or disables plugins in Web pages.
# Type: Bool
c.content.plugins = False

# Whether the background color and images are also drawn when the page
# is printed.
# Type: Bool
c.content.print_element_backgrounds = True

# Open new windows in private browsing mode which does not record
# visited pages.
# Type: Bool
c.content.private_browsing = False

# The proxy to use. In addition to the listed values, you can use a
# `socks://...` or `http://...` URL.
# Type: Proxy
# Valid values:
#   - system: Use the system wide proxy.
#   - none: Don't use any proxy
c.content.proxy = 'system'

# Validate SSL handshakes.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
c.content.ssl_strict = 'ask'

# A list of user stylesheet filenames to use.
# Type: List of File, or File
c.content.user_stylesheets = []

# Enables or disables WebGL.
# Type: Bool
c.content.webgl = False

# The directory to save downloads to. If unset, a sensible os-specific
# default is used.
# Type: Directory
c.downloads.location.directory = '${HOME}/'

# Prompt the user for the download location. If set to false,
# `downloads.location.directory` will be used.
# Type: Bool
c.downloads.location.prompt = True

# Remember the last used download directory.
# Type: Bool
c.downloads.location.remember = True

# What to display in the download filename input.
# Type: String
# Valid values:
#   - path: Show only the download path.
#   - filename: Show only download filename.
#   - both: Show download path and filename.
c.downloads.location.suggestion = 'path'

# Number of milliseconds to wait before removing finished downloads. If
# set to -1, downloads are never removed.
# Type: Int
c.downloads.remove_finished = 0

# The editor (and arguments) to use for the `open-editor` command. `{}`
# gets replaced by the filename of the file to be edited.
# Type: ShellCommand
c.editor.command = ['/usr/local/bin/st', '-e', '/usr/bin/vim', '-f', '{}']

# Font used in the completion categories.
# Type: Font
#c.fonts.completion.category = '8pt monospace'

# Font used for the hints.
# Type: Font
#c.fonts.hints = '8pt monospace'

# Default monospace fonts. Whenever "monospace" is used in a font
# setting, it's replaced with the fonts listed here.
# Type: Font
#c.fonts.monospace = '"Fira Mono", "lucy tewi", "Efont Biwidth", "Efont Fixed", "Misc Fixed", "Misc Fixed Wide", "Noto Sans Mono CJK CN", "Noto Sans Mono CJK JP", "Noto Sans Mono KR"'

# Font used for prompts.
# Type: Font
#c.fonts.prompts = '8pt monospace'

# Font family for cursive fonts.
# Type: FontFamily
#c.fonts.web.family.cursive = None

# Font family for fantasy fonts.
# Type: FontFamily
#c.fonts.web.family.fantasy = None

# Font family for fixed fonts.
# Type: FontFamily
#c.fonts.web.family.fixed = '"Fira Mono", "Efont Fixed", "Efont Biwidth", "Misc Fixed", "Misc Fixed Wide"'

# Font family for sans-serif fonts.
# Type: FontFamily
#c.fonts.web.family.sans_serif = '"Fira Mono"'

# Font family for serif fonts.
# Type: FontFamily
#c.fonts.web.family.serif = '"Noto Sans", "Noto Serif", "Noto Sans CJK CN", "Noto Sans CJK JP", "Noto Sans CJK KR"'

# Font family for standard fonts.
# Type: FontFamily
#c.fonts.web.family.standard = '"Noto Sans", "Noto Sans CJK CN", "Noto Sans CJK JP", "Noto Sans CJK KR"'

# Controls when a hint can be automatically followed without pressing
# Enter.
# Type: String
# Valid values:
#   - always: Auto-follow whenever there is only a single hint on a page.
#   - unique-match: Auto-follow whenever there is a unique non-empty match in either the hint string (word mode) or filter (number mode).
#   - full-match: Follow the hint when the user typed the whole hint (letter, word or number mode) or the element's text (only in number mode).
#   - never: The user will always need to press Enter to follow a hint.
c.hints.auto_follow = 'unique-match'

# A timeout (in milliseconds) to ignore normal-mode key bindings after a
# successful auto-follow.
# Type: Int
c.hints.auto_follow_timeout = 0

# CSS border value for hints.
# Type: String
c.hints.border = '3px solid #FF0000'
#0B0806'

# Chars used for hint strings.
# Type: UniqueCharString
c.hints.chars = 'hjklasdfgyuiopqwertnmzxcvb'

# The dictionary file to be used by the word hints.
# Type: File
c.hints.dictionary = '/dev/null'

# Minimum number of chars used for hint strings.
# Type: Int
c.hints.min_chars = 1

# Mode to use for hints.
# Type: String
# Valid values:
#   - number: Use numeric hints. (In this mode you can also type letters from the hinted element to filter and reduce the number of elements that are hinted.)
#   - letter: Use the chars in the `hints.chars` setting.
#   - word: Use hints words based on the html elements and the extra words.
c.hints.mode = 'letter'

# Make chars in hint strings uppercase.
# Type: Bool
c.hints.uppercase = False

# The maximum time in minutes between two history items for them to be
# considered being from the same browsing session. Items with less time
# between them are grouped when being displayed in `:history`. Use -1 to
# disable separation.
# Type: Int
c.history_gap_interval = 5

# Find text on a page case-insensitively.
# Type: String
# Valid values:
#   - always: Search case-insensitively
#   - never: Search case-sensitively
#   - smart: Search case-sensitively if there are capital chars
# c.ignore_case = 'smart'

# How to open links in an existing instance if a new one is launched.
# This happens when e.g. opening a link from a terminal. See
# `new_instance_open_target_window` to customize in which window the
# link is opened in.
# Type: String
# Valid values:
#   - tab: Open a new tab in the existing window and activate the window.
#   - tab-bg: Open a new background tab in the existing window and activate the window.
#   - tab-silent: Open a new tab in the existing window without activating the window.
#   - tab-bg-silent: Open a new background tab in the existing window without activating the window.
#   - window: Open in a new window.
c.new_instance_open_target = 'tab'

# Which window to choose when opening links as new tabs. When
# `new_instance_open_target` is not set to `window`, this is ignored.
# Type: String
# Valid values:
#   - first-opened: Open new tabs in the first (oldest) opened window.
#   - last-opened: Open new tabs in the last (newest) opened window.
#   - last-focused: Open new tabs in the most recently focused window.
#   - last-visible: Open new tabs in the most recently visible window.
c.new_instance_open_target_window = 'last-focused'

# Additional arguments to pass to Qt, without leading `--`. With
# QtWebEngine, some Chromium arguments (see
# https://peter.sh/experiments/chromium-command-line-switches/ for a
# list) will work. This setting requires a restart.
# Type: List of String
c.qt.args = []

# Force software rendering for QtWebEngine. This is needed for
# QtWebEngine to work with Nouveau drivers. This setting requires a
# restart.
# Type: Bool
# c.qt.force_software_rendering = False

# Enable smooth scrolling for web pages. Note smooth scrolling does not
# work with the `:scroll-px` command.
# Type: Bool
c.scrolling.smooth = False

# Spell checking languages. You can check for available languages and
# install dictionaries using scripts/install_dict.py. Run the script
# with -h/--help for instructions.
# Type: List of String
# Valid values:
#   - af-ZA: Afrikaans (South Africa)
#   - bg-BG: Bulgarian (Bulgaria)
#   - ca-ES: Catalan (Spain)
#   - cs-CZ: Czech (Czech Republic)
#   - da-DK: Danish (Denmark)
#   - de-DE: German (Germany)
#   - el-GR: Greek (Greece)
#   - en-CA: English (Canada)
#   - en-GB: English (United Kingdom)
#   - en-US: English (United States)
#   - es-ES: Spanish (Spain)
#   - et-EE: Estonian (Estonia)
#   - fa-IR: Farsi (Iran)
#   - fo-FO: Faroese (Faroe Islands)
#   - fr-FR: French (France)
#   - he-IL: Hebrew (Israel)
#   - hi-IN: Hindi (India)
#   - hr-HR: Croatian (Croatia)
#   - hu-HU: Hungarian (Hungary)
#   - id-ID: Indonesian (Indonesia)
#   - it-IT: Italian (Italy)
#   - ko: Korean
#   - lt-LT: Lithuanian (Lithuania)
#   - lv-LV: Latvian (Latvia)
#   - nb-NO: Norwegian (Norway)
#   - nl-NL: Dutch (Netherlands)
#   - pl-PL: Polish (Poland)
#   - pt-BR: Portuguese (Brazil)
#   - pt-PT: Portuguese (Portugal)
#   - ro-RO: Romanian (Romania)
#   - ru-RU: Russian (Russia)
#   - sh: Serbo-Croatian
#   - sk-SK: Slovak (Slovakia)
#   - sl-SI: Slovenian (Slovenia)
#   - sq: Albanian
#   - sr: Serbian
#   - sv-SE: Swedish (Sweden)
#   - ta-IN: Tamil (India)
#   - tg-TG: Tajik (Tajikistan)
#   - tr-TR: Turkish (Turkey)
#   - uk-UA: Ukrainian (Ukraine)
#   - vi-VN: Vietnamese (Viet Nam)
#c.spellcheck.languages = ['en-US', 'en-GB', 'fr-FR', 'ru-RU', 'pt-BR', 'ko']

# Padding for the statusbar.
# Type: Padding
c.statusbar.padding = {'top': 2, 'bottom': 2, 'left': 2, 'right': 2}

# Hide the statusbar unless a message is shows
c.statusbar.hide = False

# The position of the status bar.
# Type: VerticalPosition
# Valid values:
#   - top
#   - bottom
c.statusbar.position = 'bottom'

# Open new tabs (middleclick/ctrl+click) in the background.
# Type: Bool
c.tabs.background = True

# When to show the tab bar.
c.tabs.show = 'never'

# On which mouse button to close tabs.
# Type: String
# Valid values:
#   - right: Close tabs on right-click.
#   - middle: Close tabs on middle-click.
#   - none: Don't close tabs using the mouse.
c.tabs.close_mouse_button = 'middle'

# Show favicons in the tab bar.
# Type: Bool
# c.tabs.favicons.show = True

# Padding for tab indicators
# Type: Padding
# c.tabs.indicator_padding = {'top': 6, 'bottom': 6, 'left': 0, 'right': 0}

# Switch between tabs using the mouse wheel.
# Type: Bool
c.tabs.mousewheel_switching = True

# How new tabs opened from another tab are positioned.
# Type: NewTabPosition
# Valid values:
#   - prev: Before the current tab.
#   - next: After the current tab.
#   - first: At the beginning.
#   - last: At the end.
c.tabs.new_position.related = 'next'

# How new tabs which aren't opened from another tab are positioned.
# Type: NewTabPosition
# Valid values:
#   - prev: Before the current tab.
#   - next: After the current tab.
#   - first: At the beginning.
#   - last: At the end.
c.tabs.new_position.unrelated = 'last'

# Padding around text for tabs
# Type: Padding
c.tabs.padding = {'top': 2, 'bottom': 2, 'left': 3, 'right': 3}

# The position of the tab bar.
# Type: Position
# Valid values:
#   - top
#   - bottom
#   - left
#   - right
c.tabs.position = 'top'

# Which tab to select when the focused tab is removed.
# Type: SelectOnRemove
# Valid values:
#   - prev: Select the tab which came before the closed one (left in horizontal, above in vertical).
#   - next: Select the tab which came after the closed one (right in horizontal, below in vertical).
#   - last-used: Select the previously selected tab.
c.tabs.select_on_remove = 'next'

# Alignment of the text inside of tabs.
# Type: TextAlignment
# Valid values:
#   - left
#   - right
#   - center
c.tabs.title.alignment = 'center'

# The format to use for the tab title. The following placeholders are
# defined:  * `{perc}`: The percentage as a string like `[10%]`. *
# `{perc_raw}`: The raw percentage, e.g. `10` * `{title}`: The title of
# the current web page * `{title_sep}`: The string ` - ` if a title is
# set, empty otherwise. * `{index}`: The index of this tab. * `{id}`:
# The internal tab ID of this tab. * `{scroll_pos}`: The page scroll
# position. * `{host}`: The host of the current web page. * `{backend}`:
# Either ''webkit'' or ''webengine'' * `{private}` : Indicates when
# private mode is enabled.
# Type: FormatString
#c.tabs.title.format = '{title}'

# The format to use for the tab title for pinned tabs. The same
# placeholders like for `tabs.title.format` are defined.
# Type: FormatString
c.tabs.title.format_pinned = '{index}'

# The width of the tab bar if it's vertical, in px or as percentage of
# the window.
# Type: PercOrInt
#c.tabs.width.bar = '10'

# Width of the progress indicator (0 to disable).
# Type: Int
# c.tabs.width.indicator = 0

# The page to open if :open -t/-b/-w is used without URL. Use
# `about:blank` for a blank page.
# Type: FuzzyUrl
c.url.default_page = 'https://start.duckduckgo.com/'

# Definitions of search engines which can be used via the address bar.
# Maps a searchengine name (such as `DEFAULT`, or `ddg`) to a URL with a
# `{}` placeholder. The placeholder will be replaced by the search term,
# use `{{` and `}}` for literal `{`/`}` signs. The searchengine named
# `DEFAULT` is used when `url.auto_search` is turned on and something
# else than a URL was entered to be opened. Other search engines can be
# used by prepending the search engine name to the search term, e.g.
# `:open google qutebrowser`.
# Type: Dict
c.url.searchengines = {'DEFAULT': 'https://duckduckgo.com/?q={}'}

# The page(s) to open at the start.
# Type: List of FuzzyUrl, or FuzzyUrl
c.url.start_pages =  ["https://start.duckduckgo.com/"]
# c.url.start_pages.append("https://www.python.org/")


# The URL parameters to strip with `:yank url`.
# Type: List of String
c.url.yank_ignored_parameters = ['ref', 'utm_source', 'utm_medium', 'utm_campaign', 'utm_term', 'utm_content']

# Hide the window decoration when using wayland (requires restart)
# Type: Bool
# c.window.hide_wayland_decoration = False

# The format to use for the window title. The following placeholders are
# defined:  * `{perc}`: The percentage as a string like `[10%]`. *
# `{perc_raw}`: The raw percentage, e.g. `10` * `{title}`: The title of
# the current web page * `{ttle_sep}`: The string ` - ` if a title is
# set, empty otherwise. * `{id}`: The internal window ID of this window.
# * `{scroll_pos}`: The page scroll position. * `{host}`: The host of
# the current web page. * `{backend}`: Either ''webkit'' or
# ''webengine'' * `{private}` : Indicates when private mode is enabled.
# Type: FormatString
c.window.title_format = 'qutebrowser'

# Bindings for normal mode
config.bind('M', 'hint links spawn mpv {hint-url}')
config.bind('m', 'spawn mpv {url}')
