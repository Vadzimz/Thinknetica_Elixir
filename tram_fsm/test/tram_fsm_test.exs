defmodule TramFSMTest do

  use ExUnit.Case
  import TramFSM

  doctest TramFSM

  test "available transitions" do
    assert available_transitions(:in_motion) == [:stop_moving, :come_back_to_depot]
  end

  test "to_state" do
    assert to_state(:in_depot, :start_moving) == [:in_motion]
  end

  test "genserver call" do
    {:ok, pid} = TramFSM.start_link
    GenServer.call(pid, :start_moving)
    assert GenServer.call(pid, :stop_moving) == %{
            new_state: :at_stop_with_doors_closed,
            old_state: :in_motion,
            transition: :stop_moving
          }
  end

end
