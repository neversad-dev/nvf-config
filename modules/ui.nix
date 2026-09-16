{...}: {
  vim = {
    visuals = {
      nvim-scrollbar.enable = false; # Shows a scrollbar in the editor
      nvim-web-devicons.enable = true; # Adds file type icons to various UI elements
      # Provides smooth scrolling animations
      cinnamon-nvim = {
        enable = true;

        setupOpts = {
          keymaps = {
            basic = true;
            # extra = true;
          };
        };
      };
      highlight-undo.enable = true; # Highlights text changes after undo/redo operations
      indent-blankline.enable = true; # Shows indentation guides and blank line markers
    };

    options = {
      cursorline = true;
    };
    treesitter.context.enable = true; # keep the current function/class header visible at the top as you scroll

    ui = {
      borders.enable = true;
      noice = {
        enable = true;
      
        setupOpts.presets = {
          command_palette = true;
          long_message_to_split = true;
          cmdline_output_to_split = true;
        };
      };
      # noice.enable = true;
      colorizer.enable = true;
      modes-nvim.enable = false;
      illuminate.enable = true;
      breadcrumbs = {
        enable = true;
        navbuddy.enable = false;
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
