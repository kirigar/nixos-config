{ inputs, config, ... }:
let
  inherit (inputs.nixCats) utils;
  luaPath = ./.;
  categoryDefinitions =
    { pkgs, ... }:
    {
      # to define and use a new category, simply add a new list to a set here,
      # and later, you will include categoryname = true; in the set you
      # provide when you build the package using this builder function.
      # see :help nixCats.flake.outputs.packageDefinitions for info on that section.

      # lspsAndRuntimeDeps:
      # this section is for dependencies that should be available
      # at RUN TIME for plugins. Will be available to PATH within neovim terminal
      # this includes LSPs
      lspsAndRuntimeDeps = {
        general = with pkgs; [
          universal-ctags
          stdenv.cc.cc
          ripgrep
          fd

          stylua
          lua-language-server

          nixd
          nix-doc
          nixfmt

          dafny

          typescript
          typescript-language-server

          rust-analyzer
          rustfmt

          markdownlint-cli2

          basedpyright
          black
          isort
        ];
      };

      startupPlugins = {
        general = with pkgs.vimPlugins; [
          lz-n
          plenary-nvim
          catppuccin-nvim
        ];
      };

      optionalPlugins = {
        general = with pkgs.vimPlugins; [
          nvim-treesitter.withAllGrammars
          nvim-treesitter-textobjects
          nvim-treesitter-context
          trouble-nvim

          guess-indent-nvim
          gitsigns-nvim
          which-key-nvim

          telescope-nvim
          telescope-fzf-native-nvim
          telescope-ui-select-nvim

          conform-nvim
          blink-cmp
          luasnip
          friendly-snippets

          todo-comments-nvim
          mini-nvim

          nvim-lspconfig
          lazydev-nvim
          nvim-autopairs
          indent-blankline-nvim
          nvim-lint

          render-markdown-nvim

          colorful-menu-nvim
        ];
      };

      sharedLibraries = {
        general = with pkgs; [ ];
      };

      environmentVariables = { };
      extraWrapperArgs = { };
      python3.libraries = {
        test = (_: [ ]);
      };
      extraLuaPackages = {
        general = [ (_: [ ]) ];
      };
      extraCats = { };
    };

  packageDefinitions = {
    nixCats =
      { pkgs, ... }:
      {
        settings = {
          suffix-path = true;
          suffix-LD = true;
          aliases = [
            "nvim"
            "vim"
            "vi"
          ];
          wrapRc = true;
          configDirName = "nixCats";
          hosts.python3.enable = true;
          hosts.node.enable = true;
        };

        categories = {
          general = true;
        };

        extra = {
          nixdExtras = {
            nixpkgs = ''import ${pkgs.path} {}'';
            nixos_options = ''(builtins.getFlake "path:///home/kiri/.config/nixos").nixosConfigurations.${toString config.var.hostname}.options'';
            home_manager_options = ''(builtins.getFlake "path:///home/kiri/.config/nixos").nixosConfigurations.${toString config.var.hostname}.options.home-manager.users.type.getSubOptions []'';
          };
        };
      };

  };

  defaultPackageName = "nixCats";
in
{
  imports = [
    (utils.mkHomeModules {
      inherit
        defaultPackageName
        luaPath
        categoryDefinitions
        packageDefinitions
        ;
      inherit (inputs) nixpkgs;
      dependencyOverlays = [ (utils.standardPluginOverlay inputs) ];
    })
  ];

  nixCats.enable = true;
}
