{...}: {
  vim = {
    visuals = {
      nvim-scrollbar.enable = true; # Shows a scrollbar in the editor
      nvim-web-devicons.enable = true; # Adds file type icons to various UI elements
      nvim-cursorline.enable = true; # Highlights the current cursor line
      cinnamon-nvim.enable = true; # Provides smooth scrolling animations
      fidget-nvim.enable = true; # Shows LSP progress notifications in the corner
      highlight-undo.enable = true; # Highlights text changes after undo/redo operations
      indent-blankline.enable = true; # Shows indentation guides and blank line markers
    };
    treesitter.context.enable = true; # keep the current function/class header visible at the top as you scroll

    ui = {
      borders.enable = true;
      noice.enable = true;
      colorizer.enable = true;
      modes-nvim.enable = true;
      illuminate.enable = true;
      breadcrumbs = {
        enable = true;
        navbuddy.enable = true;
      };
      smartcolumn = {
        enable = true;
        setupOpts.custom_colorcolumn = {
          # this is a freeform module, it's `buftype = int;` for configuring column position
          nix = "110";
          java = "130";
          kotlin = "130";
        };
      };
      fastaction.enable = true;
    };
  };
}
