return {
    {
        "goolord/alpha-nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")
            local v = vim.version()
            local datetime = os.date(" %a %d-%m-%Y   %H:%M:%S")
            local platform = vim.fn.has("win32") == 1 and "" or ""
            local header_info = string.format("🚀 %s %d.%d.%d  %s", platform, v.major, v.minor, v.patch, datetime)

            dashboard.section.header.val = {
                [[                                                   ]],
                [[                                              ___  ]],
                [[                                           ,o88888 ]],
                [[                                        ,o8888888' ]],
                [[                  ,:o:o:oooo.        ,8O88Pd8888"  ]],
                [[              ,.::.::o:ooooOoOoO. ,oO8O8Pd888'"    ]],
                [[            ,.:.::o:ooOoOoOO8O8OOo.8OOPd8O8O"      ]],
                [[           , ..:.::o:ooOoOOOO8OOOOo.FdO8O8"        ]],
                [[          , ..:.::o:ooOoOO8O888O8O,COCOO"          ]],
                [[         , . ..:.::o:ooOoOOOO8OOOOCOCO"            ]],
                [[          . ..:.::o:ooOoOoOO8O8OCCCC"o             ]],
                [[             . ..:.::o:ooooOoCoCCC"o:o             ]],
                [[             . ..:.::o:o:,cooooCo"oo:o:            ]],
                [[          `   . . ..:.:cocoooo"'o:o:::'            ]],
                [[          .`   . ..::ccccoc"'o:o:o:::'             ]],
                [[         :.:.    ,c:cccc"':.:.:.:.:.'              ]],
                [[       ..:.:"'`::::c:"'..:.:.:.:.:.'               ]],
                [[     ...:.'.:.::::"'    . . . . .'                 ]],
                [[    .. . ....:."' `   .  . . ''                    ]],
                [[  . . . ...."'                                     ]],
                [[  .. . ."'                                         ]],
                [[ .                                                 ]],
                [[                                                   ]],
                [[        ]] .. header_info .. [[         ]],
            }

            dashboard.section.buttons.val = {
                dashboard.button("e", "📝 > New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("f", "🧭 > Find file", ":Telescope find_files <CR>"),
                dashboard.button("r", "⏰ > Recent", ":Telescope oldfiles <CR>"),
                dashboard.button("t", "🔎 > Find text", ":Telescope live_grep <CR>"),
                dashboard.button("c", "💡 > Configuration", ":e ~/.config/nvim/lua/config/init.lua<CR>"),
                dashboard.button("q", "🛟 > Quit Neovim", ":qa<CR>"),
            }

            dashboard.section.footer.val =
                "The computing scientist’s main challenge is not to get confused by the complexities of his own making.\n- Edsger W. Dijkstra"

            dashboard.section.footer.opts.hl = "Type"
            dashboard.section.header.opts.hl = "Include"
            dashboard.section.buttons.opts.hl = "Keyword"

            dashboard.opts.opts.noautocmd = true
            alpha.setup(dashboard.opts)
        end,
    },
}
