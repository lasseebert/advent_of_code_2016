defmodule Advent.Day01Test do
  use ExUnit.Case

  alias Advent.Day01

  describe "part 1" do
    test "example 1" do
      assert Day01.shortest_distance("R2, L3") == 5
    end

    test "example 2" do
      assert Day01.shortest_distance("R2, R2, R2") == 2
    end

    test "example 3" do
      assert Day01.shortest_distance("R5, L5, R5, R3") == 12
    end

    test "puzzle input" do
      assert "puzzle_inputs/day_01.txt"
             |> File.read!()
             |> Day01.shortest_distance() == 146
    end
  end
end
