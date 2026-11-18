local M = {}

function M.delete_hidden_buffers()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[buf].buflisted and not vim.bo[buf].modified and #vim.fn.win_findbuf(buf) == 0 then
			vim.api.nvim_buf_delete(buf, {})
		end
	end
end

function M.yank_relative_path_with_line()
	local path = vim.fn.expand("%:.") .. "#L" .. vim.fn.line(".")
	vim.fn.setreg("+", path)
	vim.notify("Copied: " .. path, vim.log.levels.INFO)
end

function M.yank_absolute_path_with_line()
	local path = vim.fn.expand("%:p") .. "#L" .. vim.fn.line(".")
	vim.fn.setreg("+", path)
	vim.notify("Copied: " .. path, vim.log.levels.INFO)
end

function M.copy_as_codeblock()
	local start_line = vim.fn.line("'<")
	local end_line = vim.fn.line("'>")
	local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
	local filepath = vim.api.nvim_buf_get_name(0)
	if filepath == "" then
		vim.notify("Buffer has no file name", vim.log.levels.WARN)
		return
	end

	local lang = vim.bo.filetype
	if lang == "sh" then
		lang = "bash"
	elseif lang == "dockerfile" then
		lang = "docker"
	end

	local result = {
		"```" .. lang .. ' filename="' .. vim.fn.expand("%:.") .. '" line=' .. start_line,
	}
	vim.list_extend(result, lines)
	table.insert(result, "```")

	vim.fn.setreg("+", table.concat(result, "\n"))
	vim.notify("Copied " .. #lines .. " lines as code block", vim.log.levels.INFO)
end

return M
