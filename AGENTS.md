# Perron Static Site Generator Guide

This project uses [Perron](https://perron.railsdesigner.com/docs/), a static site generator built on Ruby on Rails. This document covers how to add content, configure routes, and understand the directory structure.

## Directory Structure

```
app/
├── content/           # Content files (markdown and ERB)
│   ├── posts/         # Blog posts
│   │   ├── 2025-01-15-my-first-post.md
│   │   └── another-post.md
│   └── pages/         # Static pages
│       ├── root.md    # Homepage (required for root route)
│       ├── about.md
│       └── contact.erb
├── models/content/    # Resource model classes
│   ├── post.rb
│   └── page.rb
├── controllers/content/
│   ├── posts_controller.rb
│   └── pages_controller.rb
└── views/content/
    ├── posts/
    │   ├── index.html.erb
    │   ├── show.html.erb
    │   └── _post.html.erb  # Partial for rendering posts
    └── pages/
        └── show.html.erb
config/
├── routes.rb
└── initializers/
    └── perron.rb      # Perron configuration
```

## Adding Content

### Generating a New Resource Type

Use the Rails generator to scaffold a new content type:

```bash
bin/rails generate content Post
bin/rails generate content Post show  # Only generate show action
```

This creates:
- `app/content/posts/` directory
- `app/models/content/post.rb`
- `app/controllers/content/posts_controller.rb`
- `app/views/content/posts/{index,show}.html.erb`
- Route entry in `config/routes.rb`

### Adding Posts

Create files in `app/content/posts/` with `.md` or `.erb` extension.

**With frontmatter (recommended):**

```markdown
---
title: My First Post
description: An introduction to the blog.
published_at: 2025-01-15
---

This is the content of my first post written in **markdown**.
```

**With date in filename:**

Name the file `YYYY-MM-DD-slug.md` (e.g., `2025-01-15-my-first-post.md`). Perron extracts the publication date from the filename if `published_at` isn't in frontmatter.

### Adding Pages

Create files in `app/content/pages/`. The filename (minus extension) becomes the URL slug.

```markdown
---
title: About
description: Learn more about this site.
---

# About This Site

Content goes here.
```

### Draft Content

Mark content as unpublished:

```yaml
---
title: Work in Progress
draft: true
---
```

Or:

```yaml
---
title: Work in Progress
published: false
---
```

### Scheduled Publishing

Set a future date to schedule publication:

```yaml
---
title: Coming Soon
published_at: 2025-06-01
---
```

## Routes

Routes are configured in `config/routes.rb` using standard Rails routing:

```ruby
Rails.application.routes.draw do
  resources :posts, module: :content, only: %w[index show]
  resources :pages, module: :content, only: %w[show]
  root to: "content/pages#root"
end
```

### Expected Routes

| Route | URL | Controller Action |
|-------|-----|-------------------|
| `root_path` | `/` | `content/pages#root` |
| `posts_path` | `/posts/` | `content/posts#index` |
| `post_path("slug")` | `/posts/slug/` | `content/posts#show` |
| `page_path("about")` | `/pages/about/` | `content/pages#show` |

### URL Helpers

Link to content using Rails helpers:

```erb
<%= link_to "Read More", post_path("my-first-post") %>
<%= link_to "About", page_path("about") %>
```

### Clean URLs

By default, Perron generates clean URLs without file extensions. Configure trailing slashes and host in `config/initializers/perron.rb`:

```ruby
Perron.configure do |config|
  config.default_url_options = {
    host: "example.com",
    protocol: "https",
    trailing_slash: true
  }
end
```

## Resource Models

Define resource classes in `app/models/content/`:

```ruby
# app/models/content/post.rb
class Content::Post < Perron::Resource
  delegate :title, :description, to: :metadata
  
  belongs_to :author  # Expects author_id in frontmatter
end
```

```ruby
# app/models/content/page.rb
class Content::Page < Perron::Resource
  delegate :title, to: :metadata
end
```

### Associations

**has_many:**
```ruby
class Content::Author < Perron::Resource
  has_many :posts
end
```

**belongs_to:**
```ruby
class Content::Post < Perron::Resource
  belongs_to :author
end
```

In frontmatter: `author_id: jane-doe`

## Accessing Content in Views

### Single Resource

In show views, use `@resource`:

```erb
<article>
  <h1><%= @resource.metadata.title %></h1>
  <%= markdownify @resource.content %>
</article>
```

### Collections

Query resources using Ruby enumerable methods:

```erb
<% Content::Post.all.select(&:published?).sort_by(&:published_at).reverse.each do |post| %>
  <%= render post %>
<% end %>
```

Common operations:
- `Content::Post.all` - All posts
- `.select(&:published?)` - Filter to published
- `.sort_by(&:published_at).reverse` - Newest first
- `.first(5)` - Limit to 5 items
- `.group_by { |p| p.metadata.category }` - Group by field

## Frontmatter

YAML metadata at the top of content files:

```yaml
---
title: Post Title
description: A brief description for meta tags.
published_at: 2025-01-15
draft: false
author_id: jane-doe
category: tutorials
---
```

Access in templates via `@resource.metadata.field_name`.

## Markdown

Add a markdown gem to your Gemfile (`commonmarker`, `kramdown`, or `redcarpet`).

Render markdown with the `markdownify` helper:

```erb
<%= markdownify @resource.content %>

<%= markdownify do %>
  ## Inline Markdown
  This also works.
<% end %>
```

### Post-Processing

Enable HTML processors:

```erb
<%= markdownify @resource.content, process: [:target_blank, :lazy_load_images, :syntax_highlight] %>
```

## Sample Root Page (Index of Posts)

Create `app/content/pages/root.erb` or configure the root route to use `content/posts#index`.

**Option 1: Root page as ERB (`app/content/pages/root.erb`)**

```erb
---
title: Home
description: Welcome to my blog.
---

<main>
  <h1>Latest Posts</h1>
  
  <% Content::Post.all.select(&:published?).sort_by(&:published_at).reverse.each do |post| %>
    <article>
      <h2><%= link_to post.metadata.title, post_path(post.id) %></h2>
      <time datetime="<%= post.published_at.iso8601 %>">
        <%= post.published_at.strftime("%B %d, %Y") %>
      </time>
      <% if post.metadata.description.present? %>
        <p><%= post.metadata.description %></p>
      <% end %>
    </article>
  <% end %>
</main>
```

**Option 2: Posts index as root (`config/routes.rb`)**

```ruby
root to: "content/posts#index"
```

Then in `app/views/content/posts/index.html.erb`:

```erb
<main>
  <h1>Blog</h1>
  
  <% Content::Post.all.select(&:published?).sort_by(&:published_at).reverse.each do |post| %>
    <article>
      <h2><%= link_to post.metadata.title, post_path(post.id) %></h2>
      <time datetime="<%= post.published_at.iso8601 %>">
        <%= post.published_at.strftime("%B %d, %Y") %>
      </time>
      <% if post.metadata.description.present? %>
        <p><%= post.metadata.description %></p>
      <% end %>
    </article>
  <% end %>
</main>
```

## Pages Controller for Root

To use `root.erb` as the homepage, include `Perron::Root` in the pages controller:

```ruby
# app/controllers/content/pages_controller.rb
class Content::PagesController < ApplicationController
  include Perron::Root
  
  def show
    @resource = Content::Page.find(params[:id])
  end
end
```

## Building for Production

Generate static files:

```bash
bin/rails perron:build
```

Output goes to the `output/` directory by default (configurable via `config.output`).

## Validation

Check all resources for validation errors:

```bash
bin/rails perron:validate
```

## Configuration Reference

`config/initializers/perron.rb`:

```ruby
Perron.configure do |config|
  config.site_name = "My Site"
  config.site_description = "A site built with Perron"
  config.site_email = "hello@example.com"
  
  config.output = "output"
  config.allowed_extensions = %w[erb md]
  config.view_unpublished = Rails.env.development?
  
  config.default_url_options = {
    host: "example.com",
    protocol: "https",
    trailing_slash: true
  }
  
  # Sitemap
  config.sitemap.enabled = true
  config.sitemap.priority = 0.5
  config.sitemap.change_frequency = :monthly
  
  # Markdown options (depends on gem)
  config.markdown_options = { ... }
end
```

## Quick Reference

| Task | Command/Location |
|------|------------------|
| Generate new resource | `bin/rails generate content ResourceName` |
| Add a post | Create `app/content/posts/slug.md` |
| Add a page | Create `app/content/pages/slug.md` |
| Set homepage | Create `app/content/pages/root.md` or `.erb` |
| Build site | `bin/rails perron:build` |
| Validate content | `bin/rails perron:validate` |
