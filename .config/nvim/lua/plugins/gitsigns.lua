return {
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            -- 這裡放入你想要套用的 on_attach 函式
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation (導覽：跳轉上下個修改處)
                map("n", "]c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gitsigns.nav_hunk("next")
                    end
                end, { desc = "Next Hunk" })

                map("n", "[c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gitsigns.nav_hunk("prev")
                    end
                end, { desc = "Prev Hunk" })

                -- Actions (操作：暫存、還原、預覽)
                map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage Hunk" })
                map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset Hunk" })

                map("v", "<leader>hs", function()
                    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { desc = "Stage Selected Hunk" })

                map("v", "<leader>hr", function()
                    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { desc = "Reset Selected Hunk" })

                map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage Buffer" })
                map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset Buffer" })
                map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview Hunk" })
                map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview Hunk Inline" })

                map("n", "<leader>hb", function()
                    gitsigns.blame_line({ full = true })
                end, { desc = "Blame Line Full" })

                map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff This" })

                map("n", "<leader>hD", function()
                    gitsigns.diffthis("~")
                end, { desc = "Diff Against Last Commit" })

                map("n", "<leader>hQ", function() gitsigns.setqflist("all") end, { desc = "Set Quickfix All" })
                map("n", "<leader>hq", gitsigns.setqflist, { desc = "Set Quickfix" })

                -- Toggles (切換功能開關)
                map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle Blame Line" })
                map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle Word Diff" })

                -- Text object (文字物件：可以用 cih, dih 來操作整個修改區塊)
                map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select Hunk" })
            end,
        },
    },
}
