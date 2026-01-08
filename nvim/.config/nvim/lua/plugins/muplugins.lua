return { 
	{ "EdenEast/nightfox.nvim"},
	{ "neovim/nvim-lspconfig" },
	{ "folke/todo-comments.nvim", opts = {} }, 
	{
    		"mason-org/mason.nvim",
    		opts = {}
	},
	{
    		"mason-org/mason-lspconfig.nvim",
    		opts = {},
    		dependencies = {
        		{ "mason-org/mason.nvim", opts = {} },
        		"neovim/nvim-lspconfig",
    		},
	}	
}
