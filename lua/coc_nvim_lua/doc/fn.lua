return {
  ["expand"] = [[expand({expr} [, {nosuf} [, {list}\]\]) any
---------
  Expand wildcards and the following special keywords in {expr}.
  'wildignorecase' applies.

  If {list} is given and it is |TRUE|, a List will be returned.
  Otherwise the result is a String and when there are several
  matches, they are separated by <NL> characters.

  If the expansion fails, the result is an empty string.  A name
  for a non-existing file is not included, unless {expr} does
  not start with '%', '#' or '<', see below.

  When {expr} starts with '%', '#' or '<', the expansion is done
  like for the |cmdline-special| variables with their associated
  modifiers.  Here is a short overview:

   %  current file name
   #  alternate file name
   #n  alternate file name n
   <cfile>  file name under the cursor
   <afile>  autocmd file name
   <abuf>  autocmd buffer number (as a String!)
   <amatch> autocmd matched name
   <sfile>  sourced script file or function name
   <slnum>  sourced script line number or function
     line number
   <sflnum> script file line number, also when in
     a function
   <cword>  word under the cursor
   <cWORD>  WORD under the cursor
   <client> the {clientid} of the last received
     message |server2client()|
  Modifiers:
   :p  expand to full path
   :h  head (last path component removed)
   :t  tail (last path component only)
   :r  root (one extension removed)
   :e  extension only

  Example: >
   :let &tags = expand("%:p:h") . "/tags"
<  Note that when expanding a string that starts with '%', '#' or
  '<', any following text is ignored.  This does NOT work: >
   :let doesntwork = expand("%:h.bak")
<  Use this: >
   :let doeswork = expand("%:h") . ".bak"
<  Also note that expanding "<cfile>" and others only returns the
  referenced file name without further expansion.  If "<cfile>"
  is "~/.cshrc", you need to do another expand() to have the
  "~/" expanded into the path of the home directory: >
   :echo expand(expand("<cfile>"))
<
  There cannot be white space between the variables and the
  following modifier.  The |fnamemodify()| function can be used
  to modify normal file names.

  When using '%' or '#', and the current or alternate file name
  is not defined, an empty string is used.  Using "%:p" in a
  buffer with no name, results in the current directory, with a
  '/' added.

  When {expr} does not start with '%', '#' or '<', it is
  expanded like a file name is expanded on the command line.
  'suffixes' and 'wildignore' are used, unless the optional
  {nosuf} argument is given and it is |TRUE|.
  Names for non-existing files are included.  The "**" item can
  be used to search in a directory tree.  For example, to find
  all "README" files in the current directory and below: >
   :echo expand("**/README")
<
  expand() can also be used to expand variables and environment
  variables that are only known in a shell.  But this can be
  slow, because a shell may be used to do the expansion.  See
  |expr-env-expand|.
  The expanded variable is still handled like a list of file
  names.  When an environment variable cannot be expanded, it is
  left unchanged.  Thus ":echo expand('$FOOBAR')" results in
  "$FOOBAR".

  See |glob()| for finding existing files.  See |system()| for
  getting the raw output of an external command.]],
  ["isdirectory"] = [[isdirectory({directory}) Number
---------
  The result is a Number, which is |TRUE| when a directory
  with the name {directory} exists.  If {directory} doesn't
  exist, or isn't a directory, the result is |FALSE|.  {directory}
  is any expression, which is used as a String.]],
  ["gettabinfo"] = [[gettabinfo([{expr}]) List
---------
  If {arg} is not specified, then information about all the tab
  pages is returned as a List. Each List item is a Dictionary.
  Otherwise, {arg} specifies the tab page number and information
  about that one is returned.  If the tab page does not exist an
  empty List is returned.

  Each List item is a Dictionary with the following entries:
   tabnr  tab page number.
   variables a reference to the dictionary with
     tabpage-local variables
   windows  List of |window-ID|s in the tab page.]],
  ["bufload"] = [[bufload({expr}) Number
---------
  Ensure the buffer {expr} is loaded.  When the buffer name
  refers to an existing file then the file is read.  Otherwise
  the buffer will be empty.  If the buffer was already loaded
  then there is no change.
  If there is an existing swap file for the file of the buffer,
  there will be no dialog, the buffer will be loaded anyway.
  The {expr} argument is used like with |bufexists()|.]],
  ["writefile"] = [[writefile({list}, {fname} [, {flags}]) Number
---------
  Write |List| {list} to file {fname}.  Each list item is
  separated with a NL.  Each list item must be a String or
  Number.
  When {flags} contains "b" then binary mode is used: There will
  not be a NL after the last list item.  An empty item at the
  end does cause the last line in the file to end in a NL.

  When {flags} contains "a" then append mode is used, lines are
  appended to the file: >
   :call writefile(["foo"], "event.log", "a")
   :call writefile(["bar"], "event.log", "a")
<
  When {flags} contains "S" fsync() call is not used, with "s"
  it is used, 'fsync' option applies by default. No fsync()
  means that writefile() will finish faster, but writes may be
  left in OS buffers and not yet written to disk. Such changes
  will disappear if system crashes before OS does writing.

  All NL characters are replaced with a NUL character.
  Inserting CR characters needs to be done before passing {list}
  to writefile().
  An existing file is overwritten, if possible.
  When the write fails -1 is returned, otherwise 0.  There is an
  error message if the file can't be created or when writing
  fails.
  Also see |readfile()|.
  To copy a file byte for byte: >
   :let fl = readfile("foo", "b")
   :call writefile(fl, "foocopy", "b")
]],
  ["has"] = [[has({feature}) Number
---------
  {feature} argument is a feature name like "nvim-0.2.1" or
  "win32", see below.  See also |exists()|.

  Vim's compile-time feature-names (prefixed with "+") are not
  recognized because Nvim is always compiled with all possible
  features. |feature-compile| 

  Feature names can be:
  1.  Nvim version. For example the "nvim-0.2.1" feature means
      that Nvim is version 0.2.1 or later: >
   :if has("nvim-0.2.1")

<  2.  Runtime condition or other pseudo-feature. For example the
      "win32" feature checks if the current system is Windows: >
   :if has("win32")
<       *feature-list*
      List of supported pseudo-feature names:
          acl  |ACL| support
   bsd  BSD system (not macOS, use "mac" for that).
          iconv  Can use |iconv()| for conversion.
          +shellslash Can use backslashes in filenames (Windows)
   clipboard |clipboard| provider is available.
   mac  MacOS system.
   nvim  This is Nvim.
   python2  Legacy Vim |python2| interface. |has-python|
   python3  Legacy Vim |python3| interface. |has-python|
   pythonx  Legacy Vim |python_x| interface. |has-pythonx|
   ttyin  input is a terminal (tty)
   ttyout  output is a terminal (tty)
   unix  Unix system.
   *vim_starting* True during |startup|. 
   win32  Windows system (32 or 64 bit).
   win64  Windows system (64 bit).
   wsl  WSL (Windows Subsystem for Linux) system

       *has-patch*
  3.  Vim patch. For example the "patch123" feature means that
      Vim patch 123 at the current |v:version| was included: >
   :if v:version > 602 || v:version == 602 && has("patch148")

<  4.  Vim version. For example the "patch-7.4.237" feature means
      that Nvim is Vim-compatible to version 7.4.237 or later. >
   :if has("patch-7.4.237")
]],
  ["jobstart"] = [[jobstart({cmd}[, {opts}]) Number
---------
  Spawns {cmd} as a job.
  If {cmd} is a List it runs directly (no 'shell').
  If {cmd} is a String it runs in the 'shell', like this: >
    :call jobstart(split(&shell) + split(&shellcmdflag) + ['{cmd}'])
<  (See |shell-unquoting| for details.)

  Example: >
    :call jobstart('nvim -h', {'on_stdout':{j,d,e->append(line('.'),d)}})
<
  Returns |job-id| on success, 0 on invalid arguments (or job
  table is full), -1 if {cmd}[0] or 'shell' is not executable.
  The returned job-id is a valid |channel-id| representing the
  job's stdio streams. Use |chansend()| (or |rpcnotify()| and
  |rpcrequest()| if "rpc" was enabled) to send data to stdin and
  |chanclose()| to close the streams without stopping the job.

  See |job-control| and |RPC|.

  NOTE: on Windows if {cmd} is a List:
    - cmd[0] must be an executable (not a "built-in"). If it is
      in $PATH it can be called by name, without an extension: >
        :call jobstart(['ping', 'neovim.io'])
<      If it is a full or partial path, extension is required: >
        :call jobstart(['System32\ping.exe', 'neovim.io'])
<    - {cmd} is collapsed to a string of quoted args as expected
      by CommandLineToArgvW https://msdn.microsoft.com/bb776391
      unless cmd[0] is some form of "cmd.exe".

       *jobstart-options*
  {opts} is a dictionary with these keys:
    clear_env:  (boolean) `env` defines the job environment
         exactly, instead of merging current environment.
    cwd:       (string, default=|current-directory|) Working
         directory of the job.
    detach:     (boolean) Detach the job process: it will not be
         killed when Nvim exits. If the process exits
         before Nvim, `on_exit` will be invoked.
    env:       (dict) Map of environment variable name:value
         pairs extending (or replacing if |clear_env|)
         the current environment.
    height:     (number) Height of the `pty` terminal.
    |on_exit|:    (function) Callback invoked when the job exits.
    |on_stdout|:  (function) Callback invoked when the job emits
         stdout data.
    |on_stderr|:  (function) Callback invoked when the job emits
         stderr data.
    pty:       (boolean) Connect the job to a new pseudo
         terminal, and its streams to the master file
         descriptor. Then  `on_stderr` is ignored,
         `on_stdout` receives all output.
    rpc:       (boolean) Use |msgpack-rpc| to communicate with
         the job over stdio. Then `on_stdout` is ignored,
         but `on_stderr` can still be used.
    stderr_buffered: (boolean) Collect data until EOF (stream closed)
         before invoking `on_stderr`. |channel-buffered|
    stdout_buffered: (boolean) Collect data until EOF (stream
         closed) before invoking `on_stdout`. |channel-buffered|
    TERM:       (string) Sets the `pty` $TERM environment variable.
    width:      (number) Width of the `pty` terminal.

  {opts} is passed as |self| dictionary to the callback; the
  caller may set other keys to pass application-specific data.

  Returns:
    - |channel-id| on success
    - 0 on invalid arguments
    - -1 if {cmd}[0] is not executable.
  See also |job-control|, |channel|, |msgpack-rpc|.]],
  ["hlexists"] = [[hlexists({name}) Number
---------
  The result is a Number, which is non-zero if a highlight group
  called {name} exists.  This is when the group has been
  defined in some way.  Not necessarily when highlighting has
  been defined for it, it may also have been used for a syntax
  item.
]],
  ["winrestview"] = [[winrestview({dict}) none
---------
  Uses the |Dictionary| returned by |winsaveview()| to restore
  the view of the current window.
  Note: The {dict} does not have to contain all values, that are
  returned by |winsaveview()|. If values are missing, those
  settings won't be restored. So you can use: >
      :call winrestview({'curswant': 4})
<
  This will only set the curswant value (the column the cursor
  wants to move on vertical movements) of the cursor to column 5
  (yes, that is 5), while all other settings will remain the
  same. This is useful, if you set the cursor position manually.

  If you have changed the values the result is unpredictable.
  If the window size changed the result won't be the same.
]],
  ["system"] = [[system({cmd} [, {input}]) String
---------
  Get the output of {cmd} as a |string| (use |systemlist()| to
  get a |List|). {cmd} is treated exactly as in |jobstart()|.
  Not to be used for interactive commands.

  If {input} is a string it is written to a pipe and passed as
  stdin to the command.  The string is written as-is, line
  separators are not changed.
  If {input} is a |List| it is written to the pipe as
  |writefile()| does with {binary} set to "b" (i.e. with
  a newline between each list item, and newlines inside list
  items converted to NULs).
  When {input} is given and is a valid buffer id, the content of
  the buffer is written to the file line by line, each line
  terminated by NL (and NUL where the text has NL).
        *E5677*
  Note: system() cannot write to or read from backgrounded ("&")
  shell commands, e.g.: >
      :echo system("cat - &", "foo"))
<  which is equivalent to: >
      $ echo foo | bash -c 'cat - &'
<  The pipes are disconnected (unless overridden by shell
  redirection syntax) before input can reach it. Use
  |jobstart()| instead.

  Note: Use |shellescape()| or |::S| with |expand()| or
  |fnamemodify()| to escape special characters in a command
  argument.  Newlines in {cmd} may cause the command to fail. 
  The characters in 'shellquote' and 'shellxquote' may also
  cause trouble.

  Result is a String.  Example: >
      :let files = system("ls " .  shellescape(expand('%:h')))
      :let files = system('ls ' . expand('%:h:S'))

<  To make the result more system-independent, the shell output
  is filtered to replace <CR> with <NL> for Macintosh, and
  <CR><NL> with <NL> for DOS-like systems.
  To avoid the string being truncated at a NUL, all NUL
  characters are replaced with SOH (0x01).

  The command executed is constructed using several options when
  {cmd} is a string: 'shell' 'shellcmdflag' {cmd}

  The resulting error code can be found in |v:shell_error|.
  This function will fail in |restricted-mode|.

  Note that any wrong value in the options mentioned above may
  make the function fail.  It has also been reported to fail
  when using a security agent application.
  Unlike ":!cmd" there is no automatic check for changed files.
  Use |:checktime| to force a check.
]],
  ["strdisplaywidth"] = [[strdisplaywidth({expr} [, {col}]) Number
---------
  The result is a Number, which is the number of display cells
  String {expr} occupies on the screen when it starts at {col}
  (first column is zero).  When {col} is omitted zero is used.
  Otherwise it is the screen column where to start.  This
  matters for Tab characters.
  The option settings of the current window are used.  This
  matters for anything that's displayed differently, such as
  'tabstop' and 'display'.
  When {expr} contains characters with East Asian Width Class
  Ambiguous, this function's return value depends on 'ambiwidth'.
  Also see |strlen()|, |strwidth()| and |strchars()|.]],
  ["foldclosed"] = [[foldclosed({lnum}) Number
---------
  The result is a Number.  If the line {lnum} is in a closed
  fold, the result is the number of the first line in that fold.
  If the line {lnum} is not in a closed fold, -1 is returned.]],
  ["extend"] = [[extend({expr1}, {expr2} [, {expr3}]) List/Dict
---------
  {expr1} and {expr2} must be both |Lists| or both
  |Dictionaries|.

  If they are |Lists|: Append {expr2} to {expr1}.
  If {expr3} is given insert the items of {expr2} before item
  {expr3} in {expr1}.  When {expr3} is zero insert before the
  first item.  When {expr3} is equal to len({expr1}) then
  {expr2} is appended.
  Examples: >
   :echo sort(extend(mylist, [7, 5]))
   :call extend(mylist, [2, 3], 1)
<  When {expr1} is the same List as {expr2} then the number of
  items copied is equal to the original length of the List.
  E.g., when {expr3} is 1 you get N new copies of the first item
  (where N is the original length of the List).
  Use |add()| to concatenate one item to a list.  To concatenate
  two lists into a new list use the + operator: >
   :let newlist = [1, 2, 3] + [4, 5]
<
  If they are |Dictionaries|:
  Add all entries from {expr2} to {expr1}.
  If a key exists in both {expr1} and {expr2} then {expr3} is
  used to decide what to do:
  {expr3} = "keep": keep the value of {expr1}
  {expr3} = "force": use the value of {expr2}
  {expr3} = "error": give an error message  *E737*
  When {expr3} is omitted then "force" is assumed.

  {expr1} is changed when {expr2} is not empty.  If necessary
  make a copy of {expr1} first.
  {expr2} remains unchanged.
  When {expr1} is locked and {expr2} is not empty the operation
  fails.
  Returns {expr1}.
]],
  ["fnameescape"] = [[fnameescape({fname}) String
---------
  Escape {string} for use as file name command argument.  All
  characters that have a special meaning, such as '%' and '|'
  are escaped with a backslash.
  For most systems the characters escaped are
  " \t\n*?[{`$\\%#'\"|!<".  For systems where a backslash
  appears in a filename, it depends on the value of 'isfname'.
  A leading '+' and '>' is also escaped (special after |:edit|
  and |:write|).  And a "-" by itself (special after |:cd|).
  Example: >
   :let fname = '+some str%nge|name'
   :exe "edit " . fnameescape(fname)
<  results in executing: >
   edit \+some\ str\%nge\|name]],
  ["getwininfo"] = [[getwininfo([{winid}]) List
---------
  Returns information about windows as a List with Dictionaries.

  If {winid} is given Information about the window with that ID
  is returned.  If the window does not exist the result is an
  empty list.

  Without {winid} information about all the windows in all the
  tab pages is returned.

  Each List item is a Dictionary with the following entries:
   botline  last displayed buffer line
   bufnr  number of buffer in the window
   height  window height (excluding winbar)
   loclist  1 if showing a location list
   quickfix 1 if quickfix or location list window
   terminal 1 if a terminal window
   tabnr  tab page number
   topline  first displayed buffer line 
   variables a reference to the dictionary with
     window-local variables
   width  window width
   winbar  1 if the window has a toolbar, 0
     otherwise
   wincol  leftmost screen column of the window
   winid  |window-ID|
   winnr  window number
   winrow  topmost screen column of the window]],
  ["winlayout"] = [[winlayout([{tabnr}]) List
---------
  The result is a nested List containing the layout of windows
  in a tabpage.

  Without {tabnr} use the current tabpage, otherwise the tabpage
  with number {tabnr}. If the tabpage {tabnr} is not found,
  returns an empty list.

  For a leaf window, it returns:
   ['leaf', {winid}]
  For horizontally split windows, which form a column, it
  returns:
   ['col', [{nested list of windows}\]\]
  For vertically split windows, which form a row, it returns:
   ['row', [{nested list of windows}\]\]

  Example: >
   " Only one window in the tab page
   :echo winlayout()
   ['leaf', 1000]
   " Two horizontally split windows
   :echo winlayout()
   ['col', \]\]'leaf', 1000], ['leaf', 1001\]\]\]
   " Three horizontally split windows, with two
   " vertically split windows in the middle window
   :echo winlayout(2)
   ['col', \]\]'leaf', 1002], ['row', ['leaf', 1003],
          ['leaf', 1001\]\]\], ['leaf', 1000\]\]
