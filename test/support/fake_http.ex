defmodule IotaEx.FakeHttp do
  @moduledoc """
  This is a FakeHttp module that we use to test our
  library.

  It reproduces responses to commands as
  we would expect from the IotaAPI.
  """

  def post(_, %{command: nil}) do
    {:error, "'command' parameter has not been specified"}
  end

  def post(_, %{command: ""}) do
    {:error, "'command' parameter has not been specified"}
  end

  def post(_, %{command: "getNodeInfo"}) do
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
  end

  def post(_, %{command: "getNeighbors"}) do
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
  end

  def post(_, %{command: "addNeighbors", uris: uris}) do
    {:ok, %{
      "addedNeighbors" => Enum.count(uris),
      "duration" => 2
    }}
  end

  def post(_, %{command: "removeNeighbors", uris: uris}) do
    {:ok, %{
      "removedNeighbors" => Enum.count(uris),
      "duration" => 2
    }}
  end
end
