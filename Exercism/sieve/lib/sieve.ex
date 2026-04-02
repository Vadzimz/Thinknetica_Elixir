defmodule Sieve do

  @moduledoc """
  recursive implementation the Sieve of Eratosthenes
  """
  def main(num) when is_integer(num) and num > 1 do
    2..num
    |> Enum.to_list
    |> sieve
  end

  defp sieve(list, acc \\ [])
  defp sieve([], acc), do: acc
  defp sieve([head | tail], acc) do
    acc = acc ++ [head]
    to_remove = Enum.filter(tail, &rem(&1, head) == 0)
    sieve(tail -- to_remove, acc)
  end

end
