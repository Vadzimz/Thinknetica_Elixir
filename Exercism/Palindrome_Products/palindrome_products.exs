defmodule PalindromeProducts do

  @moduledoc """
  Getting of smallest and largest palindromic number which are the product of two numbers in a given range
  """

  def main(a, b) do
    Stream.flat_map(a..b, fn x -> Stream.map(a..b, fn y -> {{x, y} , x * y} end) end)
    |> Stream.uniq_by(fn {_, y} -> y end)
    |> Stream.filter(fn {_, y} -> palindromic?(y) end)
    |> Enum.min_max_by(fn {_, y} -> y end)
  end

  def palindromic?(num) do
    num
    |> Integer.to_string
    |> then(fn x -> x == String.reverse(x) end)
  end
end

ExUnit.start()

defmodule PalindromeProductsTest do

  use ExUnit.Case
  import PalindromeProducts

  test "min and max products" do
    assert main(10, 99) == {{{11, 11}, 121}, {{91, 99}, 9009}}
  end

  test "palindromic" do
    palindromic? 234432
  end
end
