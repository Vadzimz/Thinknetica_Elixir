defmodule DifferenceOfSquares do

  @moduledoc """
    Difference of squares
  """

  def get_diff(num) do
    1..num
     |> Enum.reduce({0, 0}, fn x, {a, b} ->  {x + a, x ** 2 + b} end)
     |> then(fn {a, b} -> a ** 2 - b end)
  end
end

ExUnit.start()

defmodule DifferenceOfSquaresTest do
  use ExUnit.Case
  import DifferenceOfSquares

  test "Difference of squares" do
    assert get_diff(10) == 2640
  end
end
