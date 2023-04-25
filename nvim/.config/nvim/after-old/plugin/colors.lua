function ApplyColors(color)
	color = color or "kanagawa"
	vim.cmd.colorscheme(color)
end

ApplyColors()
