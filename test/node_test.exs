defmodule IotaEx.NodeTest do
  use ExUnit.Case, async: true

  doctest IotaEx.Node

  setup do
    node = %IotaEx.Node{name: "Test Node", url: "localhost", port: "200"}

    {:ok, node: node}
  end

  test "returns node info", %{node: node} do
    {:ok, node_info} = IotaEx.Node.info(node)

    IO.inspect node_info
  end
end
