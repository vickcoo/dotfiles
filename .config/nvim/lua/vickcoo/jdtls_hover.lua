-- jdtls hover 連結的細節：jdtls 會把 Javadoc 的 {@link} 轉成 markdown 連結
-- [text](jdt://...超長 URL...)，那串 URL 會撐出超長行、在 hover 留下大片空白。
-- 本模組提供給 lsp.lua 的 open_floating_preview 包裝呼叫：
--   M.strip(contents)                 -- 剝掉 jdt:// URL、回傳 (新 contents, 連結表)
--   M.attach(bufnr, lines, links)     -- 渲染後上底線標記、綁 gd 開原始碼
-- 非 jdt:// 的連結/文字一律原樣保留，等於實質只對 Java(jdtls) 生效、不影響其他語言。

local M = {}

local ns = vim.api.nvim_create_namespace("hover_jdt_links")
local LINK_PATTERN = "%[([^%]]-)%]%((.-)%)" -- markdown 連結 [text](url)

-- 連結被改成純文字後會失去 treesitter 的連結配色，這裡自訂 HoverLink：沿用 markdown
-- 連結文字的顏色再補底線。注意群組順序：injected 語言實際生效的是帶後綴的
-- @markup.link.label.markdown_inline（cyberdream 是青色），必須放第一。
local function refresh_hl()
    local fg
    for _, name in ipairs({ "@markup.link.label.markdown_inline", "@markup.link.label", "@markup.link" }) do
        local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
        if hl and (hl.fg or hl.sp) then
            fg = hl.fg
            break
        end
    end
    vim.api.nvim_set_hl(0, "HoverLink", { fg = fg, sp = fg, underline = true })
end
refresh_hl()
vim.api.nvim_create_autocmd("ColorScheme", { callback = refresh_hl })

-- 把一行裡的 [text](jdt://...) 換成純 text，回傳 (新行字串, 該行 jdt:// 連結清單)。
-- 每個連結記其 text 的 byte 範圍 { scol, ecol, url }。非 jdt:// 的比對原樣保留。
local function strip_line(line)
    local out, links, pos, col = {}, {}, 1, 0
    while true do
        local s, e, text, url = line:find(LINK_PATTERN, pos)
        if not s then break end
        local before = line:sub(pos, s - 1)
        out[#out + 1] = before
        col = col + #before
        if url:match("^jdt://") then
            links[#links + 1] = { scol = col, ecol = col + #text, url = url }
            out[#out + 1] = text
            col = col + #text
        else
            local keep = line:sub(s, e)
            out[#out + 1] = keep
            col = col + #keep
        end
        pos = e + 1
    end
    out[#out + 1] = line:sub(pos)
    return table.concat(out), links
end

-- 開啟游標下的連結：關 hover、焦點回主視窗、壓一筆 jumplist(m' 讓 <C-o> 能跳回)、
-- 再開 jdt:// 原始碼（由 nvim-jdtls 的 BufReadCmd 載入並 attach，之後 gd/K 可續跳）。
local function follow_link(links_by_row)
    local cur = vim.api.nvim_win_get_cursor(0)
    local row, ccol = cur[1] - 1, cur[2]
    for _, lk in ipairs(links_by_row[row] or {}) do
        if ccol >= lk.scol and ccol < lk.ecol then
            pcall(vim.api.nvim_win_close, 0, true)
            pcall(vim.cmd, "normal! m'")
            vim.cmd.edit(vim.fn.fnameescape(lk.url))
            return
        end
    end
    vim.notify("游標不在連結上", vim.log.levels.INFO)
end

-- 逐行剝掉 jdt:// URL。回傳 (新 contents, links_by_line)；沒有任何 jdt:// 連結時
-- links_by_line 為 nil，呼叫端就不必做渲染後處理。
function M.strip(contents)
    local stripped, links_by_line = {}, nil
    for i, line in ipairs(contents) do
        local new_line, links = strip_line(line)
        stripped[i] = new_line
        if #links > 0 then
            links_by_line = links_by_line or {}
            links_by_line[i] = links
        end
    end
    return stripped, links_by_line
end

-- 渲染後：對每個連結上底線標記、綁 gd。只在「剝完的行」與「渲染後的行」一致時才標記，
-- 避免 stylize_markdown 改動行內容造成位移錯位。gd closure 捕捉 links_by_row，隨
-- hover buffer/keymap 一起被回收，不需模組層 table 或清理 autocmd。
function M.attach(bufnr, lines, links_by_line)
    local buf_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local links_by_row = {}
    for lnum, links in pairs(links_by_line) do
        if buf_lines[lnum] == lines[lnum] then
            links_by_row[lnum - 1] = links
            for _, lk in ipairs(links) do
                vim.api.nvim_buf_set_extmark(bufnr, ns, lnum - 1, lk.scol, {
                    end_col = lk.ecol,
                    hl_group = "HoverLink",
                })
            end
        end
    end
    if next(links_by_row) then
        vim.keymap.set("n", "gd", function() follow_link(links_by_row) end,
            { buffer = bufnr, silent = true, desc = "hover: 開啟游標下的 jdt:// 連結" })
    end
end

return M
