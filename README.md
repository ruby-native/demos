# Demo apps

Four Rails apps demonstrating the `ruby_native` gem with different frontend frameworks.

## Turbo demo (`turbo/`)

A bookmarks/links app using Turbo Drive + importmap.

- **Stack:** Rails 8.1.2, Turbo, Stimulus, Bootstrap CSS
- **Port:** 3001
- **Start:** `bin/dev`
- **Login:** `user@example.com` / `password`

## React demo (`react/`)

A habit tracker app using Inertia.js + React 19.

- **Stack:** Rails 8.1.2, Inertia Rails, React 19, Vite, Tailwind CSS 4
- **Port:** 3002 (Vite on 3136)
- **Start:** `bin/dev` (uses foreman)
- **Login:** `user@example.com` / `password`

## Coffee demo (`coffee/`)

A coffee shop ordering app (Daily Grind) using Tailwind CSS.

- **Stack:** Rails, Hotwire, Tailwind CSS
- **Port:** 3003
- **Start:** `bin/dev`
- **Login:** `demo@example.com` / `password`

## Vue demo (`vue/`)

A habit tracker app using Inertia.js + Vue 3.

- **Stack:** Rails 8.1.2, Inertia Rails, Vue 3, Vite, Tailwind CSS 4
- **Port:** 3004 (Vite on 3236)
- **Start:** `bin/dev` (uses foreman)
- **Login:** `user@example.com` / `password`

## Setup

All apps reference the gem at `../../gem`. From any demo directory:

```bash
bundle install
bin/rails db:setup
bin/dev
```

The React and Vue demos also need `npm install` before first run.
