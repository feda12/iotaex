defmodule IotaEx.TrytesTest do
  use ExUnit.Case, async: true

  alias IotaEx.Trytes
  doctest IotaEx.Trytes

  describe "from_binary/1" do
    test "param not a string" do
      assert Trytes.from_binary(123) == {:error, "invalid-param"}
    end

    test "param is a valid ASCII string" do
      assert Trytes.from_binary("Z") == {:ok, "IC"}
      assert Trytes.from_binary("hi") == {:ok, "WCXC"}
    end

    test "param has extreme characters" do
      assert Trytes.from_binary("Säφę") == {:error, "invalid-characters"}
      assert Trytes.from_binary("雪หิ🌲☃") == {:error, "invalid-characters"}
    end
  end

  describe "to_binary/1" do
    test "param is a valid trytes" do
      assert Trytes.to_binary("IC") == {:ok, "Z"}
      assert Trytes.to_binary("WCXC") == {:ok, "hi"}
    end
  end
end
