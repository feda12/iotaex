defmodule IotaEx.Neighbors do
  @doc """
  Returns the set of neighbors you are connected with, as well
  as their activity count. The activity counter is reset after
  restarting IRI.

  Return Values
   - address : address of your peer
   - numberOfAllTransactions: Number of all transactions sent
      (invalid, valid, already-seen)
   - numberOfInvalidTransactions: Invalid transactions your peer has
      sent you. These are transactions with invalid signatures or overall schema.
   - numberOfNewTransactions: New transactions which were transmitted.

  ## Examples

    iex> node = %IotaEx.Node{name: "Test", url: "localhost", port: "200"}
    iex> IotaEx.Neighbors.get(node)
    {:ok,
     %{
       "duration" => 37,
       "neighbors" => [
         %{
           "address" => "/8.8.8.8:14265",
           "numberOfAllTransactions" => 922,
           "numberOfInvalidTransactions" => 0,
           "numberOfNewTransactions" => 92
         },
         %{
           "address" => "/8.8.8.8:5000",
           "numberOfAllTransactions" => 925,
           "numberOfInvalidTransactions" => 0,
           "numberOfNewTransactions" => 20
         }
       ]
     }}
  """
  @spec get(IotaEx.Node.t()) :: {:ok, map()} | {:error, binary()}
  def get(%IotaEx.Node{} = node) do
    IotaEx.send_command(node, "getNeighbors")
  end

  @doc """
  Add a list of neighbors to your node. It should be noted that this
  is only temporary, and the added neighbors will be removed from
  your set of neighbors after you relaunch IRI.

  The URI (Unique Resource Identification) for adding neighbors is:
  udp://IPADDRESS:PORT

  ## Examples

    iex> node = %IotaEx.Node{name: "Test", url: "localhost", port: "200"}
    iex> new_neighbors = ["udp://localhost:201", "udp://localhost:202"]
    iex> IotaEx.Neighbors.add(node, new_neighbors)
    {:ok, %{
      "addedNeighbors" => 2,
      "duration" => 2
      }
    }
  """
  @spec add(IotaEx.Node.t(), list()) :: {:ok, map()} | {:error, binary()}
  def add(%IotaEx.Node{} = node, uris) do
    IotaEx.send_command(node, "addNeighbors", %{uris: uris})
  end

  @doc """
  Removes a list of neighbors to your node. This is only temporary,
  and if you have your neighbors added via the command line, they
  will be retained after you restart your node.

  The URI (Unique Resource Identification) for adding neighbors is:
  udp://IPADDRESS:PORT

  ## Examples

    iex> node = %IotaEx.Node{name: "Test", url: "localhost", port: "200"}
    iex> remove_neighbors = ["udp://localhost:201", "udp://localhost:202"]
    iex> IotaEx.Neighbors.remove(node, remove_neighbors)
    {:ok, %{
      "removedNeighbors" => 2,
      "duration" => 2
      }
    }
  """
  @spec remove(IotaEx.Node.t(), list()) :: {:ok, map()} | {:error, binary()}
  def remove(%IotaEx.Node{} = node, uris) do
    IotaEx.send_command(node, "removeNeighbors", %{uris: uris})
  end
end
