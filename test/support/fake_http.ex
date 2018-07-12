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
    {:ok,
     %{
       "addedNeighbors" => Enum.count(uris),
       "duration" => 2
     }}
  end

  def post(_, %{command: "removeNeighbors", uris: uris}) do
    {:ok,
     %{
       "removedNeighbors" => Enum.count(uris),
       "duration" => 2
     }}
  end

  def post(_, %{command: "getTips"}) do
    {:ok,
     %{
       "hashes" => [
         "YVXJOEOP9JEPRQUVBPJMB9MGIB9OMTIJJLIUYPM9YBIWXPZ9PQCCGXYSLKQWKHBRVA9AKKKXXMXF99999",
         "ZUMARCWKZOZRMJM9EEYJQCGXLHWXPRTMNWPBRCAGSGQNRHKGRUCIYQDAEUUEBRDBNBYHAQSSFZZQW9999",
         "QLQECHDVQBMXKD9YYLBMGQLLIQ9PSOVDRLYCLLFMS9O99XIKCUHWAFWSTARYNCPAVIQIBTVJROOYZ9999"
       ],
       "duration" => 4
     }}
  end

  def post(_, %{command: "findTransactions", addresses: ["RVORZ9SIIP9RCYMREUIXXVPQIPHVCNPQ9HZWYKFWYWZRE9JQKG9REPKIASHUUECPSQO9JT9XNMVKWYGVAZETAIRPTM"]}) do
    {:ok,
     %{
       "hashes" => [
         'ZJVYUGTDRPDYFGFXMKOTV9ZWSGFK9CFPXTITQLQNLPPG9YNAARMKNKYQO9GSCSBIOTGMLJUFLZWSY9999'
       ]
     }}
  end

  def post(_, %{command: "getTrytes", hashes: ["OAATQS9VQLSXCLDJVJJVYUGONXAXOFMJOZNS"]}) do
    {:ok,
      %{
        "trytes" => [
          'BYSWEAUTWXHXZ9YBZISEK9LUHWGMHXCGEVNZHRLUWQFCUSDXZHOFHWHL9MQ'
        ]
    }}
  end

  def post(_, %{command: "getInclusionStates", transactions: ["QHBYXQWRAHQJZEIARWSQGZJTAIIT"], tips: ["ZIJGAJ9AADLRPWNCYNNHUHRRAC9QOUDAT"]}) do
    {:ok,
      %{
        "states" => [true],
        "duration" => 91
    }}
  end

  def post(_, %{command: "getBalances", addresses: ["HBBYKAKTILIPVUKFOTSLHGENPTXYBNKXZFQ"], threshold: 100}) do
    {:ok, %{
        "balances" => [
          "114544444"
        ],
        "duration" => 30,
        "references" => ["INRTUYSZCWBHGFGGXXPWRWBZACYAFGVRRP9VYEQJOHYD9URMELKWAFYFMNTSP9MCHLXRGAFMBOZPZ9999"],
        "milestoneIndex" => 128
      }
    }
  end

  def post(_, %{command: "getTransactionsToApprove", depth: 15, reference: "TKGDZ9GEI9CPNQGHEATIIS"}) do
    {:ok,
      %{"trunkTransaction" => "TKGDZ9GEI9CPN",
        "branchTransaction" => "TKGDZ9GEI9CPNQ",
        "duration" => 936
    }}
  end

  def post(_, %{command: "attachToTangle", minWeightMagnitude: 18, trunkTransaction: "JVMTDGDPDFYHMZ", branchTransaction: "P9KFSJVGSPLXAEBJSH", trytes: ["TRYTEVALUEHERE"]}) do
      {:ok, %{"trytes" => ["TRYTEVALUEHERE"]}}
  end

  def post(_, %{command: "broadcastTransactions", trytes: ["ABCDEF"]}) do
    {:ok, %{}}
  end

  def post(_, %{command: "storeTransactions", trytes: ["ABCDEF"]}) do
    {:ok, %{}}
  end

  def post(_, %{command: "wereAddressesSpentFrom", addresses: ["ABCDEF"]}) do
    {:ok, %{"states" => [true], "duration" => 1}}
  end

  def post(_, %{command: "interruptAttachingToTangle"}) do
    {:ok, %{}}
  end

  # def post(_, %{command: "", ) do
  #   {:ok,
  #     %{
  #
  #   }}
  # end
end
