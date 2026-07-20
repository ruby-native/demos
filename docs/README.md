# Docs demo

A neutral todo app whose only job is to be the recording target for screenshots in the Ruby Native feature docs. Generic enough that captures show the feature, not the product.

Do not promote. Do not deploy. Do not register with the Ruby Native platform.

## Run

```sh
bin/setup
bin/dev
```

The dev server binds to **port 3004** so it doesn't collide with Beervana, Coffee, Habits, or the platform.

The gem is loaded from the local umbrella via `gem "ruby_native", path: "../../gem"`, so changes to `Ruby-Native/gem` are picked up immediately.

## Sign in

```
email:    joe@masilotti.com
password: password123
```

## What lives where

| Doc page | Where in the app |
|---|---|
| `tabs.md` | Bottom tab bar visible from any tab |
| `navbar.md` | Inbox (title + leading menu + trailing button), Profile (title + leading menu), Edit profile (title + submit button), Today (segments) |
| `forms.md` | New todo form (`/todos/new`), Edit todo form, Edit profile form. `native_form_tag` marks each. |
| `badges.md` | Inbox tab badge, driven by `native_badge_tag(tab: pending_count)` on every page |
| `fab.md` | Today tab. Plus icon links to new todo. |
| `back-buttons.md` | Todo show page, Normal Mode |
| `appearance.md` | Any page. Toggle Simulator dark mode for the pair. |
| `permissions.md` | Edit profile -> Profile photo file input triggers iOS camera permission dialog |
| `haptics.md` | Todo show -> Mark as done button (`:success`), Mark as not done (`:impact`) |

## What lives elsewhere

- IAP and Advanced Mode captures come from Beervana, not here.
- OAuth not wired up.

## CI test support

The umbrella `bin/ci` boots this app as the target for native UI test suites. Two env vars control test-only behavior:

- `RUBY_NATIVE_MODE` sets `app.mode` in `config/ruby_native.yml` (rendered through ERB). Defaults to `normal`; set `advanced` to boot an Advanced Mode instance.
- `RUBY_NATIVE_TEST_SUPPORT=1` reveals the Testing link on the profile page. That link opens `/testing`, a page holding everything not tied to a recording page: push registration, overscroll colors, an external link, and a color scheme indicator. Recordings never set the env var, so they never see any of it.

Each CI instance gets its own database via `DATABASE_URL` (for example `sqlite3:storage/ci_android.sqlite3` on port 3024) so concurrent suites never share mutable state with each other or with `bin/dev`.
