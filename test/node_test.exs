defmodule IotaEx.NodeTest do
  use ExUnit.Case, async: true

  doctest IotaEx.Node

  test "returns node info" do
    {:ok, node_info} = IotaEx.Node.info()
  end
end
