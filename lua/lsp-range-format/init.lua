local api = vim.api
local M = {}
local util = require('vim.lsp.util')
local validate = vim.validate

local function select_client(method, on_choice)
    validate({
        on_choice = { on_choice, 'function', false },
    })
    local clients = vim.tbl_values(vim.lsp.buf_get_clients())
    clients = vim.tbl_filter(function(client)
        return client.supports_method(method)
    end, clients)
    -- better UX when choices are always in the same order (between restarts)
    table.sort(clients, function(a, b)
        return a.name < b.name
    end)

    print(vim.inspect(#clients))
    if #clients > 1 then
        vim.ui.select(clients, {
            prompt = 'Select a language server:',
            format_item = function(client)
                return client.name
            end,
        }, on_choice)
    elseif #clients < 1 then
        on_choice(nil)
    else
        on_choice(clients[1])
    end
end

function M.format()
    local options = {}
    local buf = api.nvim_get_current_buf()
    local params = util.make_given_range_params()
    params.options = util.make_formatting_params(options).options


    select_client('textDocument/rangeFormatting', function(client)
        if not client then
            return
        end
        local timeout_ms = options.timeout_ms or 1000
        local result, err = client.request_sync('textDocument/rangeFormatting', params, timeout_ms, buf)
        if result and result.result then
            util.apply_text_edits(result.result, buf, client.offset_encoding)
        else
            vim.notify('Please check your lsp server. Might not support range Formatting')
        end
    end)
end

return M
