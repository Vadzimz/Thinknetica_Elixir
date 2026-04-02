defmodule Sieve do

  @moduledoc """
  recursive implementation the Sieve of Eratosthenes
  """

  def main(num) when num < 2, do: []
  def main(num), do: 2..num |> Enum.to_list |> sieve

  defp sieve([]), do: []
  defp sieve([head | tail]), do: [head | sieve(Enum.filter(tail, &rem(&1, head) != 0))]

end
