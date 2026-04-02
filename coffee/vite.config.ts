import { defineConfig } from "vite"
import ViteRuby from "vite-plugin-ruby"
import react from "@vitejs/plugin-react"
import tailwindcss from "@tailwindcss/vite"
import { resolve } from "path"
import { execSync } from "child_process"

function rubyNativeJsPath(): string {
  try {
    const gemRoot = execSync("bundle show ruby_native", { encoding: "utf-8" }).trim()
    return resolve(gemRoot, "app/javascript/ruby_native")
  } catch {
    return resolve(__dirname, "../../gem/app/javascript/ruby_native")
  }
}

export default defineConfig({
  plugins: [ViteRuby(), react(), tailwindcss()],
  resolve: {
    alias: {
      "~": resolve(__dirname, "app/frontend"),
      "ruby_native": rubyNativeJsPath(),
    },
    dedupe: ["react", "react-dom", "@inertiajs/react"],
  },
})