<]],
  ["mkdir"] = [[mkdir({name} [, {path} [, {prot}\]\]) Number
---------
  Create directory {name}.
  If {path} is "p" then intermediate directories are created as
  necessary.  Otherwise it must be "".
  If {prot} is given it is used to set the protection bits of
  the new directory.  The default is 0755 (rwxr-xr-x: r/w for
  the user readable for others).  Use 0700 to make it unreadable
  for others.

  {prot} is applied for all parts of {name}.  Thus if you create
  /tmp/foo/bar then /tmp/foo will be created with 0700. Example: >
   :call mkdir($HOME . "/tmp/foo/bar", "p", 0700)
<  This function is not available in the |sandbox|.

  If you try to create an existing directory with {path} set to
  "p" mkdir() will silently exit.
]],
  ["empty"] = [[empty({expr}) Number
---------
  Return the Number 1 if {expr} is empty, zero otherwise.
  A |List| or |Dictionary| is empty when it does not have any
  items.  A Number is empty when its value is zero.  Special
  variable is empty when it is |v:false| or |v:null|.]],
  ["stridx"] = [[stridx({haystack}, {needle} [, {start}]) Number
---------
  The result is a Number, which gives the byte index in
  {haystack} of the first occurrence of the String {needle}.
  If {start} is specified, the search starts at index {start}.
  This can be used to find a second match: >
   :let colon1 = stridx(line, ":")
   :let colon2 = stridx(line, ":", colon1 + 1)
<  The search is done case-sensitive.
  For pattern searches use |match()|.
  -1 is returned if the {needle} does not occur in {haystack}.
  See also |strridx()|.
  Examples: >
    :echo stridx("An Example", "Example")      3
    :echo stridx("Starting point", "Start")    0
    :echo stridx("Starting point", "start")   -1
<      *strstr()* *strchr()*
  stridx() works similar to the C function strstr().  When used
  with a single character it works similar to strchr().
]],
  ["exists"] = [[exists({expr}) Number
---------
  defined, zero otherwise.

  For checking for a supported feature use |has()|.
  For checking if a file exists use |filereadable()|.

  The {expr} argument is a string, which contains one of these:
   &option-name Vim option (only checks if it exists,
     not if it really works)
   +option-name Vim option that works.
   $ENVNAME environment variable (could also be
     done by comparing with an empty
     string)
   *funcname built-in function (see |functions|)
     or user defined function (see
     |user-function|). Also works for a
     variable that is a Funcref.
   varname  internal variable (see
     |internal-variables|).  Also works
     for |curly-braces-names|, |Dictionary|
     entries, |List| items, etc.  Beware
     that evaluating an index may cause an
     error message for an invalid
     expression.  E.g.: >
        :let l = [1, 2, 3]
        :echo exists("l[5]")
<        0 >
        :echo exists("l[xx]")
<        E121: Undefined variable: xx
        0
   :cmdname Ex command: built-in command, user
     command or command modifier |:command|.
     Returns:
     1  for match with start of a command
     2  full match with a command
     3  matches several user commands
     To check for a supported command
     always check the return value to be 2.
   :2match  The |:2match| command.
   :3match  The |:3match| command.
   #event  autocommand defined for this event
   #event#pattern autocommand defined for this event and
     pattern (the pattern is taken
     literally and compared to the
     autocommand patterns character by
     character)
   #group  autocommand group exists
   #group#event autocommand defined for this group and
     event.
   #group#event#pattern
     autocommand defined for this group,
     event and pattern.
   ##event  autocommand for this event is
     supported.

  Examples: >
   exists("&mouse")
   exists("$HOSTNAME")
   exists("*strftime")
   exists("*s:MyFunc")
   exists("bufcount")
   exists(":Make")
   exists("#CursorHold")
   exists("#BufReadPre#*.gz")
   exists("#filetypeindent")
   exists("#filetypeindent#FileType")
   exists("#filetypeindent#FileType#*")
   exists("##ColorScheme")
<  There must be no space between the symbol (&/$/*/#) and the
  name.
  There must be no extra characters after the name, although in
  a few cases this is ignored.  That may become more strict in
  the future, thus don't count on it!
  Working example: >
   exists(":make")
<  NOT working example: >
   exists(":make install")

<  Note that the argument must be a string, not the name of the
  variable itself.  For example: >
   exists(bufcount)
<  This doesn't check for existence of the "bufcount" variable,
  but gets the value of "bufcount", and checks if that exists.]],
  ["nr2char"] = [[nr2char({expr}[, {utf8}]) String
---------
  Return a string with a single character, which has the number
  value {expr}.  Examples: >
   nr2char(64)  returns "@"
   nr2char(32)  returns " "
<  Example for "utf-8": >
   nr2char(300)  returns I with bow character
<  UTF-8 encoding is always used, {utf8} option has no effect,
  and exists only for backwards-compatibility.
  Note that a NUL character in the file is specified with
  nr2char(10), because NULs are represented with newline
  characters.  nr2char(0) is a real NUL and terminates the
  string, thus results in an empty string.

nvim_...({...})     *E5555* *nvim_...()* *eval-api*
  Call nvim |api| functions. The type checking of arguments will
  be stricter than for most other builtins. For instance,
  if Integer is expected, a |Number| must be passed in, a
  |String| will not be autoconverted.
  Buffer numbers, as returned by |bufnr()| could be used as
  first argument to nvim_buf_... functions.  All functions
  expecting an object (buffer, window or tabpage) can
  also take the numerical value 0 to indicate the current
  (focused) object.]],
  ["getchar"] = [[getchar([expr]) Number
---------
  Get a single character from the user or input stream.
  If [expr] is omitted, wait until a character is available.
  If [expr] is 0, only get a character when one is available.
   Return zero otherwise.
  If [expr] is 1, only check if a character is available, it is
   not consumed.  Return zero if no character available.

  Without [expr] and when [expr] is 0 a whole character or
  special key is returned.  If it is a single character, the
  result is a number.  Use nr2char() to convert it to a String.
  Otherwise a String is returned with the encoded character.
  For a special key it's a String with a sequence of bytes
  starting with 0x80 (decimal: 128).  This is the same value as
  the String "\<Key>", e.g., "\<Left>".  The returned value is
  also a String when a modifier (shift, control, alt) was used
  that is not included in the character.

  When [expr] is 0 and Esc is typed, there will be a short delay
  while Vim waits to see if this is the start of an escape
  sequence.

  When [expr] is 1 only the first byte is returned.  For a
  one-byte character it is the character itself as a number.
  Use nr2char() to convert it to a String.

  Use getcharmod() to obtain any additional modifiers.

  When the user clicks a mouse button, the mouse event will be
  returned.  The position can then be found in |v:mouse_col|,
  |v:mouse_lnum|, |v:mouse_winid| and |v:mouse_win|.  This
  example positions the mouse as it would normally happen: >
   let c = getchar()
   if c == "\<LeftMouse>" && v:mouse_win > 0
     exe v:mouse_win . "wincmd w"
     exe v:mouse_lnum
     exe "normal " . v:mouse_col . "|"
   endif
<
  There is no prompt, you will somehow have to make clear to the
  user that a character has to be typed.
  There is no mapping for the character.
  Key codes are replaced, thus when the user presses the <Del>
  key you get the code for the <Del> key, not the raw character
  sequence.  Examples: >
   getchar() == "\<Del>"
   getchar() == "\<S-Left>"
<  This example redefines "f" to ignore case: >
   :nmap f :call FindChar()<CR>
   :function FindChar()
   :  let c = nr2char(getchar())
   :  while col('.') < col('$') - 1
   :    normal l
   :    if getline('.')[col('.') - 1] ==? c
   :      break
   :    endif
   :  endwhile
   :endfunction]],
  ["matchstr"] = [[matchstr({expr}, {pat}[, {start}[, {count}\]\]) String
---------
  Same as |match()|, but return the matched string.  Example: >
   :echo matchstr("testing", "ing")
<  results in "ing".
  When there is no match "" is returned.
  The {start}, if given, has the same meaning as for |match()|. >
   :echo matchstr("testing", "ing", 2)
<  results in "ing". >
   :echo matchstr("testing", "ing", 5)
<  result is "".
  When {expr} is a |List| then the matching item is returned.
  The type isn't changed, it's not necessarily a String.]],
  ["tabpagenr"] = [[tabpagenr([{arg}]) Number
---------
  The result is a Number, which is the number of the current
  tab page.  The first tab page has number 1.
  The optional argument {arg} supports the following values:
   $ the number of the last tab page (the tab page
    count).
   # the number of the last accessed tab page (where
    |g<Tab>| goes to).  If there is no previous
    tab page, 0 is returned.
  The number can be used with the |:tab| command.
]],
  ["sign_define"] = [[sign_define({name} [, {dict}]) Number
---------
  Define a new sign named {name} or modify the attributes of an
  existing sign.  This is similar to the |:sign-define| command.

  Prefix {name} with a unique text to avoid name collisions.
  There is no {group} like with placing signs.

  The {name} can be a String or a Number.  The optional {dict}
  argument specifies the sign attributes.  The following values
  are supported:
      icon full path to the bitmap file for the sign.
      linehl highlight group used for the whole line the
    sign is placed in.
      text text that is displayed when there is no icon
    or the GUI is not being used.
      texthl highlight group used for the text item
      numhl highlight group used for 'number' column at the
    associated line. Overrides |hl-LineNr|,
    |hl-CursorLineNr|.

  If the sign named {name} already exists, then the attributes
  of the sign are updated.

  Returns 0 on success and -1 on failure.

  Examples: >
   call sign_define("mySign", {"text" : "=>", "texthl" :
     \ "Error", "linehl" : "Search"})]],
  ["bufloaded"] = [[bufloaded({expr}) Number
---------
  The result is a Number, which is |TRUE| if a buffer called
  {expr} exists and is loaded (shown in a window or hidden).
  The {expr} argument is used like with |bufexists()|.]],
  ["synIDattr"] = [[synIDattr({synID}, {what} [, {mode}]) String
---------
  The result is a String, which is the {what} attribute of
  syntax ID {synID}.  This can be used to obtain information
  about a syntax item.
  {mode} can be "gui", "cterm" or "term", to get the attributes
  for that mode.  When {mode} is omitted, or an invalid value is
  used, the attributes for the currently active highlighting are
  used (GUI, cterm or term).
  Use synIDtrans() to follow linked highlight groups.
  {what}  result
  "name"  the name of the syntax item
  "fg"  foreground color (GUI: color name used to set
    the color, cterm: color number as a string,
    term: empty string)
  "bg"  background color (as with "fg")
  "font"  font name (only available in the GUI)
    |highlight-font|
  "sp"  special color (as with "fg") |highlight-guisp|
  "fg#"  like "fg", but for the GUI and the GUI is
    running the name in "#RRGGBB" form
  "bg#"  like "fg#" for "bg"
  "sp#"  like "fg#" for "sp"
  "bold"  "1" if bold
  "italic" "1" if italic
  "reverse" "1" if reverse
  "inverse" "1" if inverse (= reverse)
  "standout" "1" if standout
  "underline" "1" if underlined
  "undercurl" "1" if undercurled
  "strikethrough" "1" if struckthrough

  Example (echoes the color of the syntax item under the
  cursor): >
 :echo synIDattr(synIDtrans(synID(line("."), col("."), 1)), "fg")]],
  ["setenv"] = [[setenv({name}, {val}) none
---------
  Set environment variable {name} to {val}.
  When {val} is |v:null| the environment variable is deleted.
  See also |expr-env|.]],
  ["glob"] = [[glob({expr} [, {nosuf} [, {list} [, {alllinks}\]\]\]) any
---------
  Expand the file wildcards in {expr}.  See |wildcards| for the
  use of special characters.

  Unless the optional {nosuf} argument is given and is |TRUE|,
  the 'suffixes' and 'wildignore' options apply: Names matching
  one of the patterns in 'wildignore' will be skipped and
  'suffixes' affect the ordering of matches.
  'wildignorecase' always applies.

  When {list} is present and it is |TRUE| the result is a List
  with all matching files. The advantage of using a List is,
  you also get filenames containing newlines correctly.
  Otherwise the result is a String and when there are several
  matches, they are separated by <NL> characters.

  If the expansion fails, the result is an empty String or List.

  You can also use |readdir()| if you need to do complicated
  things, such as limiting the number of matches.

  A name for a non-existing file is not included.  A symbolic
  link is only included if it points to an existing file.
  However, when the {alllinks} argument is present and it is
  |TRUE| then all symbolic links are included.

  For most systems backticks can be used to get files names from
  any external command.  Example: >
   :let tagfiles = glob("`find . -name tags -print`")
   :let &tags = substitute(tagfiles, "\n", ",", "g")
<  The result of the program inside the backticks should be one
  item per line.  Spaces inside an item are allowed.

  See |expand()| for expanding special Vim variables.  See
  |system()| for getting the raw output of an external command.]],
  ["wincol"] = [[wincol() Number
---------
  cursor in the window.  This is counting screen cells from the
  left side of the window.  The leftmost column is one.]],
  ["winsaveview"] = [[winsaveview() Dict
---------
  the view of the current window.  Use |winrestview()| to
  restore the view.
  This is useful if you have a mapping that jumps around in the
  buffer and you want to go back to the original view.
  This does not save fold information.  Use the 'foldenable'
  option to temporarily switch off folding, so that folds are
  not opened when moving around. This may have side effects.
  The return value includes:
   lnum  cursor line number
   col  cursor column (Note: the first column
     zero, as opposed to what getpos()
     returns)
   coladd  cursor column offset for 'virtualedit'
   curswant column for vertical movement
   topline  first line in the window
   topfill  filler lines, only in diff mode
   leftcol  first column displayed
   skipcol  columns skipped
  Note that no option values are saved.
]],
  ["line"] = [[line({expr}) Number
---------
  position given with {expr}.  The accepted positions are:
      .     the cursor position
      $     the last line in the current buffer
      'x     position of mark x (if the mark is not set, 0 is
       returned)
      w0     first line visible in current window (one if the
       display isn't updated, e.g. in silent Ex mode)
      w$     last line visible in current window (this is one
       less than "w0" if no lines are visible)
      v     In Visual mode: the start of the Visual area (the
       cursor is the end).  When not in Visual mode
       returns the cursor position.  Differs from |'<| in
       that it's updated right away.
  Note that a mark in another file can be used.  The line number
  then applies to another buffer.
  To get the column number use |col()|.  To get both use
  |getpos()|.
  Examples: >
   line(".")  line number of the cursor
   line("'t")  line number of mark t
   line("'" . marker) line number of mark marker]],
  ["reg_executing"] = [[reg_executing() String
---------
  Returns the single letter name of the register being executed.
  Returns an empty string when no register is being executed.
  See |@|.]],
  ["stdpath"] = [[stdpath({what}) String/List
---------
  Returns |standard-path| locations of various default files and
  directories.

  {what}       Type    Description ~
  cache        String  Cache directory. Arbitrary temporary
                       storage for plugins, etc.
  config       String  User configuration directory. The
                       |init.vim| is stored here.
  config_dirs  List    Additional configuration directories.
  data         String  User data directory. The |shada-file|
                       is stored here.
  data_dirs    List    Additional data directories.

  Example: >
   :echo stdpath("config")
]],
  ["getpos"] = [[getpos({expr}) List
---------
  see |line()|.  For getting the cursor position see
  |getcurpos()|.
  The result is a |List| with four numbers:
      [bufnum, lnum, col, off]
  "bufnum" is zero, unless a mark like '0 or 'A is used, then it
  is the buffer number of the mark.
  "lnum" and "col" are the position in the buffer.  The first
  column is 1.
  The "off" number is zero, unless 'virtualedit' is used.  Then
  it is the offset in screen columns from the start of the
  character.  E.g., a position within a <Tab> or after the last
  character.
  Note that for '< and '> Visual mode matters: when it is "V"
  (visual line mode) the column of '< is zero and the column of
  '> is a large number.
  This can be used to save and restore the position of a mark: >
   let save_a_mark = getpos("'a")
   ...
   call setpos("'a", save_a_mark)
<  Also see |getcurpos()| and |setpos()|.
]],
  ["strwidth"] = [[strwidth({expr}) Number
---------
  The result is a Number, which is the number of display cells
  String {expr} occupies.  A Tab character is counted as one
  cell, alternatively use |strdisplaywidth()|.
  When {expr} contains characters with East Asian Width Class
  Ambiguous, this function's return value depends on 'ambiwidth'.
  Also see |strlen()|, |strdisplaywidth()| and |strchars()|.]],
  ["getenv"] = [[getenv({name}) String
---------
  Return the value of environment variable {name}.
  When the variable does not exist |v:null| is returned.  That
  is different from a variable set to an empty string.
  See also |expr-env|.]],
  ["fnamemodify"] = [[fnamemodify({fname}, {mods}) String
---------
  Modify file name {fname} according to {mods}.  {mods} is a
  string of characters like it is used for file names on the
  command line.  See |filename-modifiers|.
  Example: >
   :echo fnamemodify("main.c", ":p:h")
<  results in: >
   /home/mool/vim/vim/src
<  Note: Environment variables don't work in {fname}, use
  |expand()| first then.]],
  ["matchadd"] = [[matchadd({group}, {pattern}[, {priority}[, {id}\]\]) Number
---------
  Defines a pattern to be highlighted in the current window (a
  "match").  It will be highlighted with {group}.  Returns an
  identification number (ID), which can be used to delete the
  match using |matchdelete()|.
  Matching is case sensitive and magic, unless case sensitivity
  or magicness are explicitly overridden in {pattern}.  The
  'magic', 'smartcase' and 'ignorecase' options are not used.
  The "Conceal" value is special, it causes the match to be
  concealed.

  The optional {priority} argument assigns a priority to the
  match.  A match with a high priority will have its
  highlighting overrule that of a match with a lower priority.
  A priority is specified as an integer (negative numbers are no
  exception).  If the {priority} argument is not specified, the
  default priority is 10.  The priority of 'hlsearch' is zero,
  hence all matches with a priority greater than zero will
  overrule it.  Syntax highlighting (see 'syntax') is a separate
  mechanism, and regardless of the chosen priority a match will
  always overrule syntax highlighting.

  The optional {id} argument allows the request for a specific
  match ID.  If a specified ID is already taken, an error
  message will appear and the match will not be added.  An ID
  is specified as a positive integer (zero excluded).  IDs 1, 2
  and 3 are reserved for |:match|, |:2match| and |:3match|,
  respectively.  If the {id} argument is not specified or -1,
  |matchadd()| automatically chooses a free ID.

  The optional {dict} argument allows for further custom
  values. Currently this is used to specify a match specific
  conceal character that will be shown for |hl-Conceal|
  highlighted matches. The dict can have the following members:

   conceal     Special character to show instead of the
        match (only for |hl-Conceal| highlighed
        matches, see |:syn-cchar|)
   window     Instead of the current window use the
        window with this number or window ID.

  The number of matches is not limited, as it is the case with
  the |:match| commands.

  Example: >
   :highlight MyGroup ctermbg=green guibg=green
   :let m = matchadd("MyGroup", "TODO")
<  Deletion of the pattern: >
   :call matchdelete(m)

<  A list of matches defined by |matchadd()| and |:match| are
  available from |getmatches()|.  All matches can be deleted in
  one operation by |clearmatches()|.
]],
  ["byteidx"] = [[byteidx({expr}, {nr}) Number
---------
  Return byte index of the {nr}'th character in the string
  {expr}.  Use zero for the first character, it returns zero.
  This function is only useful when there are multibyte
  characters, otherwise the returned value is equal to {nr}.
  Composing characters are not counted separately, their byte
  length is added to the preceding base character.  See
  |byteidxcomp()| below for counting composing characters
  separately.
  Example : >
   echo matchstr(str, ".", byteidx(str, 3))
<  will display the fourth character.  Another way to do the
  same: >
   let s = strpart(str, byteidx(str, 3))
   echo strpart(s, 0, byteidx(s, 1))
<  Also see |strgetchar()| and |strcharpart()|.

  If there are less than {nr} characters -1 is returned.
  If there are exactly {nr} characters the length of the string
  in bytes is returned.]],
  ["hlID"] = [[hlID({name}) Number
---------
  with name {name}.  When the highlight group doesn't exist,
  zero is returned.
  This can be used to retrieve information about the highlight
  group.  For example, to get the background color of the
  "Comment" group: >
 :echo synIDattr(synIDtrans(hlID("Comment")), "bg")]],
  ["mode"] = [[mode([expr]) String
---------
  If [expr] is supplied and it evaluates to a non-zero Number or
  a non-empty String (|non-zero-arg|), then the full mode is
  returned, otherwise only the first letter is returned.

     n     Normal
     no     Operator-pending
     nov     Operator-pending (forced charwise |o_v|)
     noV     Operator-pending (forced linewise |o_V|)
     noCTRL-V Operator-pending (forced blockwise |o_CTRL-V|)
     niI     Normal using |i_CTRL-O| in |Insert-mode|
     niR     Normal using |i_CTRL-O| in |Replace-mode|
     niV     Normal using |i_CTRL-O| in |Virtual-Replace-mode|
     v     Visual by character
     V     Visual by line
     CTRL-V   Visual blockwise
     s     Select by character
     S     Select by line
     CTRL-S   Select blockwise
     i     Insert
     ic     Insert mode completion |compl-generic|
     ix     Insert mode |i_CTRL-X| completion
     R     Replace |R|
     Rc     Replace mode completion |compl-generic|
     Rv     Virtual Replace |gR|
     Rx     Replace mode |i_CTRL-X| completion
     c     Command-line editing
     cv     Vim Ex mode |gQ|
     ce     Normal Ex mode |Q|
     r     Hit-enter prompt
     rm     The -- more -- prompt
     r?     |:confirm| query of some sort
     !     Shell or external command is executing
     t     Terminal mode: keys go to the job
  This is useful in the 'statusline' option or when used
  with |remote_expr()| In most other places it always returns
  "c" or "n".
  Note that in the future more modes and more specific modes may
  be added. It's better not to compare the whole string but only
  the leading character(s).
  Also see |visualmode()|.]],
  ["synIDtrans"] = [[synIDtrans({synID}) Number
---------
  The result is a Number, which is the translated syntax ID of
  {synID}.  This is the syntax group ID of what is being used to
  highlight the character.  Highlight links given with
  ":highlight link" are followed.]],
  ["bufwinnr"] = [[bufwinnr({expr}) Number
---------
  The result is a Number, which is the number of the first
  window associated with buffer {expr}.  For the use of {expr},
  see |bufname()| above.  If buffer {expr} doesn't exist or
  there is no such window, -1 is returned.  Example: >

 echo "A window containing buffer 1 is " . (bufwinnr(1))

<  The number can be used with |CTRL-W_w| and ":wincmd w"
  |:wincmd|.
  Only deals with the current tab page.
]],
  ["shellescape"] = [[shellescape({string} [, {special}]) String
---------
  Escape {string} for use as a shell command argument.
  On Windows when 'shellslash' is not set, it
  will enclose {string} in double quotes and double all double
  quotes within {string}.
  Otherwise, it will enclose {string} in single quotes and
  replace all "'" with "'\''".

  When the {special} argument is present and it's a non-zero
  Number or a non-empty String (|non-zero-arg|), then special
  items such as "!", "%", "#" and "<cword>" will be preceded by
  a backslash.  This backslash will be removed again by the |:!|
  command.

  The "!" character will be escaped (again with a |non-zero-arg|
  {special}) when 'shell' contains "csh" in the tail.  That is
  because for csh and tcsh "!" is used for history replacement
  even when inside single quotes.

  With a |non-zero-arg| {special} the <NL> character is also
  escaped.  When 'shell' containing "csh" in the tail it's
  escaped a second time.

  Example of use with a |:!| command: >
      :exe '!dir ' . shellescape(expand('<cfile>'), 1)
<  This results in a directory listing for the file under the
  cursor.  Example of use with |system()|: >
      :call system("chmod +w -- " . shellescape(expand("%")))
<  See also |::S|.
]],
  ["sign_getdefined"] = [[sign_getdefined([{name}]) List
---------
  Get a list of defined signs and their attributes.
  This is similar to the |:sign-list| command.

  If the {name} is not supplied, then a list of all the defined
  signs is returned. Otherwise the attribute of the specified
  sign is returned.

  Each list item in the returned value is a dictionary with the
  following entries:
   icon full path to the bitmap file of the sign
   linehl highlight group used for the whole line the
    sign is placed in.
   name name of the sign
   text text that is displayed when there is no icon
    or the GUI is not being used.
   texthl highlight group used for the text item
   numhl highlight group used for 'number' column at the
    associated line. Overrides |hl-LineNr|,
    |hl-CursorLineNr|.

  Returns an empty List if there are no signs and when {name} is
  not found.

  Examples: >
   " Get a list of all the defined signs
   echo sign_getdefined()

   " Get the attribute of the sign named mySign
   echo sign_getdefined("mySign")]],
  ["bufname"] = [[bufname([{expr}]) String
---------
  The result is the name of a buffer, as it is displayed by the
  ":ls" command.
+  If {expr} is omitted the current buffer is used.
  If {expr} is a Number, that buffer number's name is given.
  Number zero is the alternate buffer for the current window.
  If {expr} is a String, it is used as a |file-pattern| to match
  with the buffer names.  This is always done like 'magic' is
  set and 'cpoptions' is empty.  When there is more than one
  match an empty string is returned.
  "" or "%" can be used for the current buffer, "#" for the
  alternate buffer.
  A full match is preferred, otherwise a match at the start, end
  or middle of the buffer name is accepted.  If you only want a
  full match then put "^" at the start and "$" at the end of the
  pattern.
  Listed buffers are found first.  If there is a single match
  with a listed buffer, that one is returned.  Next unlisted
  buffers are searched for.
  If the {expr} is a String, but you want to use it as a buffer
  number, force it to be a Number by adding zero to it: >
   :echo bufname("3" + 0)
<  If the buffer doesn't exist, or doesn't have a name, an empty
  string is returned. >
 bufname("#")  alternate buffer name
 bufname(3)  name of buffer 3
 bufname("%")  name of current buffer
 bufname("file2") name of buffer where "file2" matches.
]],
  ["executable"] = [[executable({expr}) Number
---------
  This function checks if an executable with the name {expr}
  exists.  {expr} must be the name of the program without any
  arguments.
  executable() uses the value of $PATH and/or the normal
  searchpath for programs.  *PATHEXT*
  On Windows the ".exe", ".bat", etc. can
  optionally be included.  Then the extensions in $PATHEXT are
  tried.  Thus if "foo.exe" does not exist, "foo.exe.bat" can be
  found.  If $PATHEXT is not set then ".exe;.com;.bat;.cmd" is
  used.  A dot by itself can be used in $PATHEXT to try using
  the name without an extension.  When 'shell' looks like a
  Unix shell, then the name is also tried without adding an
  extension.
  On Windows it only checks if the file exists and
  is not a directory, not if it's really executable.
  On Windows an executable in the same directory as Vim is
  always found (it is added to $PATH at |startup|).
  The result is a Number:
   1 exists
   0 does not exist
   -1 not implemented on this system
  |exepath()| can be used to get the full path of an executable.]],
  ["winbufnr"] = [[winbufnr({nr}) Number
---------
  associated with window {nr}.  {nr} can be the window number or
  the |window-ID|.
  When {nr} is zero, the number of the buffer in the current
  window is returned.
  When window {nr} doesn't exist, -1 is returned.
  Example: >
  :echo "The file in the current window is " . bufname(winbufnr(0))
<]],
  ["matchdelete"] = [[matchdelete({id}) Number
---------
  Deletes a match with ID {id} previously defined by |matchadd()|
  or one of the |:match| commands.  Returns 0 if successful,
  otherwise -1.  See example for |matchadd()|.  All matches can
  be deleted in one operation by |clearmatches()|.]],
}
