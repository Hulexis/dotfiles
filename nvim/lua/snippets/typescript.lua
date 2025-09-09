local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep

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
})

ls.add_snippets("typescriptreact", {
	s("sonmount", {
		t("onMount(() => {"),
		t({ "", "\t" }),
		i(1),
		t({ "", "});" }),
	}),
})
