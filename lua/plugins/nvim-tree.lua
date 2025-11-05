return {
    "nvim-tree/nvim-tree.lua",
    enabled = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    config = function()
        local nvimtree = require("nvim-tree")
        local webDevIcons = require("nvim-web-devicons")

        -- recommended settings from nvim-tree documentation
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- change color for arrows in tree to light blue
        -- vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

        webDevIcons.setup({
            override_by_filename = {
                [".gitignore"] = {
                    icon = "",
                    color = "#f1502f",
                    name = "Gitignore"
                }
            },
        })

        -- configure nvim-tree
        nvimtree.setup({
            open_on_tab = true,
            notify = {
                threshold = vim.log.levels.WARN,
            },
            view = {
                width = 40,
                relativenumber = true,
            },
            -- change folder arrow icons
            renderer = {
                indent_markers = {
                    enable = false,
                },
                icons = {
                    glyphs = {
                        git = {
                            unstaged  = "M",
                            staged    = "",
                            unmerged  = "",
                            renamed   = "󰛂",
                            untracked = "?",
                            deleted   = "",
                            ignored   = "◌",
                        }
                    }
                }
            },
            -- disable window_picker for
            -- explorer to work well with
            -- window splits
            actions = {
                open_file = {
                    quit_on_open = true,
                    window_picker = {
                        enable = false,
                    },
                },
            },
            filters = {
                custom = { ".DS_Store" },
            },
            git = {
                ignore = false,
            },
            update_focused_file = {
                enable = true,
                update_root = false,
            },
        })

        -- set keymaps
        local keymap = vim.keymap

        keymap.set("n", "<leader>n", "<cmd>NvimTreeToggle<CR>", { desc = "neo-tree: toggle file explorer" })
    end,
}
