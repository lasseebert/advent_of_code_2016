defmodule Advent.Day01 do
  @moduledoc """
  --- Day 1: No Time for a Taxicab ---
  Santa's sleigh uses a very high-precision clock to guide its movements, and the clock's oscillator is regulated by stars. Unfortunately, the stars have been stolen... by the Easter Bunny. To save Christmas, Santa needs you to retrieve all fifty stars by December 25th.

  Collect stars by solving puzzles. Two puzzles will be made available on each day in the Advent calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!

  You're airdropped near Easter Bunny Headquarters in a city somewhere. "Near", unfortunately, is as close as you can get - the instructions on the Easter Bunny Recruiting Document the Elves intercepted start here, and nobody had time to work them out further.

  The Document indicates that you should start at the given coordinates (where you just landed) and face North. Then, follow the provided sequence: either turn left (L) or right (R) 90 degrees, then walk forward the given number of blocks, ending at a new intersection.

  There's no time to follow such ridiculous instructions on foot, though, so you take a moment and work out the destination. Given that you can only walk on the street grid of the city, how far is the shortest path to the destination?

  For example:

  Following R2, L3 leaves you 2 blocks East and 3 blocks North, or 5 blocks away.
  R2, R2, R2 leaves you 2 blocks due South of your starting position, which is 2 blocks away.
  R5, L5, R5, R3 leaves you 12 blocks away.
  How many blocks away is Easter Bunny HQ?
  """

  @doc """
  Finds the manhattan distance from start to end of the given path
  """
  @spec shortest_distance(String.t()) :: non_neg_integer
  def shortest_distance(input) do
    path = parse(input)

    init_delta = {0, 1}
    init_location = {0, 0}
    init_state = {init_delta, init_location}

    {_end_direction, end_location} = Enum.reduce(path, init_state, &walk/2)

    manhattan_distance(init_location, end_location)
  end

  defp walk({direction, amount}, {delta, location}) do
    new_delta = turn(direction, delta)
    new_location = new_delta |> mult(amount) |> add(location)
    {new_delta, new_location}
  end

  defp turn(:left, {x, y}), do: {-y, x}
  defp turn(:right, {x, y}), do: {y, -x}

  defp mult({x, y}, n), do: {x * n, y * n}
  defp add({x1, y1}, {x2, y2}), do: {x1 + x2, y1 + y2}
  defp manhattan_distance({x1, y1}, {x2, y2}), do: abs(x1 - x2) + abs(y1 - y2)

  defp parse(input) do
    input
    |> String.trim()
    |> String.split(", ", trim: true)
    |> Enum.map(&parse_instruction/1)
  end

  defp parse_instruction(instruction) do
    {direction_string, length_string} = String.split_at(instruction, 1)

    direction = parse_direction(direction_string)
    length = String.to_integer(length_string)

    {direction, length}
  end

  defp parse_direction("L"), do: :left
  defp parse_direction("R"), do: :right
end
