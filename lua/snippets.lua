local ls = require "luasnip"
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require "luasnip.util.types"
local conds = require "luasnip.extras.conditions"
local conds_expand = require "luasnip.extras.conditions.expand"

table.unpack = table.unpack or unpack -- 5.1 compatibility

-- If you're reading this file for the first time, best skip to around line 190
-- where the actual snippet-definitions start.

local phxComponent = s("cmp", {
  t { "", 'attr :class, :string, default: nil, doc: "Component optional classes"' },
  t { "", "attr :rest, :global" },
  t { "", "slot :inner_block, required: true" },
  t { "", "" },
  t { "", "def " },
  i(1, "component_name"),
  t "(assigns) do",
  t {
    "",
    '\t~H"""',
    '\t\t<div class={["someclass", @class]} {@rest}>',
    "\t\t\tcontent",
    "\t\t</div>",
    '\t"""',
    "end",
    "",
  },
})

ls.add_snippets("elixir", {
  phxComponent,
})
