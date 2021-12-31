# Elixir Phoenix LiveView 1.6 Bulma and Tailwind CSS

This project is scaffold bulma and tailwind boilerplate code to project [Elixir](https://elixir-lang.org/) [Phoenix](https://www.phoenixframework.org/) `~> 1.6` that now uses [esbuild](https://esbuild.github.io/).

  - Bulma demo [here!](https://phx-scaffold-bulma-tailwind.fly.dev)
  - Tailwind demo [here!](https://phx-scaffold-bulma-tailwind.fly.dev/tailwind)


> Thanks to [fly.io](https://fly.io)
 
## Running

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Testing

- Enter `localhost:4000/` to [bulmacss](https://bulma.io) and [admin template](https://bulmatemplates.github.io/bulma-templates/).
- Enter `localhost:4000/tailwind` to [tailwindcss](https://tailwindcss.com) [admin template](https://bulmatemplates.github.io/bulma-templates/).

## Production

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## NOW => How this project was made :D

- Creating `mix phx.new phx_scaffold_bulma_tailwind --live --no-ecto`
- Install and configure [dart_css](https://github.com/fvideen/dart_sass).
- Install and configure [bulma](https://bulma.io).
- Install and configure [tailwind](https://tailwindcss.com)
- Configure `mix.exs`
- Configure `dev.exs`

> Follow complete steps:

### 1. Creating Phoenix 1.6 LiveView project

```sh
mix phx.new phx_scaffold_bulma_tailwind --live --no-ecto
```

### 2. Install [dart_css](https://github.com/fvideen/dart_sass)

Follow instructions [here](https://github.com/fvideen/dart_sass#adding-to-phoenix).

### 3. Install [bulma](https://bulma.io)

```sh
npm i -D --prefix assets bulma
```
Import `bulma.sass` file into `css/app.scss` with:

```css
@import "../node_modules/bulma/bulma.sass";
```

### 4. Install [tailwindcss](https://tailwindcss.com)

```sh
npm i -D --prefix assets tailwindcss autoprefixer postcss postcss-loader
```

Create file `assets/tailwind.config.js` with:

```javascript
module.exports = {
  content: [
    "../lib/**/*.html.eex",
    "../lib/**/*.html.leex",
    "../lib/**/*.html.heex",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
```

Create file `assets/postcss.config.js` with:

```javascript
module.exports = {
    plugins: {
        tailwindcss: {},
        autoprefixer: {}
    }
}
```

Create file `assets/css/tailwind.css` with:

```css
/* This file is for your main application CSS */
@tailwind base;
@tailwind components;
@tailwind utilities;
```

Import `css/tailwind.css` into `assets/css/app.scss` after `css` styles:

> Here is last line of the file

```css
@import "./tailwind.css";
```

Includes script into `package.json` with:

```json
  "scripts": {
    "tailwind": "NODE_ENV=production tailwindcss --postcss --minify --input=css/tailwind.css --output=../priv/static/assets/tailwind.css"
  },
```

Configure `mix.exs` into function `aliases` with:

```elixir
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get"],
      "assets.deploy": [
        "cmd --cd assets npm install",
        "cmd --cd assets npm run tailwind",
        "esbuild default --minify",
        "sass default --no-source-map --style=compressed",
        "phx.digest"
      ]
    ]
  end
```

Configure `dev.exs` into `watchers` with `npx` instructions:

```elixir
# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with esbuild to bundle .js and .css sources.
config :fvideen_platform, FvideenPlatformWeb.Endpoint,
  # Binding to loopback ipv4 address prevents access from other machines.
  # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "q8icUmJfcHI8LF9Ajh+WKBaIXlxER5k7Hdwu845pJO45MBjL8eg5bJ8o9cJyverv",
  watchers: [
    # Start the esbuild watcher by calling Esbuild.install_and_run(:default, args)
    npx: [
      "tailwindcss",
      "--input=css/tailwind.css",
      "--output=../priv/static/assets/tailwind.css",
      "--postcss",
      "--watch",
      cd: Path.expand("../assets", __DIR__)
    ],
    esbuild: {
      Esbuild, 
      :install_and_run, 
      [:default, ~w(--sourcemap=inline --watch)]
    },
    sass: {
      DartSass,
      :install_and_run,
      [:default, ~w(--embed-source-map --source-map-urls=absolute --watch)]}
  ]
```

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
