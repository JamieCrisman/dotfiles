return {
    "folke/twilight.nvim",
    config = function()
        require("twilight").setup {
            dimming = {
                alpha = 0.5,
            },
            context = 15,
        }
    end
}
