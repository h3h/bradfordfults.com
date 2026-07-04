# Remove Social Links Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Remove every social-network link from bradfordfults.com — the homepage icon rows and the site-wide footer Mastodon text link — with no leftover dead code (unused partials, unused SCSS).

**Architecture:** This is a static-content Rails/Perron site. Content lives in ERB templates (`app/content/pages/*.erb`, `app/views/shared/*.html.erb`) compiled by `rake perron:build` into static HTML under `output/`. There is no JS/unit test suite for this content — correctness is verified by grepping source for leftover references and rebuilding to inspect the generated HTML.

**Tech Stack:** Ruby on Rails view templates (ERB), SCSS (compiled via `stylesheet_link_tag`), Rake (`perron:build`).

## Global Constraints

- Spec source: `docs/superpowers/specs/2026-07-03-remove-social-icons-design.md`.
- Out of scope: `app/views/layouts/application.html.erb` and `app/views/shared/_header.html.erb` (neither references social content) — do not touch them.
- After all edits, `output/` must be rebuilt via `rake perron:build` so generated HTML matches source.

---

### Task 1: Remove homepage social icon rows

**Files:**
- Modify: `app/content/pages/root.erb:83-119` (delete the `<ul class="social-links">…</ul>` block, English homepage)
- Modify: `app/content/pages/hogar.erb:85-121` (delete the `<ul class="social-links">…</ul>` block, Spanish homepage)

**Interfaces:**
- Consumes: nothing from other tasks.
- Produces: neither homepage template references `shared/social/*` partials anymore. Task 2 depends on this before it can safely delete those partials.

- [ ] **Step 1: Confirm current markup boundaries**

Run: `grep -n 'social-links\|</article>' app/content/pages/root.erb app/content/pages/hogar.erb`

Expected output includes:
```
app/content/pages/root.erb:81:</article>
app/content/pages/root.erb:83:<ul class="social-links">
app/content/pages/root.erb:119:</ul>
app/content/pages/hogar.erb:83:</article>
app/content/pages/hogar.erb:85:<ul class="social-links">
app/content/pages/hogar.erb:121:</ul>
```

- [ ] **Step 2: Delete the block from `root.erb`**

Remove lines 83–119 (the blank line before `<ul class="social-links">` through the closing `</ul>`), so the file ends with:

```erb
    <section class="col">
      <h2><a href="/personal/">Personal</a></h2>
      <p>
        I write about being an eccentric and thoughtful citizen, living and
        opining in my own particular ways.
      </p>
      <p class="read-on"><a href="/personal/">Read on</a></p>
    </section>
  </div>
</article>
```

(i.e. the file now ends right after `</article>`, with no trailing `<ul>`).

- [ ] **Step 3: Delete the block from `hogar.erb`**

Apply the same removal to `hogar.erb`: delete lines 85–121 (blank line + `<ul class="social-links">…</ul>`), so the file ends right after its closing `</article>`.

- [ ] **Step 4: Verify no social-links markup remains in either file**

Run: `grep -n 'social-links\|shared/social' app/content/pages/root.erb app/content/pages/hogar.erb`
Expected: no output (exit code 1 / no matches).

- [ ] **Step 5: Commit**

```bash
git add app/content/pages/root.erb app/content/pages/hogar.erb
git commit -m "Remove social icon links from homepages"
```

---

### Task 2: Delete unused social partials and their SCSS rule

**Files:**
- Delete: `app/views/shared/social/_github.html.erb`
- Delete: `app/views/shared/social/_mastodon.html.erb`
- Delete: `app/views/shared/social/_map.html.erb`
- Delete: `app/views/shared/social/_medium.html.erb`
- Delete: `app/views/shared/social/_linkedin.html.erb`
- Delete: `app/views/shared/social/_instagram.html.erb`
- Delete: `app/views/shared/social/_threads.html.erb`
- Modify: `app/assets/stylesheets/application.scss:548-571` (delete the `.main-content ul.social-links { … }` rule)

**Interfaces:**
- Consumes: Task 1 must be complete first (no template may reference `shared/social/*` when these files are deleted, or the build breaks).
- Produces: no template in the repo references `shared/social/*`; no CSS rule targets `.social-links`.

- [ ] **Step 1: Confirm nothing still references these partials**

Run: `grep -rn "shared/social" app/`
Expected: no output (Task 1 already removed the only two call sites).

- [ ] **Step 2: Delete the partial files and the now-empty directory**

```bash
rm app/views/shared/social/_github.html.erb \
   app/views/shared/social/_mastodon.html.erb \
   app/views/shared/social/_map.html.erb \
   app/views/shared/social/_medium.html.erb \
   app/views/shared/social/_linkedin.html.erb \
   app/views/shared/social/_instagram.html.erb \
   app/views/shared/social/_threads.html.erb
rmdir app/views/shared/social
```

- [ ] **Step 3: Delete the SCSS rule**

