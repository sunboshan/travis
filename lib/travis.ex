defmodule Travis do
  def hello do
    :world
  end

  def world do
    Jason.encode(1)
  end
end
