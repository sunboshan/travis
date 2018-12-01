defmodule TravisTest do
  use ExUnit.Case
  doctest Travis

  test "greets the world" do
    assert Travis.hello() == :world
  end
end
