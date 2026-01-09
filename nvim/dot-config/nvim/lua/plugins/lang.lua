return {
	-- MASON AND LSPCONFIG
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
				-- "vim_ls",
				"rust_analyzer",
				"gopls",
				"marksman",
			},
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				opts = {
					ensure_installed = {
						"luacheck",
						"black",
						"stylua",
						-- "rustfmt", --- this is simply a note now, since rustfmt is deprecated in mason, and is now installed with rustup
					},
				},
			},
			"neovim/nvim-lspconfig",
		},
	},
	-- LINTER
	{
		"mfussenegger/nvim-lint",
		opts = {
			-- Event to trigger linters
			events = { "BufWritePost", "BufReadPost", "InsertLeave" },
			linters_by_ft = {
				lua = { "luacheck" },
			},
		},
		config = function(_, opts)
			local lint = require("lint")

			-- tbh i don't understand anything after this
			lint.linters_by_ft = opts.linters_by_ft

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
	-- FORMATTER
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				rust = { "rustfmt", lsp_format = "fallback" },
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
		-- vim.keymap.set({ "n", "v" }, "<leader>mp", function()
		--	conform.format({
		--		lsp_fallback = true,
		--		async = false,
		--		timeout_ms = 500,
		--	})
		-- end, { desc = "Format file or range (in visual mode)" }),
	},
}
