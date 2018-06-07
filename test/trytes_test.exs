defmodule IotaEx.TrytesTest do
  use ExUnit.Case, async: true

  alias IotaEx.Trytes
  doctest IotaEx.Trytes

  describe "from_binary/1" do
    test "param not a string" do
      assert Trytes.from_binary(123) == nil
    end

    test "param is a valid ASCII string" do

    end
  end

  describe "to_binary/1" do

  end
end
