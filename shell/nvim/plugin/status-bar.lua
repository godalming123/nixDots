-- === STATUS BAR ===
local lsp = require 'feline.providers.lsp'
local vi_mode_utils = require 'feline.providers.vi_mode'

local colors = {
    bg = '#3b4252',
    fg = '#abb2bf',
    yellow = '#ebcb8b',
    green = '#a3be8c',
    orange = '#d08770',
    magenta = '#b48ead',
    blue = '#5e81ac',
    red = '#bf616a',
		cyan = '#8fbcbb',
		lightblue = '#81a1c1',
}

local vi_mode_colors = {
    NORMAL = colors.green,
    INSERT = colors.red,
    VISUAL = colors.magenta,
    OP = colors.green,
    BLOCK = colors.blue,
    REPLACE = colors.lightblue,
    ['V-REPLACE'] = colors.lightblue,
    ENTER = colors.cyan,
    MORE = colors.cyan,
    SELECT = colors.orange,
    COMMAND = colors.green,
    SHELL = colors.green,
    TERM = colors.green,
    NONE = colors.yellow,
}

local icons = {
    errs = '',
    warns = '',
    infos = '',
    hints = '',

    lsp = ' ',
    git = ' '
}

local function vimode_hl()
    return {
        name = vi_mode_utils.get_mode_highlight_name(),
        fg = vi_mode_utils.get_mode_color()
    }
end

local comps = { -- components
    seperator = {
				right = {
				    provider = '  '
				},
				left = {
				    provider = '  '
				},
				rightNoRightSpace = {
				    provider = ' '
				},
				space = {
				    provider = ' '
				}
		},
    vi_mode = {
            provider = '',
            hl = vimode_hl,
            right_sep = ' '
    },
    file = {
        info = {
            provider = 'file_info',
            hl = {
                fg = colors.blue,
                style = 'bold'
            }
        },
        encoding = {
            provider = 'file_encoding',
            left_sep = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold'
            }
        },
				position = {
				   provider = 'position',
				},
        type = {
            provider = 'file_type'
        },
    },
    line_percentage = {
        provider = 'line_percentage',
        hl = {
            style = 'bold'
        }
    },
    scroll_bar = {
        provider = 'scroll_bar',
        hl = {
            fg = colors.blue,
            style = 'bold'
        }
    },
    diagnos = {
        err = {
				    provider = 'diagnostic_errors',
            enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR) end,
            hl = {
                fg = colors.red
            }
        },
        warn = {
            provider = 'diagnostic_warnings',
            enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.WARN) end,
            hl = {
                fg = colors.yellow
            }
        },
        info = {
            provider = 'diagnostic_infos',
            enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.INFO) end,
            hl = {
                fg = colors.blue
            }
        },
        hint = {
            provider = 'diagnostic_hints',
            enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.HINT) end,
            hl = {
                fg = colors.cyan
            }
        },
    },
    lsp = {
        name = {
            provider = 'lsp_client_names',
            icon = icons.lsp,
            hl = {
                fg = colors.yellow
            }
        }
    },
    git = {
        branch = {
            provider = 'git_branch',
            icon = icons.git,
            hl = {
                fg = colors.violet,
                style = 'bold'
            },
        },
        add = {
            provider = 'git_diff_added',
            hl = {
                fg = colors.green
            }
        },
        change = {
            provider = 'git_diff_changed',
            hl = {
                fg = colors.orange
            }
        },
        remove = {
            provider = 'git_diff_removed',
            hl = {
                fg = colors.red
            }
        }
    }
}

local properties = {
    force_inactive = {
        filetypes = {
            'NERD_tree',
            'dbui',
            'packer',
            'startify',
            'fugitive',
            'fugitiveblame'
        },
        buftypes = {'terminal'},
        bufnames = {}
    }
}

local components = {
    active = {
				{
            comps.vi_mode,
            comps.file.info,
       },
				{
	              comps.diagnos.err,
            comps.diagnos.warn,
            comps.diagnos.hint,
            comps.diagnos.info,
						comps.seperator.right,
 							comps.lsp.name,
						comps.seperator.rightNoRightSpace,
								comps.git.add,
								comps.git.change,
				        comps.git.remove,
						comps.seperator.right,
								comps.git.branch,
						comps.seperator.right,
								comps.file.position,
								comps.seperator.space,
      },
    },
		inactive = {
		}
}

-- LuaFormatter on

require'feline'.setup {
		theme = colors,
    components = components,
    properties = properties,
    vi_mode_colors = vi_mode_colors
}