In `app/assets/stylesheets/application.scss`, delete lines 548–571 (the full `.main-content ul.social-links { … }` block, including its nested `li`, `a:link`, `a:hover`, and `svg` selectors), so the file reads directly from the rule before it into the next rule:

```scss
  .published {
    display: block;
    font-size: 0.7em;
    opacity: 70%;
  }
}

.main-content section.essays ul.post-index .published {
  display: none;
}
```

- [ ] **Step 4: Verify removal**

Run: `ls app/views/shared/social 2>&1; grep -n "social-links" app/assets/stylesheets/application.scss`
Expected:
```
ls: app/views/shared/social: No such file or directory
```
(and no output from the grep).

- [ ] **Step 5: Commit**

```bash
git add -A app/views/shared/social app/assets/stylesheets/application.scss
git commit -m "Delete unused social icon partials and SCSS rule"
```

---

### Task 3: Remove the footer Mastodon text link

**Files:**
- Modify: `app/views/shared/_footer.html.erb` (both the `es` and default branches)

**Interfaces:**
- Consumes: nothing from other tasks (independent of Tasks 1–2).
- Produces: the footer renders only the privacy-notice/copyright line, on every page, in both languages.

- [ ] **Step 1: Confirm current content**

Run: `cat -n app/views/shared/_footer.html.erb`
Expected (current state):
```erb
<section class="site-footer">
  <% if lang == "es" %>
    <p>
      <a class="privacy" href="/privacy/">La noticia de privacidad</a>
      &middot; Todo el contenido &amp; código
      <a target="_blank" href="https://creativecommons.org/licenses/by/4.0/">CC-BY</a>
      &amp;&amp;
      <nobr>&copy; 2025 Bradford Fults</nobr>
      &rarr;
      <a rel="me" href="https://atx.pub/@h3h">@h3h@atx.pub</a>
    </p>
  <% else %>
    <p>
      <a class="privacy" href="/privacy/">Privacy Notice</a>
      &middot; All content &amp; code
      <a target="_blank" href="https://creativecommons.org/licenses/by/4.0/">CC-BY</a>
      &amp;&amp;
      <nobr>&copy; 2025 Bradford Fults</nobr>
      &rarr;
      <a rel="me" href="https://atx.pub/@h3h">@h3h@atx.pub</a>
    </p>
  <% end %>
</section>
```

- [ ] **Step 2: Rewrite the file without the Mastodon link**

Replace the full contents of `app/views/shared/_footer.html.erb` with:

```erb
<section class="site-footer">
  <% if lang == "es" %>
    <p>
      <a class="privacy" href="/privacy/">La noticia de privacidad</a>
      &middot; Todo el contenido &amp; código
      <a target="_blank" href="https://creativecommons.org/licenses/by/4.0/">CC-BY</a>
      &amp;&amp;
      <nobr>&copy; 2025 Bradford Fults</nobr>
    </p>
  <% else %>
    <p>
      <a class="privacy" href="/privacy/">Privacy Notice</a>
      &middot; All content &amp; code
      <a target="_blank" href="https://creativecommons.org/licenses/by/4.0/">CC-BY</a>
      &amp;&amp;
      <nobr>&copy; 2025 Bradford Fults</nobr>
    </p>
  <% end %>
</section>
```

- [ ] **Step 3: Verify removal**

Run: `grep -n "atx.pub\|rel=\"me\"" app/views/shared/_footer.html.erb`
Expected: no output (exit code 1 / no matches).

- [ ] **Step 4: Commit**

```bash
git add app/views/shared/_footer.html.erb
git commit -m "Remove Mastodon text link from site footer"
```

---

### Task 4: Rebuild the site and verify no social references remain anywhere

**Files:**
- None modified — this task rebuilds generated output and verifies the working tree.

**Interfaces:**
- Consumes: completed Tasks 1–3 (all source edits done).
- Produces: `output/` regenerated to match source; a final repo-wide confirmation that no dangling social references remain.

- [ ] **Step 1: Rebuild the static site**

Run: `bundle exec rake perron:build`
Expected: build completes with no errors (no "template not found" / missing-partial errors referencing `shared/social`).

- [ ] **Step 2: Confirm the homepages no longer render icons, in generated output**

Run: `grep -n "social-links\|bi-github\|bi-mastodon\|bi-linkedin\|bi-instagram\|bi-medium\|bi-threads" output/index.html output/hogar/index.html`
Expected: no output (exit code 1 / no matches).

- [ ] **Step 3: Confirm the footer no longer renders the Mastodon link, in generated output**

Run: `grep -rn "atx.pub" output/index.html output/hogar/index.html output/personal/index.html`
Expected: no output (exit code 1 / no matches).

- [ ] **Step 4: Repo-wide sanity sweep for leftover references**

Run: `grep -rln "shared/social\|social-links" app/ | cat`
Expected: no output — confirms no template, partial, or stylesheet in `app/` still mentions the removed feature.

`output/` is listed in `.gitignore` (it's build output, not source) — nothing to stage or commit for the rebuild itself. Tasks 1–3 already committed every source change.
