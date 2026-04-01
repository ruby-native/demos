import { createInertiaApp } from "@inertiajs/react"
import { createRoot } from "react-dom/client"
import Layout from "~/layouts/Layout"
import "~/styles/application.css"

const pages = import.meta.glob("../pages/**/*.jsx", { eager: true })

createInertiaApp({
  resolve: (name) => {
    const page = pages[`../pages/${name}.jsx`]
    if (!page) throw new Error(`Page not found: ${name}`)
    page.default.layout = page.default.layout || ((page) => <Layout>{page}</Layout>)
    return page
  },
  setup({ el, App, props }) {
    createRoot(el).render(<App {...props} />)
  },
})
