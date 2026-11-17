# Daily runbook

Start Neovim from your project root: `cd project && nvim`. `<leader>` is Space.

## Navigation, editing, and Git

| Key | Action |
| --- | --- |
| Space pf / Space gf | Find files / tracked Git files |
| Space ps / Space of | Search project text / recent files |
| Space pv / Space - | Oil directory editor / floating browser |
| Space gs / Space gb | Git status / blame |
| Alt h/j/k/l | Move between splits |
| Space th | Pick and persist a theme |
| Ctrl j/k | Next/previous completion candidate |
| Enter / Ctrl y | Accept completion |
| Ctrl n/p | Completion or snippet navigation |
| Space f | Format current buffer |

Formatting also runs on save. `:ConformInfo` shows the selected formatter and errors.
In Oil, edit directory entries and write the buffer to apply filesystem changes;
review its confirmation before accepting file operations.

## Language features

These mappings become available when an LSP attaches:

| Key | Action |
| --- | --- |
| gd / K | Definition / documentation |
| Space vrr / Space vrn | References / rename |
| Space vca / Space vd | Code actions / diagnostic details |
| Space vws | Workspace symbols |
| Space ls / Space li | Document symbols / implementations |
| Ctrl h in insert mode | Signature help |

Use `:checkhealth vim.lsp` if navigation or diagnostics are missing. Installation,
project root detection, and the project's dependencies all affect server startup.

## C and C++

Generate a debug build and clangd's compilation database from the project root:

```sh
cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
cmake --build build
ctest --test-dir build --output-on-failure
```

The last command runs tests only if the project defines CTest tests. For compilation
databases outside clangd's usual discovery paths, put `CompileFlags: { CompilationDatabase: build }`
in a project `.clangd` file, or expose the database at the project root. Use a
project `.clang-format` for consistent formatting. Rebuild after source changes;
the debugger launches the compiled executable and does not build it for you.

### Debugging

1. Open a `.cpp` or `.c` source file and use Space db on an executable line.
2. Press F5, choose **Launch executable (CodeLLDB)**, and enter the built binary's path.
3. When it stops, inspect scopes, watches, and stack frames in the panels.
4. Use F10 to step over, F11 to step into, F12 to step out, F5 to continue.
5. Space dq terminates the session. Panels open and close with the session.

Space dB sets a conditional breakpoint; Space de evaluates the expression under
the cursor or the selection; Space du toggles panels. In scopes, Enter expands a
value. In watches, enter insert mode to add an expression.

The second F5 configuration attaches to an existing process. Linux process tracing
permissions may prevent attaching; launching under the debugger is the first option
to try. Hollow/unverified breakpoints usually mean the wrong binary, missing debug
symbols, optimized code, or source paths that do not match the build.

For per-project arguments/environment, use `.vscode/launch.json` with a `codelldb`
configuration. nvim-dap supports this file; comments require an optional JSON parser,
so use strict JSON. Example (replace `app` with your actual binary):

```json
{
  "version": "0.2.0",
  "configurations": [{
    "name": "Debug app",
    "type": "codelldb",
    "request": "launch",
    "program": "${workspaceFolder}/build/app",
    "cwd": "${workspaceFolder}",
    "args": ["--example"],
    "env": {"APP_MODE": "development"}
  }]
}
```

## Other languages

| Language | Editor support | Project workflow / prerequisites |
| --- | --- | --- |
| Rust | rustaceanvim owns rust-analyzer | Install Rust/Cargo; `cargo build`, `cargo test`, `cargo fmt`; `:RustLsp debuggables` discovers debug targets and uses the installed CodeLLDB through rustaceanvim. |
| Go | gopls; goimports formatting | Install a compatible Go toolchain; `go test ./...`, `go run .`. Delve is installed, but no Go DAP adapter is configured. |
| Python | Pyright + Ruff; Ruff formatting | Create/activate the project's virtualenv before opening Neovim; install project dependencies; use the project's test runner. No Python DAP adapter is configured. |
| JS/TS, React, HTML, CSS | TypeScript/HTML/CSS/Tailwind/Emmet servers; Prettier | Install Node and project dependencies; use package scripts for dev/build/test. No JS DAP adapter is configured. |
| Lua | lua_ls + lazydev; StyLua | lazydev supplies Neovim API context; validate this config with the startup checker. |
| Luau / Roblox | luau-lsp.nvim; Studio integration | Install Rojo and the Luau Language Server Companion Studio plugin; use `default.project.json`; generated sourcemap is `sourcemap.json`; integration port is 3667. |
| Zig | zls | Install a Zig version compatible with the pinned ZLS; `zig build`, `zig build test`. No Zig formatter or DAP launch entry is configured. |
| Shell | bashls; shfmt | Execute scripts in the intended shell; shellcheck is not configured. |
| JSON, YAML, TOML, Markdown | Schema/language support; formatters where configured | JSON/YAML/Markdown use Prettier; TOML uses Taplo. |
| Docker / Solidity | Language servers; syntax support | Install the project's build/runtime tools separately. |

Tree-sitter supplies highlighting and structural selection (Ctrl Space), not compilers,
project dependencies, or test runners. Use `:terminal` for build/test commands;
Ctrl backslash followed by Ctrl n returns from terminal mode to normal mode.
