return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "mason-org/mason.nvim",
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
    },
    keys = {
        {
            "<F5>",
            function()
                require("dap").continue()
            end,
            desc = "Debug: start or continue",
        },
        {
            "<F10>",
            function()
                require("dap").step_over()
            end,
            desc = "Debug: step over",
        },
        {
            "<F11>",
            function()
                require("dap").step_into()
            end,
            desc = "Debug: step into",
        },
        {
            "<F12>",
            function()
                require("dap").step_out()
            end,
            desc = "Debug: step out",
        },
        {
            "<leader>db",
            function()
                require("dap").toggle_breakpoint()
            end,
            desc = "Debug: toggle breakpoint",
        },
        {
            "<leader>dB",
            function()
                require("dap").set_breakpoint(vim.fn.input("Condition: "))
            end,
            desc = "Debug: conditional breakpoint",
        },
        {
            "<leader>du",
            function()
                require("dapui").toggle()
            end,
            desc = "Debug: toggle panels",
        },
        {
            "<leader>de",
            function()
                require("dapui").eval()
            end,
            mode = { "n", "v" },
            desc = "Debug: evaluate expression",
        },
        {
            "<leader>dq",
            function()
                require("dap").terminate()
            end,
            desc = "Debug: terminate",
        },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup()

        dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = "codelldb",
                args = { "--port", "${port}" },
            },
        }
        for _, language in ipairs({ "c", "cpp" }) do
            dap.configurations[language] = {
                {
                    name = "Launch executable (CodeLLDB)",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        local path = vim.fn.input("Executable: ", vim.fn.getcwd() .. "/build/", "file")
                        if path == "" then
                            return dap.ABORT
                        end
                        return vim.fn.fnamemodify(path, ":p")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    args = {},
                },
                {
                    name = "Attach to process (CodeLLDB)",
                    type = "codelldb",
                    request = "attach",
                    pid = require("dap.utils").pick_process,
                    cwd = "${workspaceFolder}",
                },
            }
        end
        dap.listeners.after.event_initialized.config_ui = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.config_ui = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.config_ui = function()
            dapui.close()
        end
    end,
}
