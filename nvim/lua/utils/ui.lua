local M = {}

local state = require("telescope.state")

M.get_last_picker = function()
	return state.get_global_key("ui_last_picker")
end

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
		data.filter_text = action_state.get_current_line()

		state.set_global_key("ui_data." .. picker, data)
		state.set_global_key("ui_last_picker", picker) -- NEW: track last
		state.set_global_key("ui_picker", nil)
	end
end

M.run_picker_with_cache = function(picker_name, builtin_name, opts, use_cache)
	opts = opts or {}
	local builtin = require("telescope.builtin")

	-- default to using cache unless explicitly false
	if use_cache ~= false then
		local default_text = M.load_picker_state_prompt(picker_name)
		if (not opts.default_text or opts.default_text == "") and default_text ~= "" then
			opts.default_text = default_text
		end
	end

	-- mark which picker is opening (so save_* knows where to store)
	state.set_global_key("ui_picker", picker_name)

	local user_attach = opts.attach_mappings
	opts.attach_mappings = function(prompt_bufnr, map)
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")

		local function save_query()
			local p = state.get_global_key("ui_picker")
			if p then
				state.set_global_key("ui_data." .. p, {
					filter_text = action_state.get_current_line(),
					picker_state = { selected_item = vim.fn.getpos(".") },
				})
				state.set_global_key("ui_last_picker", p)
				state.set_global_key("ui_picker", nil)
			end
		end

		local function save_then(f)
			return function(...)
				save_query()
				return f(...)
			end
		end

		map("i", "<CR>", save_then(actions.select_default))
		map("n", "<CR>", save_then(actions.select_default))
		map("i", "<Esc>", save_then(actions.close))
		map("n", "q", save_then(actions.close))
		map("i", "<C-c>", save_then(actions.close))

		if user_attach then
			user_attach(prompt_bufnr, map)
		end
		return true
	end

	builtin[builtin_name](opts)
end

M.run_picker_fresh = function(picker_name, builtin_name, opts)
	return M.run_picker_with_cache(picker_name, builtin_name, opts, false)
end

