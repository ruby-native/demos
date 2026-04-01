# Demo apps

Three Rails apps demonstrating the `ruby_native` gem with different frontend frameworks and modes.

| Demo | Concept | Framework | Mode | Story |
|---|---|---|---|---|
| [Beervana](https://apps.apple.com/us/app/beervana-pdx-brewery-passport/id6760509246) | Brewery passport | Hotwire | Advanced | Real app, live in the App Store |
| Daily Grind | Coffee ordering | React + Inertia | Normal | Full-featured app with a native navigation bar and buttons |
| Habits | Habit tracker | Vue + Inertia | Normal | Minimal Ruby Native app with a web-based navigation bar |

## Beervana demo (`beervana/`)

A Portland brewery passport app. Track visits, explore neighborhoods, and discover new breweries. Advanced Mode with Stimulus bridge controllers via `@hotwired/hotwire-native-bridge`.

- **Stack:** Rails, Hotwire, Tailwind CSS
- **Mode:** Advanced (signal elements + bridge controllers)
- **Production:** [beervana.app](https://beervana.app)
- **App Store:** [Beervana on the App Store](https://apps.apple.com/us/app/beervana-pdx-brewery-passport/id6760509246)

## Coffee demo (`coffee/`)

A coffee shop ordering app (Daily Grind). Demonstrates that Normal Mode signal elements work with any frontend framework, not just Hotwire.

- **Stack:** Rails 8.1, Inertia Rails, React 19, Vite, Tailwind CSS 4
- **Mode:** Normal (signal elements via React components)
- **Port:** 3002 (Vite on 3102)
- **Start:** `bin/dev` (uses foreman)
- **Login:** `demo@example.com` / `password`

## Habits demo (`habits/`)

A habit tracker app. The simplest possible Ruby Native setup. Signal elements in HTML, no JavaScript bridge code.

- **Stack:** Rails 8.1, Inertia Rails, Vue 3, Vite, Tailwind CSS 4
- **Mode:** Normal (signal elements via data attributes)
- **Port:** 3003 (Vite on 3103)
- **Start:** `bin/dev` (uses foreman)
- **Login:** `user@example.com` / `password`

## Setup

From any demo directory:

```bash
bundle install
bin/rails db:setup
bin/dev
```

The Coffee and Habits demos also need `npm install` before first run.
