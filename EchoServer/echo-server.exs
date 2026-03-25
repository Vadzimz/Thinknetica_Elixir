defmodule EchoServer do

  @moduledoc """
    Primitive implpementation of EchoServer
  """

  @doc "start server"
  def start(), do: spawn(&run/0)

  @doc "loop server"
  def run(), do: listen() && run()

  @doc "send message from client to server"
  def ping(pid, :ping), do: send(pid, {self(), :ping})

  @doc "server listens messages from clients"
  def listen() do
    receive do
      {pid, :ping} -> send(pid, {:pong, node()})
    end
  end

  @doc "show last message of process"
  def show_last_msg(pid), do: Process.info(pid, :messages) |> elem(1) |> hd()

end

ExUnit.start()

defmodule EchoServerTest do
  use ExUnit.Case
  import EchoServer

  test "EchoServer" do
    pid = start()
    ping(pid, :ping)
    assert show_last_msg(pid) |> elem(1) == :ping
    assert show_last_msg(self()) |> elem(0) == :pong
  end

end