M.repeat_last_picker = function(extra_opts)
	local last = M.get_last_picker()
	if not last then
		vim.notify("No previous Telescope picker", vim.log.levels.WARN)
		return
	end
	M.run_picker_with_cache(last, last, extra_opts or {})
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

	local function is(name)
		return hostname:match("^" .. name)
	end

	if is("hoth") then
		return [[
⠀⠀⠀⠀⠀⠀⣀⣠⣤⡔⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡴⣧
⠀⠀⣀⣤⣶⣿⣿⣿⣿⣏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡾⠁⣼
⢠⣾⣿⣿⣿⣿⣿⣿⣿⣿⢷⣆⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⡟⠀⠀⣿
⣾⣿⣿⣟⢛⣛⣛⣛⣋⠭⠥⠿⣿⣿⣷⣤⠀⠀⠀⢀⣀⣀⣠⣀⡀⢿⡇⠀⣸⡇
⣿⣿⣿⠻⢧⠙⢯⡀⠈⠉⠙⠛⠳⢦⣝⢿⣷⢠⣾⣿⣿⣿⣿⣿⣯⣬⡥⢰⡟⠀
⢹⣯⣛⠯⢿⣾⣷⣍⡳⣤⣀⠀⠀⠀⠉⠳⣍⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡃⠀⠀
⠈⠹⣿⣿⣾⣿⣿⣿⣿⣷⣭⣛⠷⢦⣤⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀
⠀⠀⠈⠛⠿⣿⣿⣿⣿⣿⢋⣵⡾⣣⣤⣦⢻⣿⣿⣿⣻⠻⣿⣿⣿⡏⠖⢻⠀⠀
⠀⠀⠀⠀⠀⠀⠈⠉⠉⣱⣿⡟⠼⣻⣿⣿⢸⣿⣿⡇⡛⠀⣿⣿⣿⣧⡠⣸⡇⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣷⢹⣿⣿⣿⣏⢿⣿⣷⣕⣧⣿⣿⣿⢿⣿⡿⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣠⢿⣿⡟⣿⣷⣭⣻⠿⢿⠿⠷⢞⣫⣵⠿⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⡟⣎⢿⣧⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀
██╗  ██╗ ██████╗ ████████╗██╗  ██╗
██║  ██║██╔═══██╗╚══██╔══╝██║  ██║
███████║██║   ██║   ██║   ███████║
██╔══██║██║   ██║   ██║   ██╔══██║
██║  ██║╚██████╔╝   ██║   ██║  ██║
╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝
]]
	elseif is("mustafar") then
		return [[
⠀⠀⠀⠀⠀⠀⣀⣠⣤⡔⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡴⣧
⠀⠀⣀⣤⣶⣿⣿⣿⣿⣏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡾⠁⣼
⢠⣾⣿⣿⣿⣿⣿⣿⣿⣿⢷⣆⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⡟⠀⠀⣿
⣾⣿⣿⣟⢛⣛⣛⣛⣋⠭⠥⠿⣿⣿⣷⣤⠀⠀⠀⢀⣀⣀⣠⣀⡀⢿⡇⠀⣸⡇
⣿⣿⣿⠻⢧⠙⢯⡀⠈⠉⠙⠛⠳⢦⣝⢿⣷⢠⣾⣿⣿⣿⣿⣿⣯⣬⡥⢰⡟⠀
⢹⣯⣛⠯⢿⣾⣷⣍⡳⣤⣀⠀⠀⠀⠉⠳⣍⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡃⠀⠀
⠈⠹⣿⣿⣾⣿⣿⣿⣿⣷⣭⣛⠷⢦⣤⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀
⠀⠀⠈⠛⠿⣿⣿⣿⣿⣿⢋⣵⡾⣣⣤⣦⢻⣿⣿⣿⣻⠻⣿⣿⣿⡏⠖⢻⠀⠀
⠀⠀⠀⠀⠀⠀⠈⠉⠉⣱⣿⡟⠼⣻⣿⣿⢸⣿⣿⡇⡛⠀⣿⣿⣿⣧⡠⣸⡇⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣷⢹⣿⣿⣿⣏⢿⣿⣷⣕⣧⣿⣿⣿⢿⣿⡿⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣠⢿⣿⡟⣿⣷⣭⣻⠿⢿⠿⠷⢞⣫⣵⠿⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⡟⣎⢿⣧⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀
███╗   ███╗██╗   ██╗███████╗████████╗ █████╗ ███████╗ █████╗ ██████╗
████╗ ████║██║   ██║██╔════╝╚══██╔══╝██╔══██╗██╔════╝██╔══██╗██╔══██╗
██╔████╔██║██║   ██║███████╗   ██║   ███████║█████╗  ███████║██████╔╝
██║╚██╔╝██║██║   ██║╚════██║   ██║   ██╔══██║██╔══╝  ██╔══██║██╔══██╗
██║ ╚═╝ ██║╚██████╔╝███████║   ██║   ██║  ██║██║     ██║  ██║██║  ██║
╚═╝     ╚═╝ ╚═════╝ ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝
]]
	elseif is("alderaan") then
		return [[
⠀⠀⠀⠀⠀⠀⣀⣠⣤⡔⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡴⣧
⠀⠀⣀⣤⣶⣿⣿⣿⣿⣏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡾⠁⣼
⢠⣾⣿⣿⣿⣿⣿⣿⣿⣿⢷⣆⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⡟⠀⠀⣿
⣾⣿⣿⣟⢛⣛⣛⣛⣋⠭⠥⠿⣿⣿⣷⣤⠀⠀⠀⢀⣀⣀⣠⣀⡀⢿⡇⠀⣸⡇
⣿⣿⣿⠻⢧⠙⢯⡀⠈⠉⠙⠛⠳⢦⣝⢿⣷⢠⣾⣿⣿⣿⣿⣿⣯⣬⡥⢰⡟⠀
⢹⣯⣛⠯⢿⣾⣷⣍⡳⣤⣀⠀⠀⠀⠉⠳⣍⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡃⠀⠀
⠈⠹⣿⣿⣾⣿⣿⣿⣿⣷⣭⣛⠷⢦⣤⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀
⠀⠀⠈⠛⠿⣿⣿⣿⣿⣿⢋⣵⡾⣣⣤⣦⢻⣿⣿⣿⣻⠻⣿⣿⣿⡏⠖⢻⠀⠀
⠀⠀⠀⠀⠀⠀⠈⠉⠉⣱⣿⡟⠼⣻⣿⣿⢸⣿⣿⡇⡛⠀⣿⣿⣿⣧⡠⣸⡇⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣷⢹⣿⣿⣿⣏⢿⣿⣷⣕⣧⣿⣿⣿⢿⣿⡿⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣠⢿⣿⡟⣿⣷⣭⣻⠿⢿⠿⠷⢞⣫⣵⠿⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⡟⣎⢿⣧⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀
 █████╗ ██╗     ██████╗ ███████╗██████╗  █████╗  █████╗ ███╗   ██╗
██╔══██╗██║     ██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔══██╗████╗  ██║
███████║██║     ██║  ██║█████╗  ██████╔╝███████║███████║██╔██╗ ██║
██╔══██║██║     ██║  ██║██╔══╝  ██╔══██╗██╔══██║██╔══██║██║╚██╗██║
██║  ██║███████╗██████╔╝███████╗██║  ██║██║  ██║██║  ██║██║ ╚████║
╚═╝  ╚═╝╚══════╝╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝
]]
	else
		return [[
⠀⠀⠀⠀⠀⠀⣀⣠⣤⡔⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡴⣧
⠀⠀⣀⣤⣶⣿⣿⣿⣿⣏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡾⠁⣼
⢠⣾⣿⣿⣿⣿⣿⣿⣿⣿⢷⣆⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⡟⠀⠀⣿
⣾⣿⣿⣟⢛⣛⣛⣛⣋⠭⠥⠿⣿⣿⣷⣤⠀⠀⠀⢀⣀⣀⣠⣀⡀⢿⡇⠀⣸⡇
⣿⣿⣿⠻⢧⠙⢯⡀⠈⠉⠙⠛⠳⢦⣝⢿⣷⢠⣾⣿⣿⣿⣿⣿⣯⣬⡥⢰⡟⠀
⢹⣯⣛⠯⢿⣾⣷⣍⡳⣤⣀⠀⠀⠀⠉⠳⣍⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡃⠀⠀
⠈⠹⣿⣿⣾⣿⣿⣿⣿⣷⣭⣛⠷⢦⣤⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀
⠀⠀⠈⠛⠿⣿⣿⣿⣿⣿⢋⣵⡾⣣⣤⣦⢻⣿⣿⣿⣻⠻⣿⣿⣿⡏⠖⢻⠀⠀
⠀⠀⠀⠀⠀⠀⠈⠉⠉⣱⣿⡟⠼⣻⣿⣿⢸⣿⣿⡇⡛⠀⣿⣿⣿⣧⡠⣸⡇⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣷⢹⣿⣿⣿⣏⢿⣿⣷⣕⣧⣿⣿⣿⢿⣿⡿⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣠⢿⣿⡟⣿⣷⣭⣻⠿⢿⠿⠷⢞⣫⣵⠿⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⡟⣎⢿⣧⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀
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
