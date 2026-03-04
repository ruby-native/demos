# Habits (React demo)

A daily habit tracker built with Rails, Inertia.js, and React. Demonstrates that Ruby Native works with any frontend framework, not just Hotwire.

## Features

- Create habits with custom colors
- Track daily completions
- Today view with quick toggles
- Native tab bar (Today, Habits, Profile)
- Back button navigation
- Form handling
- Dark mode

## Quick start

```bash
bin/setup
bin/dev
```

Runs on port 3002. The dev server starts Rails and the Vite dev server.

Default login: `user@example.com` / `password`

## Requirements

- Ruby 4.0.1
- Node.js (for Vite and React)
- SQLite (`brew install sqlite`)

## Ruby Native config

```yaml
app:
  name: Habits

tabs:
  - title: Today
    path: /today
    icon: calendar
  - title: Habits
    path: /habits
    icon: list.bullet
  - title: Profile
    path: /profile
    icon: person
```

See `config/ruby_native.yml` for the full config including dark mode colors.
