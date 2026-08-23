`bradfordfults.com`, Bradford Fults' personal site. It's a Rails 8 app built on [Perron](https://perron.railsdesigner.com/docs/), a static site generator — Rails renders content in development, and `perron:build` compiles to static in `output/`. No DB, no tests.

## Committing

* Never co-sign commits: do not append `Co-authored-by` or any other co-sign trailer

## Commands

```bash
bin/setup --skip-server       # install gems (bin/ci uses this)
bin/rails server -p 3000      # dev server (also: `rails s`)
bin/dev                       # runs web + CSS watcher via goreman/Procfile (requires goreman)
bin/rails dartsass:watch       # SCSS watcher only

bin/rails perron:build         # compile static site into output/
bin/rails perron:validate      # check all content resources for validation errors

bin/rails generate content Post        # scaffold a new Perron resource type
bin/rails generate content Post show   # scaffold only the show action
```

Deployment is: `rails perron:build && git push origin` (the built `output/` is committed/pushed; see README.md).

There are no automated tests. `bin/ci` runs `bin/setup --skip-server` as its only step.

## Architecture

This is a Perron content site, not a typical Rails app — most "pages" are content files, not controller actions.

- **Content lives in `app/content/`**, not the database:
  - `app/content/posts/*.md` — blog posts, either `YYYY-MM-DD-slug.md` or with `published_at` in frontmatter. Bilingual (English/Spanish); Spanish posts have their own filenames (e.g. paired `...-paralysis.md` / `...-parálisis.md`).
  - `app/content/pages/*.erb` — static/section pages, several using nested paths (`business/software.erb`, `personal/books.erb`) that back the "subcategory" routes.
  - `app/content/data/*.yml` — structured data consumed via `Perron::Site.data.<name>`; see `app/content/data/README.md` for the read-only accessor pattern. `cats.yml` maps category/subcategory slugs to per-language display names and URLs (used for the bilingual nav).
- **Resource models** in `app/models/content/` (`Content::Post`, `Content::Page`) subclass `Perron::Resource` and `delegate` frontmatter fields (title, description, lang, category, etc.) via `to: :metadata`. Business logic like `book_review?`, `essay?`, `aside?`, `english?`/`spanish?`, and `translated_post`/`translated_page` (bilingual pairing via a shared `lang_ref`) lives here, not in controllers.
- **Controllers** (`app/controllers/content/`) are thin: `PostsController#index` filters to `published?`, `show` looks up by slug; `PagesController` includes `Perron::Root` for the homepage and otherwise just does `Content::Page.find(params[:id])`.
- **Routing** (`config/routes.rb`): most page routes are explicit `get "<path>", to: "content/pages#show", id: "<path>"` entries rather than a single catch-all — English and Spanish section/subcategory pages are separate route lines (e.g. `business`/`negocios`, `personal`/`seccion-personal`).
- **Bilingual content pattern**: every English post/page can have a Spanish counterpart sharing the same `lang_ref` in frontmatter and `lang: en`/`lang: es`. The layout (`app/views/layouts/application.html.erb`) auto-emits an `<link rel="alternate" hreflang=...>` when `translated_post`/`translated_page` resolves, and views render `shared/_lang_ref_link*` partials to cross-link translations.
- **Book reviews** are posts with `layout: book_review` in frontmatter plus `book_name`/`book_author`/`book_rating`/`book_spoilers` fields; `Content::Post#book_review?` and `#display_title` (falls back to `book_name`) drive rendering via `_book_review.html.erb`.
- **UTF-8 output paths**: `config/initializers/perron.rb` monkey-patches `Perron::Site::Builder::Page` so non-ASCII (Spanish) URL segments write as real UTF-8 directory names in `output/` instead of percent-encoded paths, since Rails URL helpers percent-encode them by default.
- **Feeds/SEO**: RSS (`config.feeds.rss`) and sitemap settings are configured per-resource inside `Content::Post`'s `configure do |config| ... end` block, not globally.
- **Styling**: SCSS via `dartsass-rails`, entry point `app/assets/stylesheets/application.scss`, compiled to `app/assets/builds/application.css` (gitignored, rebuilt by `dartsass:watch`/asset pipeline).
- **Design/plan docs**: recent feature work is documented under `docs/superpowers/specs/` and `docs/superpowers/plans/` (design spec + implementation plan pairs) — check there for context on recent changes before assuming intent from a diff alone.
