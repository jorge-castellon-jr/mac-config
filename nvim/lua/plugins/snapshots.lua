-- https://github.com/mistricky/codesnap.nvim
return {
  "mistricky/codesnap.nvim",
  build = "make",
  event = "VeryLazy",
  opts = {
    save_path = "~/Desktop/CodeScreenshots",
    has_breadcrumbs = true,
    has_line_number = true,
    show_workspace = true,
    bg_theme = "grape",
    bg_padding = 30,
    watermark = "",
  },
}
