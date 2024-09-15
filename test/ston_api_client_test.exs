defmodule StonApiClientTest do
  use ExUnit.Case
  doctest StonApiClient

  test "greets the world" do
    assert StonApiClient.hello() == :world
  end
end
