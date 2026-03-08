import { defineConfig } from "vite"
import ViteRuby from "vite-plugin-ruby"
import react from "@vitejs/plugin-react"
import tailwindcss from "@tailwindcss/vite"
import { resolve } from "path"

export default defineConfig({
  plugins: [ViteRuby(), react(), tailwindcss()],
  resolve: {
    alias: {
      "~": resolve(__dirname, "app/frontend"),
      "ruby_native": resolve(__dirname, "../../gem/app/javascript/ruby_native"),
    },
    dedupe: ["react", "react-dom"],
  },
})
