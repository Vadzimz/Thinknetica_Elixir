## Simple implementation of FSM for working of a tram

### FSM Schema

| From | Across | To |
| :---------------- | :--------------: | -----------------: |
| in_depot | start_moving | in_motion |
| at_stop_with_doors_closed | stop_moving | in_motion |
| in_motion | stop_moving | at_stop_with_doors_closed |
| at_stop_with_doors_closed |open_doors | at_stop_with_doors_open |
| at_stop_with_doors_open | close_doors | at_stop_with_doors_closed |
| in_motion | come_back_to_depot | in_depot |


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `tram_fsm` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:tram_fsm, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/tram_fsm>.

