# bradfordfults.com

The eponymous.

## Dependencies

This site is built with [Perron][PG] and only uses Rails to actively render
the site in development. Perron has a task, `perron:build`, which compiles the
site into static HTML files for deployment in production.

 [PG]: https://github.com/Rails-Designer/perron

## Development

```
rails s
```

## Static Site Compilation & Deployment

```
rails perron:build && git push origin
```
