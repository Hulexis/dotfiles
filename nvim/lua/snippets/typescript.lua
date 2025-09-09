local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep
local f = ls.function_node

local function capitalise_first(args)
	local v = args[1][1] or ""
	return (v:gsub("^%l", string.upper))
end

ls.add_snippets("typescriptreact", {
	s("scontext", {
		t({ 'import { type Component, type ParentProps, createContext, useContext } from "solid-js";', "", "" }),

		-- User input for the context name
		t("type "),
		i(1, "Name"),
		t("ContextValue = {"),
		t({ "", "\tinfo: () => string;", "};", "", "" }),

		-- Replace Name dynamically
		t("export const "),
		rep(1),
		t("Context = createContext<"),
		rep(1),
		t("ContextValue>();"),
		t({ "", "" }),

		t("export const "),
		rep(1),
		t("Provider: Component<ParentProps> = (props) => {"),
		t({ "", "\tconst value: " }),
		rep(1),
		t("ContextValue = {"),
		t({ "", '\t\tinfo: () => "",', "\t};", "", "" }),

		t("\treturn <"),
		rep(1),
		t("Context.Provider value={value}>{props.children}</"),
		rep(1),
		t("Context.Provider>;"),
		t({ "", "};", "", "" }),

		t("export const use"),
		rep(1),
		t(" = () => {"),
		t({ "", "\tconst context = useContext(" }),
		rep(1),
		t("Context);"),
		t({ "", "" }),

		t("\tif (context === undefined) {"),
		t({ "", '\t\tthrow new Error("[PACKAGE]: `use' }),
		rep(1),
		t("` must be used within a `"),
		rep(1),
		t('Provider` component;")'),
		t({ "", "\t}", "", "\treturn context;", "};" }),
	}),
})

ls.add_snippets("typescriptreact", {
	s("seffect", {
		t("createEffect(() => {"),
		t({ "", "\t" }),
		i(1),
		t({ "", "});" }),
	}),

	s("sonmount", {
		t("onMount(() => {"),
		t({ "", "\t" }),
		i(1),
		t({ "", "});" }),
	}),

	s("ssignal", {
		t("const ["),
		i(1, "value"), -- ask for the variable name
		t(", set"),
		f(capitalise_first, { 1 }), -- -> setX from the first insert
		t("] = createSignal("),
		i(2, "initial"),
		t(");"),
	}),

	s("sstore", {
		t("const ["),
		i(1, "state"),
		t(", set"),
		f(capitalise_first, { 1 }),
		t("] = createStore("),
		t("{ "),
		i(2),
		t(" });"),
	}),

	s("smemo", {
		t("const "),
		i(1, "computed"),
		t(" = createMemo(() => "),
		i(2, "expression"),
		t(");"),
	}),

	s("soncleanup", {
		t("onCleanup(() => {"),
		t({ "", "\t" }),
		i(1),
		t({ "", "});" }),
	}),

	s("scomponent", {
		t("const "),
		i(1, "Name"),
		t(": Component = () => {"),
		t({ "", "\treturn (" }),
		t({ "", "\t\t" }),
		i(2, "<div />"),
		t({ "", "\t);" }),
		t({ "", "};" }),
	}),

	s("sfor", {
		t("<For each={"),
		i(1, "items"),
		t("}>{("),
		i(2, "item"),
		t(") => ("),
		t({ "", "\t" }),
		i(3, "<div>{item}</div>"),
		t({ "", ")} </For>" }),
	}),

	s("swhen", {
		t("createWhen("),
		i(1, "condition"),
		t(", ("),
		i(2, "e"),
		t(") => {"),
		t({ "", "\t" }),
		i(3),
		t({ "", "});" }),
	}),
})
