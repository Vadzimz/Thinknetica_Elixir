defmodule SieveTest do
  use ExUnit.Case
  doctest Sieve

  test "sieve" do
    assert Sieve.main(100) |> length == 25
  end
end
