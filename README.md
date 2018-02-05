# Maybe
[![Hex.pm](https://img.shields.io/hexpm/v/maybe.svg)](https://hex.pm/packages/maybe)
[![Build Status](https://travis-ci.org/infinitered/maybe.svg?branch=master)](https://travis-ci.org/infinitered/maybe)

Access nested Elixir maps and structs, protected from `nil`.

```elixir
import Maybe

info = %{city: %{name: "Portland"}}
maybe(info.city.name)
# => "Portland"

map = %{}
maybe(map.city.name)
# => nil
```

## Installation

Add `maybe` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:maybe, "~> 1.0.0"}
  ]
end
```

See [the documentation](https://hexdocs.pm/maybe) for more details.