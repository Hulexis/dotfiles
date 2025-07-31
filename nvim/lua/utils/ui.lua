local M = {}

local state = require("telescope.state")

---@diagnostic disable-next-line: unused-local
M.save_picker_state = function(prompt_bufnr)
	local picker = state.get_global_key("ui_picker")
	if picker ~= nil then
		local data = {
			filter_text = "",
			picker_state = {},
		}
		data.picker_state = { selected_item = vim.fn.getpos(".") }
		local action_state = require("telescope.actions.state")
		local text = action_state.get_current_line()
		data.filter_text = text
		state.set_global_key("ui_data." .. picker, data)
		state.set_global_key("ui_picker", nil)
	end
end

M.load_picker_state = function(picker)
	return state.get_global_key("ui_data." .. picker)
end

M.load_picker_state_prompt = function(picker)
	local restored_filter_text = ""
	local data = M.load_picker_state(picker)
	if data ~= nil then
		restored_filter_text = data.filter_text
	end
	return restored_filter_text
end

M.open_picker = function(picker)
	state.set_global_key("ui_picker", picker)
	return M.load_picker_state_prompt(picker)
end

M.close_picker = function(prompt_bufnr)
	M.save_picker_state(prompt_bufnr)
	require("telescope.actions").close(prompt_bufnr)
end

M.open_diagnostics = function()
	require("telescope.builtin").diagnostics({})
end

M.search_all_files = function()
	require("telescope.builtin").live_grep({})
end

M.search_current_file = function()
	require("telescope.builtin").current_buffer_fuzzy_find({})
end

M.show_code_info = function()
	require("hover").hover({ providers = { "LSP" } })
end

M.show_code_options = function()
	require("hover").hover({})
end

M.dashboard_name = function()
	local raw = vim.loop.os_gethostname()
	local hostname = raw:gsub("%..*$", ""):lower() -- strip .local, .lan, etc.

	vim.notify("Snacks: hostname = " .. raw .. " -> " .. hostname, vim.log.levels.INFO)

	local function is(name)
		return hostname:match("^" .. name)
	end

	if is("hoth") then
		return [[
██╗  ██╗ ██████╗ ████████╗██╗  ██╗
██║  ██║██╔═══██╗╚══██╔══╝██║  ██║
███████║██║   ██║   ██║   ███████║
██╔══██║██║   ██║   ██║   ██╔══██║
██║  ██║╚██████╔╝   ██║   ██║  ██║
╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝
]]
	elseif is("mustafar") then
		return [[
███╗   ███╗██╗   ██╗███████╗████████╗ █████╗ ███████╗ █████╗ ██████╗
████╗ ████║██║   ██║██╔════╝╚══██╔══╝██╔══██╗██╔════╝██╔══██╗██╔══██╗
██╔████╔██║██║   ██║███████╗   ██║   ███████║█████╗  ███████║██████╔╝
██║╚██╔╝██║██║   ██║╚════██║   ██║   ██╔══██║██╔══╝  ██╔══██║██╔══██╗
██║ ╚═╝ ██║╚██████╔╝███████║   ██║   ██║  ██║██║     ██║  ██║██║  ██║
╚═╝     ╚═╝ ╚═════╝ ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝
]]
	elseif is("alderaan") then
		return [[
 █████╗ ██╗     ██████╗ ███████╗██████╗  █████╗  █████╗ ███╗   ██╗
██╔══██╗██║     ██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔══██╗████╗  ██║
███████║██║     ██║  ██║█████╗  ██████╔╝███████║███████║██╔██╗ ██║
██╔══██║██║     ██║  ██║██╔══╝  ██╔══██╗██╔══██║██╔══██║██║╚██╗██║
██║  ██║███████╗██████╔╝███████╗██║  ██║██║  ██║██║  ██║██║ ╚████║
╚═╝  ╚═╝╚══════╝╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝
]]
	else
		return [[
██╗  ██╗██╗   ██╗██╗     ███████╗██╗  ██╗██╗███████╗
██║  ██║██║   ██║██║     ██╔════╝╚██╗██╔╝██║██╔════╝
███████║██║   ██║██║     █████╗   ╚███╔╝ ██║███████╗
██╔══██║██║   ██║██║     ██╔══╝   ██╔██╗ ██║╚════██║
██║  ██║╚██████╔╝███████╗███████╗██╔╝ ██╗██║███████║
╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝╚══════╝
]]
	end
end

return M
