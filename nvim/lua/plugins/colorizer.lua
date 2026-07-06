return {

  {

    "catgoose/nvim-colorizer.lua",

    event = "BufReadPre",

    opts = {

      user_default_options = {

        RGB = true,

        RRGGBB = true,

        names = false,

        RRGGBBAA = true,

        AARRGGBB = true,

        rgb_fn = true,

        hsl_fn = true,

        css = true,

        css_fn = true,

        tailwind = true,

        mode = "virtualtext",
      },
    },
  },
}
