# Remove social links from the site

## Goal

Remove all social-network links (icon row + footer text link) from the site, with no dead code left behind.

## Background

Social presence currently shows up in two places:

1. An icon row (`<ul class="social-links">`) at the bottom of the page content on the English homepage (`app/content/pages/root.erb`, lines 83–119) and the Spanish homepage (`app/content/pages/hogar.erb`, lines 85–121). Each renders 7 partials from `app/views/shared/social/`: `_github`, `_mastodon`, `_map` (Google Maps reviews), `_medium`, `_linkedin`, `_instagram`, `_threads`. No other template references these partials.
2. A plain-text Mastodon `rel="me"` link (`@h3h@atx.pub`) in the site-wide footer (`app/views/shared/_footer.html.erb`), appearing on every page, in both the `es` and default language branches.

## Changes

1. **`app/content/pages/root.erb`** — delete the `<ul class="social-links">…</ul>` block (lines 83–119).
2. **`app/content/pages/hogar.erb`** — delete the `<ul class="social-links">…</ul>` block (lines 85–121).
3. **`app/views/shared/social/`** — delete all 7 partial files (`_github.html.erb`, `_mastodon.html.erb`, `_map.html.erb`, `_medium.html.erb`, `_linkedin.html.erb`, `_instagram.html.erb`, `_threads.html.erb`) and the now-empty `social/` directory.
4. **`app/assets/stylesheets/application.scss`** — delete the `.main-content ul.social-links { … }` rule (lines 548–~566, including nested `li`, `a:link`, `a:hover`, `svg` selectors).
5. **`app/views/shared/_footer.html.erb`** — remove the trailing `&rarr; <a rel="me" href="https://atx.pub/@h3h">@h3h@atx.pub</a>` segment from both the `es` and default (`en`) branches, leaving just the privacy-notice / copyright line in each.
6. Rebuild the site so `output/` (generated) reflects the change: `rake perron:build`.

## Out of scope

- No other social references exist elsewhere in the codebase (confirmed via repo-wide search) — this covers every occurrence.
- No changes to `app/views/layouts/application.html.erb` or `app/views/shared/_header.html.erb` — neither references social content.

## Testing

- Visual check: build the site and confirm `/`, `/hogar`, and one other page (e.g. `/personal/`) render with no icon row and no Mastodon footer link, in both languages.
- Confirm no broken references: grep the codebase post-change for `social` / `mastodon` / `github.com/h3h` / etc. to ensure no dangling `render "shared/social/..."` calls remain.
