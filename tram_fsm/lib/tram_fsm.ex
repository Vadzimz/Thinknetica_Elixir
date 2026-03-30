defmodule TramFSM do
  use GenServer

  @moduledoc """
  Documentation for `TramFSM`.
  """

  @doc """

  ## Examples

      iex> {:ok, pid} = TramFSM.start_link
      iex> GenServer.call(pid, :start_moving)
      %{new_state: :in_motion, transition: :start_moving, old_state: :in_depot}
      iex> GenServer.call(pid, :start_moving)
      {:error, "Available transition(s) is(are) stop_moving, come_back_to_depot"}

  """


  # Tram states

  # 1 :in_depot - трамвай в депо
  # 2 :in_motion - трамвай в движении
  # 3 :at_stop_with_doors_closed - трамвай на остановке, двери закрыты
  # 4 :at_stop_with_doors_open - трамвай на остановке, двери открыты

  # Transitions between states

  # :start_moving 1 -> 2
  # :start_moving 3 -> 2
  # :stop_moving 2 -> 3
  # :open_doors 3 -> 4
  # :close_doors 4 -> 3
  # :come_back_to_depot 2 -> 1



  def init(initial_state) do
    {:ok, initial_state}
  end

  def start_link(initial_state \\ :in_depot) do
    GenServer.start_link(__MODULE__, initial_state)
  end

  def handle_call(transition, _from, state) do
    available_transitions = available_transitions(state)
    if transition in available_transitions do
      [new_state | _ ] = to_state(state, transition)
      {:reply, %{transition: transition, old_state: state, new_state: new_state} , new_state}
    else
      {:reply, {:error, "Available transition(s) is(are) #{Enum.join(Enum.map(available_transitions, &Atom.to_string/1), ", ")}"}, state}
    end
  end

  def transition_schema() do
    [
      %{transition: :start_moving, from: :in_depot, to: :in_motion},
      %{transition: :start_moving, from: :at_stop_with_doors_closed, to: :in_motion},
      %{transition: :stop_moving, from: :in_motion, to: :at_stop_with_doors_closed},
      %{transition: :open_doors, from: :at_stop_with_doors_closed, to: :at_stop_with_doors_open},
      %{transition: :close_doors, from: :at_stop_with_doors_open, to: :at_stop_with_doors_closed},
      %{transition: :come_back_to_depot, from: :in_motion, to: :in_depot}
    ]
  end

  def available_transitions(state) do
    for map <- transition_schema(), map.from == state, do: map.transition
  end

  def to_state(from_state, transition) do
    for map <- transition_schema(), map.transition == transition and map.from == from_state, do: map.to
  end

end
