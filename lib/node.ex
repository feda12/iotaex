defmodule IotaEx.Node do
  @moduledoc """
  This struct represents a node in your network.

  This allows the ability to support multiple nodes and to communicate
  with multiple of them.

  An IotaEx.Node has the following attributes:
  - url: URL to the server node
  - port: port of the server to be called
  - name: a descriptive string used to identify
  the node across manny
  """

  @type t :: %__MODULE__{
    url: String.t(),
    port: String.t(),
    name: String.t()
  }
  @enforce_keys [:url]

  defstruct [:name, :url, port: "14265"]

  @doc """
  Returns information about your node.

  Return Values
   - appName: Name of the IOTA software you're currently using (IRI stands for Initial Reference Implementation).
   - appVersion: The version of the IOTA software you're currently running.
   - jreAvailableProcesses: Available cores on your machine for JRE.
   - jreFreeMemory: Returns the amount of free memory in the Java Virtual Machine.
   - jreMaxMemory: Returns the maximum amount of memory that the Java virtual machine will attempt to use.
   - jreTotalMemory: Returns the total amount of memory in the Java virtual machine.
   - latestMilestone: Latest milestone that was signed off by the coordinator.
   - latestMilestoneIndex: Index of the latest milestone.
   - latestSolidSubtangleMilestone: The latest milestone which is solid and is used for sending transactions. For a milestone to become solid your local node must basically approve the subtangle of coordinator-approved transactions, and have a consistent view of all referenced transactions.
   - latestSolidSubtangleMilestoneIndex: Index of the latest solid subtangle.
   - neighbors: Number of neighbors you are directly connected with.
   - packetsQueueSize: Packets which are currently queued up.
   - time: Current UNIX timestamp.
   - tips: Number of tips in the network.
   - transactionsToRequest: Transactions to request during syncing process.

  ## Examples

      iex> node = %IotaEx.Node{name: "Test", url: "localhost", port: "200"}
      iex> IotaEx.Node.info(node)
      {:ok,
       %{
         "appName" => "IRI",
         "appVersion" => "1.0.8.nu",
         "duration" => 1,
         "jreAvailableProcessors" => 4,
         "jreFreeMemory" => 91_707_424,
         "jreMaxMemory" => 1_908_932_608,
         "jreTotalMemory" => 122_683_392,
         "latestMilestone" =>
           "VBVEUQYE99LFWHDZRFKTGFHYGDFEAMAEBGUBTTJRFKHCFBRTXFAJQ9XIUEZQCJOQTZNOOHKUQIKOY9999",
         "latestMilestoneIndex" => 107,
         "latestSolidSubtangleMilestone" =>
           "VBVEUQYE99LFWHDZRFKTGFHYGDFEAMAEBGUBTTJRFKHCFBRTXFAJQ9XIUEZQCJOQTZNOOHKUQIKOY9999",
         "latestSolidSubtangleMilestoneIndex" => 107,
         "neighbors" => 2,
         "packetsQueueSize" => 0,
         "time" => 1_477_037_811_737,
         "tips" => 3,
         "transactionsToRequest" => 0
       }}
  """
  @spec info(IotaEx.Node.t()) :: {:ok, map()} | {:error, binary()}
  def info(%IotaEx.Node{} = node) do
    IotaEx.send_command(node, "getNodeInfo")
  end

  # defmodule Info do
  #   defstruct [
  #     :appName,
  #     :appVersion,
  #     :duration,
  #     :jreAvailableProcessors,
  #     :jreFreeMemory,
  #     :jreMaxMemory,
  #     :jreTotalMemory,
  #     :latestMilestone,
  #     :latestMilestoneIndex,
  #     :latestSolidSubtangleMilestone,
  #     :latestSolidSubtangleMilestoneIndex,
  #     :neighbors,
  #     :packetsQueueSize,
  #     :time,
  #     :tips,
  #     :transactionsToRequest
  #   ]
  # end

  @doc """
  Returns the full URL to the node.

  ## Examples

      iex> node = %IotaEx.Node{url: "localhost", port: "123"}
      iex> IotaEx.Node.full_url(node)
      "localhost:123"

      iex> node = %IotaEx.Node{url: "localhost", port: "345"}
      iex> IotaEx.Node.full_url(node)
      "localhost:345"

      iex> node = %IotaEx.Node{url: "localhost"}
      iex> IotaEx.Node.full_url(node)
      "localhost:14265"
  """
  @spec full_url(IotaEx.Node.t()) :: binary()
  def full_url(%IotaEx.Node{} = node) do
    node.url <> ":" <> node.port
  end
end
