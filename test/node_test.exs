defmodule IotaEx.NodeTest do
  use ExUnit.Case, async: true

  alias IotaEx.Node
  doctest IotaEx.Node

  setup do
    node = %IotaEx.Node{name: "Test Node", url: "localhost", port: "200"}

    {:ok, node: node}
  end

  describe "struct" do
    test "valid params" do
      n = %Node{url: "http://localhost", name: "test-node", port: 80}

      assert n.url == "http://localhost"
      assert n.name == "test-node"
      assert n.port == 80
    end
  end
end
