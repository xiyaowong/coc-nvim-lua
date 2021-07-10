return {
  ["nvim_win_get_number"] = [[nvim_win_get_number({window}) 
---------
                Gets the window number

                Parameters: ~
                    {window}  Window handle, or 0 for current window

                Return: ~
                    Window number]],
  ["nvim_buf_get_extmarks"] = [[nvim_buf_get_extmarks({buffer}, {ns_id}, {start}, {end}, {opts}) 
---------
                Gets extmarks in "traversal order" from a |charwise| region
                defined by buffer positions (inclusive, 0-indexed
                |api-indexing|).

                Region can be given as (row,col) tuples, or valid extmark ids
                (whose positions define the bounds). 0 and -1 are understood
                as (0,0) and (-1,-1) respectively, thus the following are
                equivalent:
>
                  nvim_buf_get_extmarks(0, my_ns, 0, -1, {})
                  nvim_buf_get_extmarks(0, my_ns, [0,0], [-1,-1], {})
<

                If `end` is less than `start` , traversal works backwards.
                (Useful with `limit` , to get the first marks prior to a given
                position.)

                Example:
>
                  local a   = vim.api
                  local pos = a.nvim_win_get_cursor(0)
                  local ns  = a.nvim_create_namespace('my-plugin')
                  -- Create new extmark at line 1, column 1.
                  local m1  = a.nvim_buf_set_extmark(0, ns, 0, 0, 0, {})
                  -- Create new extmark at line 3, column 1.
                  local m2  = a.nvim_buf_set_extmark(0, ns, 0, 2, 0, {})
                  -- Get extmarks only from line 3.
                  local ms  = a.nvim_buf_get_extmarks(0, ns, {2,0}, {2,0}, {})
                  -- Get all marks in this buffer + namespace.
                  local all = a.nvim_buf_get_extmarks(0, ns, 0, -1, {})
                  print(vim.inspect(ms))
<

                Parameters: ~
                    {buffer}  Buffer handle, or 0 for current buffer
                    {ns_id}   Namespace id from |nvim_create_namespace()|
                    {start}   Start of range, given as (row, col) or valid
                              extmark id (whose position defines the bound)
                    {end}     End of range, given as (row, col) or valid
                              extmark id (whose position defines the bound)
                    {opts}    Optional parameters. Keys:
                              • limit: Maximum number of marks to return

                Return: ~
                    List of [extmark_id, row, col] tuples in "traversal
                    order".]],
  ["nvim_buf_get_lines"] = [[nvim_buf_get_lines({buffer}, {start}, {end}, {strict_indexing}) 
---------
                Gets a line-range from the buffer.

                Indexing is zero-based, end-exclusive. Negative indices are
                interpreted as length+1+index: -1 refers to the index past the
                end. So to get the last element use start=-2 and end=-1.

                Out-of-bounds indices are clamped to the nearest valid value,
                unless `strict_indexing` is set.

                Parameters: ~
                    {buffer}           Buffer handle, or 0 for current buffer
                    {start}            First line index
                    {end}              Last line index (exclusive)
                    {strict_indexing}  Whether out-of-bounds should be an
                                       error.

                Return: ~
                    Array of lines, or empty array for unloaded buffer.]],
  ["nvim_buf_line_count"] = [[nvim_buf_line_count({buffer}) 
---------
                Gets the buffer line count

                Parameters: ~
                    {buffer}  Buffer handle, or 0 for current buffer

                Return: ~
                    Line count, or 0 for unloaded buffer. |api-buffer|
]],
  ["nvim_err_write"] = [[nvim_err_write({str}) 
---------
                Writes a message to the Vim error buffer. Does not append
                "\n", the message is buffered (won't display) until a linefeed
                is written.

                Parameters: ~
                    {str}  Message]],
  ["nvim_win_get_var"] = [[nvim_win_get_var({window}, {name}) 
---------
                Gets a window-scoped (w:) variable

                Parameters: ~
                    {window}  Window handle, or 0 for current window
                    {name}    Variable name

                Return: ~
                    Variable value]],
  ["nvim__stats"] = [[nvim__stats() 
---------
                Gets internal stats.

                Return: ~
                    Map of various internal stats.]],
  ["nvim_tabpage_get_win"] = [[nvim_tabpage_get_win({tabpage}) 
---------
                Gets the current window in a tabpage

                Parameters: ~
                    {tabpage}  Tabpage handle, or 0 for current tabpage

                Return: ~
                    Window handle]],
  ["nvim_buf_set_name"] = [[nvim_buf_set_name({buffer}, {name}) 
---------
                Sets the full file name for a buffer

                Parameters: ~
                    {buffer}  Buffer handle, or 0 for current buffer
                    {name}    Buffer name]],
  ["nvim_del_keymap"] = [[nvim_del_keymap({mode}, {lhs}) 
---------
                Unmaps a global |mapping| for the given mode.

                To unmap a buffer-local mapping, use |nvim_buf_del_keymap()|.

                See also: ~
                    |nvim_set_keymap()|]],
  ["nvim_input_mouse"] = [[nvim_input_mouse({button}, {action}, {modifier}, {grid}, {row}, {col}) 
---------
                Send mouse event from GUI.

                Non-blocking: does not wait on any result, but queues the
                event to be processed soon by the event loop.

                Note:
                    Currently this doesn't support "scripting" multiple mouse
                    events by calling it multiple times in a loop: the
                    intermediate mouse positions will be ignored. It should be
                    used to implement real-time mouse input in a GUI. The
                    deprecated pseudokey form ("<LeftMouse><col,row>") of
                    |nvim_input()| has the same limitiation.

                Attributes: ~
                    {fast}

                Parameters: ~
                    {button}    Mouse button: one of "left", "right",
                                "middle", "wheel".
                    {action}    For ordinary buttons, one of "press", "drag",
                                "release". For the wheel, one of "up", "down",
                                "left", "right".
                    {modifier}  String of modifiers each represented by a
                                single char. The same specifiers are used as
                                for a key press, except that the "-" separator
                                is optional, so "C-A-", "c-a" and "CA" can all
                                be used to specify Ctrl+Alt+click.
                    {grid}      Grid number if the client uses |ui-multigrid|,
                                else 0.
                    {row}       Mouse row-position (zero-based, like redraw
                                events)
                    {col}       Mouse column-position (zero-based, like redraw
                                events)]],
  ["nvim_command"] = [[nvim_command({command}) 
---------
                Executes an ex-command.

                On execution error: fails with VimL error, does not update
                v:errmsg.

                Parameters: ~
                    {command}  Ex-command string

                See also: ~
                    |nvim_exec()|]],
  ["nvim_buf_set_lines"] = [[nvim_buf_set_lines({buffer}, {start}, {end}, {strict_indexing}, {replacement}) 
---------
                Sets (replaces) a line-range in the buffer.

                Indexing is zero-based, end-exclusive. Negative indices are
                interpreted as length+1+index: -1 refers to the index past the
                end. So to change or delete the last element use start=-2 and
                end=-1.

                To insert lines at a given index, set `start` and `end` to the
                same index. To delete a range of lines, set `replacement` to
                an empty array.

                Out-of-bounds indices are clamped to the nearest valid value,
                unless `strict_indexing` is set.

                Parameters: ~
                    {buffer}           Buffer handle, or 0 for current buffer
                    {start}            First line index
                    {end}              Last line index (exclusive)
                    {strict_indexing}  Whether out-of-bounds should be an
                                       error.
                    {replacement}      Array of lines to use as replacement]],
  ["nvim_set_current_tabpage"] = [[nvim_set_current_tabpage({tabpage}) 
---------
                Sets the current tabpage.

                Parameters: ~
                    {tabpage}  Tabpage handle]],
  ["nvim_buf_get_changedtick"] = [[nvim_buf_get_changedtick({buffer}) 
---------
                Gets a changed tick of a buffer

                Parameters: ~
                    {buffer}  Buffer handle, or 0 for current buffer

                Return: ~
                    `b:changedtick` value.]],
  ["nvim_win_del_var"] = [[nvim_win_del_var({window}, {name}) 
---------
                Removes a window-scoped (w:) variable

                Parameters: ~
                    {window}  Window handle, or 0 for current window
                    {name}    Variable name]],
  ["nvim_create_namespace"] = [[nvim_create_namespace({name}) 
---------
                Creates a new namespace, or gets an existing one.

                Namespaces are used for buffer highlights and virtual text,
                see |nvim_buf_add_highlight()| and
                |nvim_buf_set_virtual_text()|.

                Namespaces can be named or anonymous. If `name` matches an
                existing namespace, the associated id is returned. If `name`
                is an empty string a new, anonymous namespace is created.

                Parameters: ~
                    {name}  Namespace name or empty string

                Return: ~
                    Namespace id]],
  ["nvim__id"] = [[nvim__id({obj}) 
---------
                Returns object given as argument.

                This API function is used for testing. One should not rely on
                its presence in plugins.

                Parameters: ~
                    {obj}  Object to return.

                Return: ~
                    its argument.]],
  ["nvim_buf_get_option"] = [[nvim_buf_get_option({buffer}, {name}) 
---------
                Gets a buffer option value

                Parameters: ~
                    {buffer}  Buffer handle, or 0 for current buffer
                    {name}    Option name

                Return: ~
                    Option value]],
  ["nvim_buf_get_name"] = [[nvim_buf_get_name({buffer}) 
---------
                Gets the full file name for the buffer

                Parameters: ~
                    {buffer}  Buffer handle, or 0 for current buffer

                Return: ~
                    Buffer name]],
  ["nvim_tabpage_list_wins"] = [[nvim_tabpage_list_wins({tabpage}) 
---------
                Gets the windows in a tabpage

                Parameters: ~
                    {tabpage}  Tabpage handle, or 0 for current tabpage

                Return: ~
                    List of windows in `tabpage`
]],
  ["nvim_get_proc_children"] = [[nvim_get_proc_children({pid}) 
---------
                Gets the immediate children of process `pid` .

                Return: ~
                    Array of child process ids, empty if process not found.]],
  ["nvim_eval"] = [[nvim_eval({expr}) 
---------
                Evaluates a VimL |expression|. Dictionaries and Lists are
                recursively expanded.

                On execution error: fails with VimL error, does not update
                v:errmsg.

                Parameters: ~
                    {expr}  VimL expression string

                Return: ~
                    Evaluation result or expanded object]],
  ["nvim_buf_set_extmark"] = [[nvim_buf_set_extmark({buffer}, {ns_id}, {id}, {line}, {col}, {opts}) 
---------
                Creates or updates an extmark.

                To create a new extmark, pass id=0. The extmark id will be
                returned. It is also allowed to create a new mark by passing
                in a previously unused id, but the caller must then keep track
                of existing and unused ids itself. (Useful over RPC, to avoid
                waiting for the return value.)

                Parameters: ~
                    {buffer}  Buffer handle, or 0 for current buffer
                    {ns_id}   Namespace id from |nvim_create_namespace()|
                    {id}      Extmark id, or 0 to create new
                    {line}    Line number where to place the mark
                    {col}     Column where to place the mark
                    {opts}    Optional parameters. Currently not used.

                Return: ~
                    Id of the created/updated extmark
]],
  ["nvim_list_chans"] = [[nvim_list_chans() 
---------
                Get information about all open channels.

                Return: ~
                    Array of Dictionaries, each describing a channel with the
                    format specified at |nvim_get_chan_info()|.]],
  ["nvim_paste"] = [[nvim_paste({data}, {crlf}, {phase}) 
---------
                Pastes at cursor, in any mode.

                Invokes the `vim.paste` handler, which handles each mode
                appropriately. Sets redo/undo. Faster than |nvim_input()|.
                Lines break at LF ("\n").

                Errors ('nomodifiable', `vim.paste()` failure, …) are
                reflected in `err` but do not affect the return value (which
                is strictly decided by `vim.paste()` ). On error, subsequent
                calls are ignored ("drained") until the next paste is
                initiated (phase 1 or -1).

                Parameters: ~
                    {data}   Multiline input. May be binary (containing NUL
                             bytes).
                    {crlf}   Also break lines at CR and CRLF.
                    {phase}  -1: paste in a single call (i.e. without
                             streaming). To "stream" a paste, call `nvim_paste` sequentially with these `phase` values:
                             • 1: starts the paste (exactly once)
                             • 2: continues the paste (zero or more times)
                             • 3: ends the paste (exactly once)

                Return: ~

                    • true: Client may continue pasting.
                    • false: Client must cancel the paste.]],
  ["nvim_get_color_by_name"] = [[nvim_get_color_by_name({name}) 
---------
                Returns the 24-bit RGB value of a |nvim_get_color_map()| color
                name or "#rrggbb" hexadecimal string.

                Example: >
                    :echo nvim_get_color_by_name("Pink")
                    :echo nvim_get_color_by_name("#cbcbcb")
<

                Parameters: ~
                    {name}  Color name or "#rrggbb" string

                Return: ~
                    24-bit RGB value, or -1 for invalid argument.]],
  ["nvim_list_uis"] = [[nvim_list_uis() 
---------
                Gets a list of dictionaries representing attached UIs.

                Return: ~
                    Array of UI dictionaries, each with these keys:
                    • "height" Requested height of the UI
                    • "width" Requested width of the UI
                    • "rgb" true if the UI uses RGB colors (false implies
                      |cterm-colors|)
                    • "ext_..." Requested UI extensions, see |ui-option|
                    • "chan" Channel id of remote UI (not present for TUI)]],
  ["nvim_buf_del_extmark"] = [[nvim_buf_del_extmark({buffer}, {ns_id}, {id}) 
---------
                Removes an extmark.

                Parameters: ~
                    {buffer}  Buffer handle, or 0 for current buffer
                    {ns_id}   Namespace id from |nvim_create_namespace()|
                    {id}      Extmark id

                Return: ~
                    true if the extmark was found, else false]],
  ["nvim_win_is_valid"] = [[nvim_win_is_valid({window}) 
---------
                Checks if a window is valid

                Parameters: ~
                    {window}  Window handle, or 0 for current window

                Return: ~
                    true if the window is valid, false otherwise]],
  ["nvim_buf_set_var"] = [[nvim_buf_set_var({buffer}, {name}, {value}) 
---------
                Sets a buffer-scoped (b:) variable

                Parameters: ~
                    {buffer}  Buffer handle, or 0 for current buffer
                    {name}    Variable name
                    {value}   Variable value
]],
  ["nvim_win_set_height"] = [[nvim_win_set_height({window}, {height}) 
---------
                Sets the window height. This will only succeed if the screen
                is split horizontally.

                Parameters: ~
                    {window}  Window handle, or 0 for current window
                    {height}  Height as a count of rows]],
  ["nvim_feedkeys"] = [[nvim_feedkeys({keys}, {mode}, {escape_csi}) 
---------
                Sends input-keys to Nvim, subject to various quirks controlled
                by `mode` flags. This is a blocking call, unlike
                |nvim_input()|.

                On execution error: does not fail, but updates v:errmsg.

                Parameters: ~
                    {keys}        to be typed
                    {mode}        behavior flags, see |feedkeys()|
                    {escape_csi}  If true, escape K_SPECIAL/CSI bytes in
                                  `keys`

                See also: ~
                    feedkeys()
                    vim_strsave_escape_csi]],
  ["nvim_buf_get_keymap"] = [[nvim_buf_get_keymap({buffer}, {mode}) 
---------
                Gets a list of buffer-local |mapping| definitions.

                Parameters: ~
                    {mode}    Mode short-name ("n", "i", "v", ...)
                    {buffer}  Buffer handle, or 0 for current buffer

                Return: ~
                    Array of maparg()-like dictionaries describing mappings.
                    The "buffer" key holds the associated buffer handle.
]],
  ["nvim_win_set_option"] = [[nvim_win_set_option({window}, {name}, {value}) 
---------
                Sets a window option value. Passing 'nil' as value deletes the
                option(only works if there's a global fallback)

                Parameters: ~
                    {window}  Window handle, or 0 for current window
                    {name}    Option name
                    {value}   Option value]],
  ["nvim_win_get_width"] = [[nvim_win_get_width({window}) 
---------
                Gets the window width

                Parameters: ~
                    {window}  Window handle, or 0 for current window

                Return: ~
                    Width as a count of columns]],
  ["nvim_win_set_var"] = [[nvim_win_set_var({window}, {name}, {value}) 
---------
                Sets a window-scoped (w:) variable

                Parameters: ~
                    {window}  Window handle, or 0 for current window
                    {name}    Variable name
                    {value}   Variable value]],
  ["nvim_tabpage_get_number"] = [[nvim_tabpage_get_number({tabpage}) 
---------
                Gets the tabpage number

                Parameters: ~
                    {tabpage}  Tabpage handle, or 0 for current tabpage

                Return: ~
                    Tabpage number]],
  ["nvim_get_vvar"] = [[nvim_get_vvar({name}) 
---------
                Gets a v: variable.

                Parameters: ~
                    {name}  Variable name

                Return: ~
                    Variable value]],
  ["nvim_get_hl_by_name"] = [[nvim_get_hl_by_name({name}, {rgb}) 
---------
                Gets a highlight definition by name.

                Parameters: ~
                    {name}  Highlight group name
                    {rgb}   Export RGB colors

                Return: ~
                    Highlight definition map

                See also: ~
                    nvim_get_hl_by_id]],
  ["nvim_buf_set_virtual_text"] = [[nvim_buf_set_virtual_text({buffer}, {ns_id}, {line}, {chunks}, {opts}) 
---------
                Set the virtual text (annotation) for a buffer line.

                By default (and currently the only option) the text will be
                placed after the buffer text. Virtual text will never cause
                reflow, rather virtual text will be truncated at the end of
                the screen line. The virtual text will begin one cell
                (|lcs-eol| or space) after the ordinary text.

                Namespaces are used to support batch deletion/updating of
                virtual text. To create a namespace, use
                |nvim_create_namespace|. Virtual text is cleared using
                |nvim_buf_clear_namespace|. The same `ns_id` can be used for
                both virtual text and highlights added by
                |nvim_buf_add_highlight|, both can then be cleared with a
                single call to |nvim_buf_clear_namespace|. If the virtual text
                never will be cleared by an API call, pass `ns_id = -1` .

                As a shorthand, `ns_id = 0` can be used to create a new
                namespace for the virtual text, the allocated id is then
                returned.

                Parameters: ~
                    {buffer}  Buffer handle, or 0 for current buffer
                    {ns_id}   Namespace to use or 0 to create a namespace, or
                              -1 for a ungrouped annotation
                    {line}    Line to annotate with virtual text
                              (zero-indexed)
                    {chunks}  A list of [text, hl_group] arrays, each
                              representing a text chunk with specified
                              highlight. `hl_group` element can be omitted for
                              no highlight.
                    {opts}    Optional parameters. Currently not used.

                Return: ~
                    The ns_id that was used
]],
  ["nvim_tabpage_get_var"] = [[nvim_tabpage_get_var({tabpage}, {name}) 
---------
                Gets a tab-scoped (t:) variable

                Parameters: ~
                    {tabpage}  Tabpage handle, or 0 for current tabpage
                    {name}     Variable name

                Return: ~
                    Variable value]],
  ["nvim_win_set_width"] = [[nvim_win_set_width({window}, {width}) 
---------
                Sets the window width. This will only succeed if the screen is
                split vertically.

                Parameters: ~
                    {window}  Window handle, or 0 for current window
                    {width}   Width as a count of columns
]],
  ["nvim_open_win"] = [[nvim_open_win({buffer}, {enter}, {config}) 
---------
                Open a new window.

                Currently this is used to open floating and external windows.
                Floats are windows that are drawn above the split layout, at
                some anchor position in some other window. Floats can be drawn
                internally or by external GUI with the |ui-multigrid|
                extension. External windows are only supported with multigrid
                GUIs, and are displayed as separate top-level windows.

                For a general overview of floats, see |api-floatwin|.

                Exactly one of `external` and `relative` must be specified.
                The `width` and `height` of the new window must be specified.

                With relative=editor (row=0,col=0) refers to the top-left
                corner of the screen-grid and (row=Lines-1,col=Columns-1)
                refers to the bottom-right corner. Fractional values are
                allowed, but the builtin implementation (used by non-multigrid
                UIs) will always round down to nearest integer.

                Out-of-bounds values, and configurations that make the float
                not fit inside the main editor, are allowed. The builtin
                implementation truncates values so floats are fully within the
                main screen grid. External GUIs could let floats hover outside
                of the main window like a tooltip, but this should not be used
                to specify arbitrary WM screen positions.

                Example (Lua): window-relative float >
                    vim.api.nvim_open_win(0, false,
                      {relative='win', row=3, col=3, width=12, height=3})
<

                Example (Lua): buffer-relative float (travels as buffer is
                scrolled) >
                    vim.api.nvim_open_win(0, false,
                      {relative='win', width=12, height=3, bufpos={100,10}})
<

                Parameters: ~
                    {buffer}  Buffer to display, or 0 for current buffer
                    {enter}   Enter the window (make it the current window)
                    {config}  Map defining the window configuration. Keys:
                              • `relative`: Sets the window layout to "floating", placed
                                at (row,col) coordinates relative to:
                                • "editor" The global editor grid
                                • "win" Window given by the `win` field, or
                                  current window.
                                • "cursor" Cursor position in current window.

                              • `win` : |window-ID| for relative="win".
                              • `anchor`: Decides which corner of the float to place
                                at (row,col):
                                • "NW" northwest (default)
                                • "NE" northeast
                                • "SW" southwest
                                • "SE" southeast

                              • `width` : Window width (in character cells).
                                Minimum of 1.
                              • `height` : Window height (in character cells).
                                Minimum of 1.
                              • `bufpos` : Places float relative to buffer
                                text (only when relative="win"). Takes a tuple
                                of zero-indexed [line, column]. `row` and
                                `col` if given are applied relative to this
                                position, else they default to `row=1` and
                                `col=0` (thus like a tooltip near the buffer
                                text).
                              • `row` : Row position in units of "screen cell
                                height", may be fractional.
                              • `col` : Column position in units of "screen
                                cell width", may be fractional.
                              • `focusable` : Enable focus by user actions
                                (wincmds, mouse events). Defaults to true.
                                Non-focusable windows can be entered by
                                |nvim_set_current_win()|.
                              • `external` : GUI should display the window as
                                an external top-level window. Currently
                                accepts no other positioning configuration
                                together with this.
                              • `style`: Configure the appearance of the window.
                                Currently only takes one non-empty value:
                                • "minimal" Nvim will display the window with
                                  many UI options disabled. This is useful
                                  when displaying a temporary float where the
                                  text should not be edited. Disables
                                  'number', 'relativenumber', 'cursorline',
                                  'cursorcolumn', 'foldcolumn', 'spell' and
                                  'list' options. 'signcolumn' is changed to
                                  `auto` and 'colorcolumn' is cleared. The
                                  end-of-buffer region is hidden by setting
                                  `eob` flag of 'fillchars' to a space char,
                                  and clearing the |EndOfBuffer| region in
                                  'winhighlight'.

                Return: ~
                    Window handle, or 0 on error]],
  ["nvim_win_set_buf"] = [[nvim_win_set_buf({window}, {buffer}) 
---------
                Sets the current buffer in a window, without side-effects

                Parameters: ~
                    {window}  Window handle, or 0 for current window
                    {buffer}  Buffer handle]],
  ["nvim_win_get_config"] = [[nvim_win_get_config({window}) 
---------
                Gets window configuration.

                The returned value may be given to |nvim_open_win()|.

                `relative` is empty for normal windows.

                Parameters: ~
                    {window}  Window handle, or 0 for current window

                Return: ~
                    Map defining the window configuration, see
                    |nvim_open_win()|]],
  ["nvim_get_hl_by_id"] = [[nvim_get_hl_by_id({hl_id}, {rgb}) 
---------
                Gets a highlight definition by id. |hlID()|

                Parameters: ~
                    {hl_id}  Highlight id as returned by |hlID()|
                    {rgb}    Export RGB colors

                Return: ~
                    Highlight definition map

                See also: ~
                    nvim_get_hl_by_name]],
  ["nvim_get_commands"] = [[nvim_get_commands({opts}) 
---------
                Gets a map of global (non-buffer-local) Ex commands.

                Currently only |user-commands| are supported, not builtin Ex
                commands.

                Parameters: ~
                    {opts}  Optional parameters. Currently only supports
                            {"builtin":false}

                Return: ~
                    Map of maps describing commands.]],
  ["nvim_create_buf"] = [[nvim_create_buf({listed}, {scratch}) 
---------
                Creates a new, empty, unnamed buffer.

                Parameters: ~
                    {listed}   Sets 'buflisted'
                    {scratch}  Creates a "throwaway" |scratch-buffer| for
                               temporary work (always 'nomodified')

                Return: ~
                    Buffer handle, or 0 on error

                See also: ~
                    buf_open_scratch]],
  ["nvim_win_get_cursor"] = [[nvim_win_get_cursor({window}) 
---------
                Gets the (1,0)-indexed cursor position in the window.
                |api-indexing|

                Parameters: ~
                    {window}  Window handle, or 0 for current window

                Return: ~
                    (row, col) tuple]],
  ["nvim_strwidth"] = [[nvim_strwidth({text}) 
---------
                Calculates the number of display cells occupied by `text` .
                <Tab> counts as one cell.

                Parameters: ~
                    {text}  Some text

                Return: ~
                    Number of cells]],
  ["nvim_get_option"] = [[nvim_get_option({name}) 
---------
                Gets an option value string.

                Parameters: ~
                    {name}  Option name

                Return: ~
                    Option value (global)]],
  ["nvim_get_color_map"] = [[nvim_get_color_map() 
---------
                Returns a map of color names and RGB values.

                Keys are color names (e.g. "Aqua") and values are 24-bit RGB
                color values (e.g. 65535).

                Return: ~
                    Map of color names and RGB values.]],
  ["nvim_list_bufs"] = [[nvim_list_bufs() 
---------
                Gets the current list of buffer handles

                Includes unlisted (unloaded/deleted) buffers, like `:ls!` .
                Use |nvim_buf_is_loaded()| to check if a buffer is loaded.

                Return: ~
                    List of buffer handles]],
  ["nvim_set_current_dir"] = [[nvim_set_current_dir({dir}) 
---------
                Changes the global working directory.

                Parameters: ~
                    {dir}  Directory path]],
  ["nvim_load_context"] = [[nvim_load_context({dict}) 
---------
                Sets the current editor state from the given |context| map.

                Parameters: ~
                    {dict}  |Context| map.]],
  ["nvim_buf_get_mark"] = [[nvim_buf_get_mark({buffer}, {name}) 
---------
                Return a tuple (row,col) representing the position of the
                named mark.

                Marks are (1,0)-indexed. |api-indexing|

                Parameters: ~
                    {buffer}  Buffer handle, or 0 for current buffer
                    {name}    Mark name

                Return: ~
                    (row, col) tuple]],
  ["nvim_buf_get_var"] = [[nvim_buf_get_var({buffer}, {name}) 
---------
                Gets a buffer-scoped (b:) variable.

                Parameters: ~
                    {buffer}  Buffer handle, or 0 for current buffer
                    {name}    Variable name

                Return: ~
                    Variable value
]],
  ["nvim_get_var"] = [[nvim_get_var({name}) 
---------
                Gets a global (g:) variable.

                Parameters: ~
                    {name}  Variable name

                Return: ~
                    Variable value]],
  ["nvim_win_get_height"] = [[nvim_win_get_height({window}) 
---------
                Gets the window height

                Parameters: ~
                    {window}  Window handle, or 0 for current window

                Return: ~
                    Height as a count of rows]],
  ["nvim_list_tabpages"] = [[nvim_list_tabpages() 
---------
                Gets the current list of tabpage handles.

                Return: ~
                    List of tabpage handles]],
  ["nvim_get_hl_id_by_name"] = [[nvim_get_hl_id_by_name({name}) 
---------
                Gets a highlight group by name

                similar to |hlID()|, but allocates a new ID if not present.]],
  ["nvim_buf_set_keymap"] = [[nvim_buf_set_keymap({buffer}, {mode}, {lhs}, {rhs}, {opts}) 
---------
                Sets a buffer-local |mapping| for the given mode.

                Parameters: ~
                    {buffer}  Buffer handle, or 0 for current buffer

                See also: ~
                    |nvim_set_keymap()|
]],
  ["nvim__buf_stats"] = [[nvim__buf_stats({buffer}) 
---------
                TODO: Documentation
]],
  ["nvim_win_close"] = [[nvim_win_close({window}, {force}) 
---------
                Closes the window (like |:close| with a |window-ID|).

                Parameters: ~
                    {window}  Window handle, or 0 for current window
                    {force}   Behave like `:close!` The last window of a
                              buffer with unwritten changes can be closed. The
                              buffer will become hidden, even if 'hidden' is
                              not set.]],
  ["nvim_win_set_config"] = [[nvim_win_set_config({window}, {config}) 
---------
                Configures window layout. Currently only for floating and
                external windows (including changing a split window to those
                layouts).

                When reconfiguring a floating window, absent option keys will
                not be changed. `row` / `col` and `relative` must be
                reconfigured together.

                Parameters: ~
                    {window}  Window handle, or 0 for current window
                    {config}  Map defining the window configuration, see
                              |nvim_open_win()|

                See also: ~
                    |nvim_open_win()|]],
  ["nvim_list_runtime_paths"] = [[nvim_list_runtime_paths() 
---------
                Gets the paths contained in 'runtimepath'.

                Return: ~
                    List of paths]],
  ["nvim_win_get_tabpage"] = [[nvim_win_get_tabpage({window}) 
---------
                Gets the window tabpage

                Parameters: ~
                    {window}  Window handle, or 0 for current window

                Return: ~
                    Tabpage that contains the window]],
  ["nvim_buf_get_offset"] = [[nvim_buf_get_offset({buffer}, {index}) 
---------
                Returns the byte offset of a line (0-indexed). |api-indexing|

                Line 1 (index=0) has offset 0. UTF-8 bytes are counted. EOL is
                one byte. 'fileformat' and 'fileencoding' are ignored. The
                line index just after the last line gives the total byte-count
                of the buffer. A final EOL byte is counted if it would be
                written, see 'eol'.

                Unlike |line2byte()|, throws error for out-of-bounds indexing.
                Returns -1 for unloaded buffer.

                Parameters: ~
                    {buffer}  Buffer handle, or 0 for current buffer
                    {index}   Line index

                Return: ~
                    Integer byte offset, or -1 for unloaded buffer.]],
  ["nvim_win_get_position"] = [[nvim_win_get_position({window}) 
---------
                Gets the window position in display cells. First position is
                zero.

                Parameters: ~
                    {window}  Window handle, or 0 for current window

                Return: ~
                    (row, col) tuple with the window position]],
  ["nvim_call_dict_function"] = [[nvim_call_dict_function({dict}, {fn}, {args}) 
---------
                Calls a VimL |Dictionary-function| with the given arguments.

                On execution error: fails with VimL error, does not update
                v:errmsg.

                Parameters: ~
                    {dict}  Dictionary, or String evaluating to a VimL |self|
                            dict
                    {fn}    Name of the function defined on the VimL dict
                    {args}  Function arguments packed in an Array

                Return: ~
                    Result of the function call]],
  ["nvim_buf_set_option"] = [[nvim_buf_set_option({buffer}, {name}, {value}) 
---------
                Sets a buffer option value. Passing 'nil' as value deletes the
                option (only works if there's a global fallback)

                Parameters: ~
                    {buffer}  Buffer handle, or 0 for current buffer
                    {name}    Option name
                    {value}   Option value]],
  ["nvim_out_write"] = [[nvim_out_write({str}) 
---------
                Writes a message to the Vim output buffer. Does not append
                "\n", the message is buffered (won't display) until a linefeed
                is written.

                Parameters: ~
                    {str}  Message
]],
  ["nvim_win_get_option"] = [[nvim_win_get_option({window}, {name}) 
---------
                Gets a window option value

                Parameters: ~
                    {window}  Window handle, or 0 for current window
                    {name}    Option name

                Return: ~
                    Option value]],
  ["nvim_get_current_line"] = [[nvim_get_current_line() 
---------
                Gets the current line.

                Return: ~
                    Current line string]],
  ["nvim_buf_clear_namespace"] = [[nvim_buf_clear_namespace({buffer}, {ns_id}, {line_start}, {line_end}) 
---------
                Clears namespaced objects (highlights, extmarks, virtual text)
                from a region.

                Lines are 0-indexed. |api-indexing| To clear the namespace in
                the entire buffer, specify line_start=0 and line_end=-1.

                Parameters: ~
                    {buffer}      Buffer handle, or 0 for current buffer
                    {ns_id}       Namespace to clear, or -1 to clear all
                                  namespaces.
                    {line_start}  Start of range of lines to clear
                    {line_end}    End of range of lines to clear (exclusive)
                                  or -1 to clear to end of buffer.]],
  ["nvim_win_set_cursor"] = [[nvim_win_set_cursor({window}, {pos}) 
---------
                Sets the (1,0)-indexed cursor position in the window.
                |api-indexing|

                Parameters: ~
                    {window}  Window handle, or 0 for current window
                    {pos}     (row, col) tuple representing the new position]],
  ["nvim_select_popupmenu_item"] = [[nvim_select_popupmenu_item({item}, {insert}, {finish}, {opts}) 
---------
                Selects an item in the completion popupmenu.

                If |ins-completion| is not active this API call is silently
                ignored. Useful for an external UI using |ui-popupmenu| to
                control the popupmenu with the mouse. Can also be used in a
                mapping; use <cmd> |:map-cmd| to ensure the mapping doesn't
                end completion mode.

                Parameters: ~
                    {item}    Index (zero-based) of the item to select. Value
                              of -1 selects nothing and restores the original
                              text.
                    {insert}  Whether the selection should be inserted in the
                              buffer.
                    {finish}  Finish the completion and dismiss the popupmenu.
                              Implies `insert` .
                    {opts}    Optional parameters. Reserved for future use.
]],
  ["nvim_set_var"] = [[nvim_set_var({name}, {value}) 
---------
                Sets a global (g:) variable.

                Parameters: ~
                    {name}   Variable name
                    {value}  Variable value]],
  ["nvim_win_get_buf"] = [[nvim_win_get_buf({window}) 
---------
                Gets the current buffer in a window

                Parameters: ~
                    {window}  Window handle, or 0 for current window

                Return: ~
                    Buffer handle]],
  ["nvim_get_mode"] = [[nvim_get_mode() 
---------
                Gets the current mode. |mode()| "blocking" is true if Nvim is
                waiting for input.

                Return: ~
                    Dictionary { "mode": String, "blocking": Boolean }

                Attributes: ~
                    {fast}]],
  ["nvim_get_current_tabpage"] = [[nvim_get_current_tabpage() 
---------
                Gets the current tabpage.

                Return: ~
                    Tabpage handle]],
  ["nvim_buf_is_loaded"] = [[nvim_buf_is_loaded({buffer}) 
---------
                Checks if a buffer is valid and loaded. See |api-buffer| for
                more info about unloaded buffers.

                Parameters: ~
                    {buffer}  Buffer handle, or 0 for current buffer

                Return: ~
                    true if the buffer is valid and loaded, false otherwise.]],
  ["nvim__id_float"] = [[nvim__id_float({flt}) 
---------
                Returns floating-point value given as argument.

                This API function is used for testing. One should not rely on
                its presence in plugins.

                Parameters: ~
                    {flt}  Value to return.

                Return: ~
                    its argument.]],
  ["nvim_exec"] = [[nvim_exec({src}, {output}) 
---------
                Executes Vimscript (multiline block of Ex-commands), like
                anonymous |:source|.

                Unlike |nvim_command()| this function supports heredocs,
                script-scope (s:), etc.

                On execution error: fails with VimL error, does not update
                v:errmsg.

                Parameters: ~
                    {src}     Vimscript code
                    {output}  Capture and return all (non-error, non-shell
                              |:!|) output

                Return: ~
                    Output (non-error, non-shell |:!|) if `output` is true,
                    else empty string.

                See also: ~
                    |execute()|
                    |nvim_command()|]],
  ["nvim__id_dictionary"] = [[nvim__id_dictionary({dct}) 
---------
                Returns dictionary given as argument.

                This API function is used for testing. One should not rely on
                its presence in plugins.

                Parameters: ~
                    {dct}  Dictionary to return.

                Return: ~
                    its argument.]],
  ["nvim__id_array"] = [[nvim__id_array({arr}) 
---------
                Returns array given as argument.

                This API function is used for testing. One should not rely on
                its presence in plugins.

                Parameters: ~
                    {arr}  Array to return.

                Return: ~
                    its argument.]],
  ["nvim_buf_is_valid"] = [[nvim_buf_is_valid({buffer}) 
---------
                Checks if a buffer is valid.

                Note:
                    Even if a buffer is valid it may have been unloaded. See
                    |api-buffer| for more info about unloaded buffers.

                Parameters: ~
                    {buffer}  Buffer handle, or 0 for current buffer

                Return: ~
                    true if the buffer is valid, false otherwise.]],
  ["nvim_set_option"] = [[nvim_set_option({name}, {value}) 
---------
                Sets an option value.

                Parameters: ~
                    {name}   Option name
                    {value}  New option value]],
  ["nvim_call_function"] = [[nvim_call_function({fn}, {args}) 
---------
                Calls a VimL function with the given arguments.

                On execution error: fails with VimL error, does not update
                v:errmsg.

                Parameters: ~
                    {fn}    Function to call
                    {args}  Function arguments packed in an Array

                Return: ~
                    Result of the function call]],
  ["nvim_get_chan_info"] = [[nvim_get_chan_info({chan}) 
---------
                Get information about a channel.

                Return: ~
                    Dictionary describing a channel, with these keys:
                    • "stream" the stream underlying the channel
                      • "stdio" stdin and stdout of this Nvim instance
                      • "stderr" stderr of this Nvim instance
                      • "socket" TCP/IP socket or named pipe
                      • "job" job with communication over its stdio

                    • "mode" how data received on the channel is interpreted
                      • "bytes" send and receive raw bytes
                      • "terminal" a |terminal| instance interprets ASCII
                        sequences
                      • "rpc" |RPC| communication on the channel is active

                    • "pty" Name of pseudoterminal, if one is used (optional).
                      On a POSIX system, this will be a device path like
                      /dev/pts/1. Even if the name is unknown, the key will
                      still be present to indicate a pty is used. This is
                      currently the case when using winpty on windows.
                    • "buffer" buffer with connected |terminal| instance
                      (optional)
                    • "client" information about the client on the other end
                      of the RPC channel, if it has added it using
                      |nvim_set_client_info()|. (optional)]],
  ["nvim_get_namespaces"] = [[nvim_get_namespaces() 
---------
                Gets existing, non-anonymous namespaces.

                Return: ~
                    dict that maps from names to namespace ids.]],
  ["nvim_buf_attach"] = [[nvim_buf_attach({buffer}, {send_buffer}, {opts}) 
---------
                Activates buffer-update events on a channel, or as Lua
                callbacks.

                Example (Lua): capture buffer updates in a global `events` variable (use "print(vim.inspect(events))" to see its
                contents): >
                  events = {}
                  vim.api.nvim_buf_attach(0, false, {
                    on_lines=function(...) table.insert(events, {...}) end})
<

                Parameters: ~
                    {buffer}       Buffer handle, or 0 for current buffer
                    {send_buffer}  True if the initial notification should
                                   contain the whole buffer: first
                                   notification will be `nvim_buf_lines_event`
                                   . Else the first notification will be
                                   `nvim_buf_changedtick_event` . Not for Lua
                                   callbacks.
                    {opts}         Optional parameters.
                                   • on_lines: Lua callback invoked on change.
                                     Return`true`to detach. Args:
                                     • buffer handle
                                     • b:changedtick
                                     • first line that changed (zero-indexed)
                                     • last line that was changed
                                     • last line in the updated range
                                     • byte count of previous contents
                                     • deleted_codepoints (if `utf_sizes` is
                                       true)
                                     • deleted_codeunits (if `utf_sizes` is
                                       true)

                                   • on_changedtick: Lua callback invoked on
                                     changedtick increment without text
                                     change. Args:
                                     • buffer handle
                                     • b:changedtick

                                   • on_detach: Lua callback invoked on
                                     detach. Args:
                                     • buffer handle

                                   • utf_sizes: include UTF-32 and UTF-16 size
                                     of the replaced region, as args to
                                     `on_lines` .

                Return: ~
                    False if attach failed (invalid parameter, or buffer isn't
                    loaded); otherwise True. TODO: LUA_API_NO_EVAL

                See also: ~
                    |nvim_buf_detach()|
                    |api-buffer-updates-lua|
]],
  ["nvim_buf_add_highlight"] = [[nvim_buf_add_highlight({buffer}, {ns_id}, {hl_group}, {line}, {col_start}, {col_end}) 
---------
                Adds a highlight to buffer.

                Useful for plugins that dynamically generate highlights to a
                buffer (like a semantic highlighter or linter). The function
                adds a single highlight to a buffer. Unlike |matchaddpos()|
                highlights follow changes to line numbering (as lines are
                inserted/removed above the highlighted line), like signs and
                marks do.

                Namespaces are used for batch deletion/updating of a set of
                highlights. To create a namespace, use |nvim_create_namespace|
                which returns a namespace id. Pass it in to this function as
                `ns_id` to add highlights to the namespace. All highlights in
                the same namespace can then be cleared with single call to
                |nvim_buf_clear_namespace|. If the highlight never will be
                deleted by an API call, pass `ns_id = -1` .

                As a shorthand, `ns_id = 0` can be used to create a new
                namespace for the highlight, the allocated id is then
                returned. If `hl_group` is the empty string no highlight is
                added, but a new `ns_id` is still returned. This is supported
                for backwards compatibility, new code should use
                |nvim_create_namespace| to create a new empty namespace.

                Parameters: ~
                    {buffer}     Buffer handle, or 0 for current buffer
                    {ns_id}      namespace to use or -1 for ungrouped
                                 highlight
                    {hl_group}   Name of the highlight group to use
                    {line}       Line to highlight (zero-indexed)
                    {col_start}  Start of (byte-indexed) column range to
                                 highlight
                    {col_end}    End of (byte-indexed) column range to
                                 highlight, or -1 to highlight to end of line

                Return: ~
                    The ns_id that was used]],
  ["nvim_get_proc"] = [[nvim_get_proc({pid}) 
---------
                Gets info describing process `pid` .

                Return: ~
                    Map of process properties, or NIL if process not found.]],
  ["nvim_set_vvar"] = [[nvim_set_vvar({name}, {value}) 
---------
                Sets a v: variable, if it is not readonly.

                Parameters: ~
                    {name}   Variable name
                    {value}  Variable value]],
  ["nvim_get_keymap"] = [[nvim_get_keymap({mode}) 
---------
                Gets a list of global (non-buffer-local) |mapping|
                definitions.

                Parameters: ~
                    {mode}  Mode short-name ("n", "i", "v", ...)

                Return: ~
                    Array of maparg()-like dictionaries describing mappings.
                    The "buffer" key is always zero.]],
  ["nvim__buf_redraw_range"] = [[nvim__buf_redraw_range({buffer}, {first}, {last}) 
---------
                TODO: Documentation]],
  ["nvim_del_var"] = [[nvim_del_var({name}) 
---------
                Removes a global (g:) variable.

                Parameters: ~
                    {name}  Variable name]],
  ["nvim_put"] = [[nvim_put({lines}, {type}, {after}, {follow}) 
---------
                Puts text at cursor, in any mode.

                Compare |:put| and |p| which are always linewise.

                Parameters: ~
                    {lines}   |readfile()|-style list of lines.
                              |channel-lines|
                    {type}    Edit behavior: any |getregtype()| result, or:
                              • "b" |blockwise-visual| mode (may include
                                width, e.g. "b3")
                              • "c" |charwise| mode
                              • "l" |linewise| mode
                              • "" guess by contents, see |setreg()|
                    {after}   Insert after cursor (like |p|), or before (like
                              |P|).
                    {follow}  Place cursor at end of inserted text.
]],
  ["nvim_buf_del_keymap"] = [[nvim_buf_del_keymap({buffer}, {mode}, {lhs}) 
---------
                Unmaps a buffer-local |mapping| for the given mode.

                Parameters: ~
                    {buffer}  Buffer handle, or 0 for current buffer

                See also: ~
                    |nvim_del_keymap()|]],
  ["nvim_buf_del_var"] = [[nvim_buf_del_var({buffer}, {name}) 
---------
                Removes a buffer-scoped (b:) variable

                Parameters: ~
                    {buffer}  Buffer handle, or 0 for current buffer
                    {name}    Variable name]],
  ["nvim__inspect_cell"] = [[nvim__inspect_cell({grid}, {row}, {col}) 
---------
                TODO: Documentation]],
  ["nvim_set_current_win"] = [[nvim_set_current_win({window}) 
---------
                Sets the current window.

                Parameters: ~
                    {window}  Window handle]],
  ["nvim_get_current_win"] = [[nvim_get_current_win() 
---------
                Gets the current window.

                Return: ~
                    Window handle]],
  ["nvim_list_wins"] = [[nvim_list_wins() 
---------
                Gets the current list of window handles.

                Return: ~
                    List of window handles]],
  ["nvim_set_current_buf"] = [[nvim_set_current_buf({buffer}) 
---------
                Sets the current buffer.

                Parameters: ~
                    {buffer}  Buffer handle]],
  ["nvim_get_current_buf"] = [[nvim_get_current_buf() 
---------
                Gets the current buffer.

                Return: ~
                    Buffer handle]],
  ["nvim_err_writeln"] = [[nvim_err_writeln({str}) 
---------
                Writes a message to the Vim error buffer. Appends "\n", so the
                buffer is flushed (and displayed).

                Parameters: ~
                    {str}  Message

                See also: ~
                    nvim_err_write()]],
  ["nvim_tabpage_set_var"] = [[nvim_tabpage_set_var({tabpage}, {name}, {value}) 
---------
                Sets a tab-scoped (t:) variable

                Parameters: ~
                    {tabpage}  Tabpage handle, or 0 for current tabpage
                    {name}     Variable name
                    {value}    Variable value
]],
  ["nvim_buf_get_extmark_by_id"] = [[nvim_buf_get_extmark_by_id({buffer}, {ns_id}, {id}) 
---------
                Returns position for a given extmark id

                Parameters: ~
                    {buffer}  Buffer handle, or 0 for current buffer
                    {ns_id}   Namespace id from |nvim_create_namespace()|
                    {id}      Extmark id

                Return: ~
                    (row, col) tuple or empty list () if extmark id was absent
]],
  ["nvim_get_context"] = [[nvim_get_context({opts}) 
---------
                Gets a map of the current editor state.

                Parameters: ~
                    {opts}  Optional parameters.
                            • types: List of |context-types| ("regs", "jumps",
                              "bufs", "gvars", …) to gather, or empty for
                              "all".

                Return: ~
                    map of global |context|.]],
  ["nvim_del_current_line"] = [[nvim_del_current_line() 
---------
                Deletes the current line.]],
  ["nvim_set_current_line"] = [[nvim_set_current_line({line}) 
---------
                Sets the current line.

                Parameters: ~
                    {line}  Line contents]],
  ["nvim_replace_termcodes"] = [[nvim_replace_termcodes({str}, {from_part}, {do_lt}, {special}) 
---------
                Replaces terminal codes and |keycodes| (<CR>, <Esc>, ...) in a
                string with the internal representation.

                Parameters: ~
                    {str}        String to be converted.
                    {from_part}  Legacy Vim parameter. Usually true.
                    {do_lt}      Also translate <lt>. Ignored if `special` is
                                 false.
                    {special}    Replace |keycodes|, e.g. <CR> becomes a "\n"
                                 char.

                See also: ~
                    replace_termcodes
                    cpoptions
]],
  ["nvim_parse_expression"] = [[nvim_parse_expression({expr}, {flags}, {highlight}) 
---------
                Parse a VimL expression.

                Attributes: ~
                    {fast}

                Parameters: ~
                    {expr}       Expression to parse. Always treated as a
                                 single line.
                    {flags}      Flags:
                                 • "m" if multiple expressions in a row are
                                   allowed (only the first one will be
                                   parsed),
                                 • "E" if EOC tokens are not allowed
                                   (determines whether they will stop parsing
                                   process or be recognized as an
                                   operator/space, though also yielding an
                                   error).
                                 • "l" when needing to start parsing with
                                   lvalues for ":let" or ":for". Common flag
                                   sets:
                                 • "m" to parse like for ":echo".
                                 • "E" to parse like for "<C-r>=".
                                 • empty string for ":call".
                                 • "lm" to parse for ":let".
                    {highlight}  If true, return value will also include
                                 "highlight" key containing array of 4-tuples
                                 (arrays) (Integer, Integer, Integer, String),
                                 where first three numbers define the
                                 highlighted region and represent line,
                                 starting column and ending column (latter
                                 exclusive: one should highlight region
                                 [start_col, end_col)).

                Return: ~

                    • AST: top-level dictionary with these keys:
                      • "error": Dictionary with error, present only if parser
                        saw some error. Contains the following keys:
                        • "message": String, error message in printf format,
                          translated. Must contain exactly one "%.*s".
                        • "arg": String, error message argument.

                      • "len": Amount of bytes successfully parsed. With flags
                        equal to "" that should be equal to the length of expr
                        string. (“Sucessfully parsed” here means “participated
                        in AST creation”, not “till the first error”.)
                      • "ast": AST, either nil or a dictionary with these
                        keys:
                        • "type": node type, one of the value names from
                          ExprASTNodeType stringified without "kExprNode"
                          prefix.
                        • "start": a pair [line, column] describing where node
                          is "started" where "line" is always 0 (will not be 0
                          if you will be using nvim_parse_viml() on e.g.
                          ":let", but that is not present yet). Both elements
                          are Integers.
                        • "len": “length” of the node. This and "start" are
                          there for debugging purposes primary (debugging
                          parser and providing debug information).
                        • "children": a list of nodes described in top/"ast".
                          There always is zero, one or two children, key will
                          not be present if node has no children. Maximum
                          number of children may be found in node_maxchildren
                          array.

                    • Local values (present only for certain nodes):
                      • "scope": a single Integer, specifies scope for
                        "Option" and "PlainIdentifier" nodes. For "Option" it
                        is one of ExprOptScope values, for "PlainIdentifier"
                        it is one of ExprVarScope values.
                      • "ident": identifier (without scope, if any), present
                        for "Option", "PlainIdentifier", "PlainKey" and
                        "Environment" nodes.
                      • "name": Integer, register name (one character) or -1.
                        Only present for "Register" nodes.
                      • "cmp_type": String, comparison type, one of the value
                        names from ExprComparisonType, stringified without
                        "kExprCmp" prefix. Only present for "Comparison"
                        nodes.
                      • "ccs_strategy": String, case comparison strategy, one
                        of the value names from ExprCaseCompareStrategy,
                        stringified without "kCCStrategy" prefix. Only present
                        for "Comparison" nodes.
                      • "augmentation": String, augmentation type for
                        "Assignment" nodes. Is either an empty string, "Add",
                        "Subtract" or "Concat" for "=", "+=", "-=" or ".="
                        respectively.
                      • "invert": Boolean, true if result of comparison needs
                        to be inverted. Only present for "Comparison" nodes.
                      • "ivalue": Integer, integer value for "Integer" nodes.
                      • "fvalue": Float, floating-point value for "Float"
                        nodes.
                      • "svalue": String, value for "SingleQuotedString" and
                        "DoubleQuotedString" nodes.]],
  ["nvim_input"] = [[nvim_input({keys}) 
---------
                Queues raw user-input. Unlike |nvim_feedkeys()|, this uses a
                low-level input buffer and the call is non-blocking (input is
                processed asynchronously by the eventloop).

                On execution error: does not fail, but updates v:errmsg.

                Note:
                    |keycodes| like <CR> are translated, so "<" is special. To
                    input a literal "<", send <LT>.
                Note:
                    For mouse events use |nvim_input_mouse()|. The pseudokey
                    form "<LeftMouse><col,row>" is deprecated since
                    |api-level| 6.

                Attributes: ~
                    {fast}

                Parameters: ~
                    {keys}  to be typed

                Return: ~
                    Number of bytes actually written (can be fewer than
                    requested if the buffer becomes full).
]],
  ["nvim_tabpage_is_valid"] = [[nvim_tabpage_is_valid({tabpage}) 
---------
                Checks if a tabpage is valid

                Parameters: ~
                    {tabpage}  Tabpage handle, or 0 for current tabpage

                Return: ~
                    true if the tabpage is valid, false otherwise]],
  ["nvim_tabpage_del_var"] = [[nvim_tabpage_del_var({tabpage}, {name}) 
---------
                Removes a tab-scoped (t:) variable

                Parameters: ~
                    {tabpage}  Tabpage handle, or 0 for current tabpage
                    {name}     Variable name]],
  ["nvim_set_keymap"] = [[nvim_set_keymap({mode}, {lhs}, {rhs}, {opts}) 
---------
                Sets a global |mapping| for the given mode.

                To set a buffer-local mapping, use |nvim_buf_set_keymap()|.

                Unlike |:map|, leading/trailing whitespace is accepted as part
                of the {lhs} or {rhs}. Empty {rhs} is |<Nop>|. |keycodes| are
                replaced as usual.

                Example: >
                    call nvim_set_keymap('n', ' <NL>', '', {'nowait': v:true})
<

                is equivalent to: >
                    nmap <nowait> <Space><NL> <Nop>
<

                Parameters: ~
                    {mode}  Mode short-name (map command prefix: "n", "i",
                            "v", "x", …) or "!" for |:map!|, or empty string
                            for |:map|.
                    {lhs}   Left-hand-side |{lhs}| of the mapping.
                    {rhs}   Right-hand-side |{rhs}| of the mapping.
                    {opts}  Optional parameters map. Accepts all
                            |:map-arguments| as keys excluding |<buffer>| but
                            including |noremap|. Values are Booleans. Unknown
                            key is an error.]],
  ["nvim_buf_get_commands"] = [[nvim_buf_get_commands({buffer}, {opts}) 
---------
                Gets a map of buffer-local |user-commands|.

                Parameters: ~
                    {buffer}  Buffer handle, or 0 for current buffer
                    {opts}    Optional parameters. Currently not used.

                Return: ~
                    Map of maps describing commands.
]],
}
