defmodule Maybe do
  @moduledoc """
  Access nested maps and structs, protected from `nil`.

  See `maybe/1` or `maybe/2` for more details.

  ## Example

      import Maybe

      map = %{city: %{name: "Portland"}}
      maybe(map, [:city, :name]) # => "Portland"
      maybe(map.city.name) # => "Portland"
      maybe(map.city.location) # => nil

  """

  @doc """
  Get a value out of a nested map or struct, or return nil.

  Compiles down to `maybe/2`. In other words, this:

      maybe(map.city.name)

  Is compiled down to a simple function call to `maybe/2`:

      maybe(map, [:city, :name])

  ## Examples

      iex> map = %{city: %{name: "Portland"}}
      ...> maybe(map.city.name)
      "Portland"

      iex> map = %{city: nil}
      ...> maybe(map.city.name)
      nil

      iex> map = %{city: :unknown}
      ...> maybe(map.city.name)
      nil
  """
  defmacro maybe(ast) do
    [variable | keys] = extract_keys(ast)

    quote do
      maybe(var!(unquote(variable)), unquote(keys))
    end
  end

  @doc """
  Get a value out of a nested map or struct, or return nil.

  For prettier syntax, see the `maybe/1` macro.

  ## Examples

      iex> map = %{city: %{name: "Portland"}}
      ...> maybe(map, [:city, :name])
      "Portland"

      iex> maybe(%{}, [:city, :name])
      nil
  """
  @spec maybe(map, keys :: [atom]) :: any | nil
  def maybe(map, keys)
  def maybe(nil, _keys), do: nil
  def maybe(val, []), do: val

  def maybe(map, [h | t]) when is_map(map) do
    maybe(Map.get(map, h), t)
  end

  def maybe(_, _), do: nil

  defp extract_keys(ast, keys \\ [])
  defp extract_keys([], keys), do: keys

  defp extract_keys({{:., _, args}, _, _}, keys) do
    extract_keys(args, keys)
  end

  defp extract_keys([{{:., _, args}, _, _} | t], keys) do
    keys = keys ++ extract_keys(args)
    extract_keys(t, keys)
  end

  defp extract_keys([{:., _, args} | t], keys) do
    keys = keys ++ extract_keys(args)
    extract_keys(t, keys)
  end

  defp extract_keys([key | t], keys) do
    keys = keys ++ [key]
    extract_keys(t, keys)
  end
end