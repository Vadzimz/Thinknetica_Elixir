defmodule LagestSeriesProduct do

  # def lagest_series_product(str, size) when String.match?(str, ~r/\D/), do: raise("wrong input data")
  def lagest_series_product(str, size) when size not in 1..length(str)//1, do: raise("size is out of range")
  def lagest_series_product(str, size) do
    str
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1) #Alter: String.to_integer() |> Integer.digits()
    |> Enum.chunk_every(size, 1, :discard)
    |> Enum.reduce(0, &max(Enum.product(&1), &2))
  end
end

ExUnit.start()

defmodule LagestSeriesProductTest do
  use ExUnit.Case
  import LagestSeriesProduct

  test "lagest series product" do
    assert lagest_series_product("731283127312778", 3) == 392
  end
end
