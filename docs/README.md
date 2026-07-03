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
