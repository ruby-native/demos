import { defineConfig } from "vite"
import ViteRuby from "vite-plugin-ruby"
import vue from "@vitejs/plugin-vue"
import tailwindcss from "@tailwindcss/vite"
import { resolve } from "path"

export default defineConfig({
  plugins: [ViteRuby(), vue(), tailwindcss()],
  resolve: {
    alias: {
      "~": resolve(__dirname, "app/frontend"),
      "ruby_native": resolve(__dirname, "../../gem/app/javascript/ruby_native"),
    },
    dedupe: ["vue"],
  },
})
