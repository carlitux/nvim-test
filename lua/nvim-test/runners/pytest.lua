local Runner = require "nvim-test.runner"

local pytest = Runner:init({
  command = { (vim.env.VIRTUAL_ENV or "venv") .. "/bin/pytest", "pytest" },
  file_pattern = "\\v(test_[^.]+|[^.]+_test|tests)\\.py$",
  find_files = { "test_{name}.py", "{name}_test.py", "tests.py" },
}, {
  python = [[
      ; Class
      ((class_definition
        name: (identifier) @class-name) @scope-root)

      ; Function
      ((function_definition
        name: (identifier) @function-name) @scope-root)
    ]],
})

function pytest:is_test(name)
  return string.match(name, "[Tt]est") and true
end

function pytest:build_test_args(args, tests)
  args[#args] = args[#args] .. "::" .. table.concat(tests, "::")
end

return pytest
