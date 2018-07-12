defmodule IotaEx.Transactions do
  @doc """
  Find the transactions which match the specified input and return.
  All input values are lists, for which a list of return values (transaction hashes),
  in the same order, is returned for all individual elements. The input fields can
  either be bundles, addresses, tags or approvees. Using multiple of these input
  fields returns the intersection of the values.

    - bundles list  Optional  List of bundle hashes.
    - addresses list  Optional  List of addresses.
    - tags  list  Optional  List of tags. Has to be 27 trytes.
    - approvees list  Optional  List of approvee transaction hashes.

  ## Return Values
    The transaction hashes which are returned depend on your input. For each specified
    input value, the command will return the following:

    - bundles: returns the list of transactions which contain the specified bundle hash.
    - addresses: returns the list of transactions which have the specified address as an input/output field.
    - tags: returns the list of transactions which contain the specified tag value.
    - approvees: returns the list of transaction which reference (i.e. confirm) the specified transaction.

  ## Examples

    iex> node = %IotaEx.Node{name: "Test", url: "localhost", port: "200"}
    iex> params = %{addresses: ["RVORZ9SIIP9RCYMREUIXXVPQIPHVCNPQ9HZWYKFWYWZRE9JQKG9REPKIASHUUECPSQO9JT9XNMVKWYGVAZETAIRPTM"]}
    iex> IotaEx.Transactions.find(node, params)
    {:ok,
     %{"hashes" => ['ZJVYUGTDRPDYFGFXMKOTV9ZWSGFK9CFPXTITQLQNLPPG9YNAARMKNKYQO9GSCSBIOTGMLJUFLZWSY9999']}
    }
  """
  @spec find(IotaEx.Node.t(), map()) :: {:ok, map()} | {:error, binary()}
  def find(%IotaEx.Node{} = node, params) do
    IotaEx.send_command(node, "findTransactions", params)
  end

  @doc """
  Returns the raw transaction data (trytes) of a specific transaction.

  These trytes can then be easily converted into the actual transaction object.
  See utility functions for more details.

  Params:
  - hashes: List of transaction hashes of which you want to get trytes from.

  ## Examples

    iex> node = %IotaEx.Node{name: "Test", url: "localhost", port: "200"}
    iex> params = %{hashes: ["OAATQS9VQLSXCLDJVJJVYUGONXAXOFMJOZNS"]}
    iex> IotaEx.Transactions.trytes(node, params)
    {:ok,
      %{"trytes" => ['BYSWEAUTWXHXZ9YBZISEK9LUHWGMHXCGEVNZHRLUWQFCUSDXZHOFHWHL9MQ']}
    }
  """
  @spec trytes(IotaEx.Node.t(), map()) :: {:ok, map()} | {:error, binary()}
  def trytes(%IotaEx.Node{} = node, %{hashes: _} = params) do
    IotaEx.send_command(node, "getTrytes", params)
  end

  @doc """
  Get the inclusion states of a set of transactions.

  This is for determining if a transaction was accepted
  and confirmed by the network or not. You can search for
  multiple tips (and thus, milestones) to get past
  inclusion states of transactions.

  This API call simply returns a list of boolean values
  in the same order as the transaction list you submitted,
  thus you get a true/false whether a transaction is
  confirmed or not.

  Required params:
  - transactions: List of transactions you want to get the inclusion state for.
  - tips: List of tips (including milestones) you want to search for the inclusion state.

  ## Examples

    iex> node = %IotaEx.Node{name: "Test", url: "localhost", port: "200"}
    iex> params = %{transactions: ["QHBYXQWRAHQJZEIARWSQGZJTAIIT"], tips: ["ZIJGAJ9AADLRPWNCYNNHUHRRAC9QOUDAT"]}
    iex> IotaEx.Transactions.inclusion_states(node, params)
    {:ok, %{"states" => [true], "duration" => 91}}
  """
  @spec inclusion_states(IotaEx.Node.t(), map()) :: {:ok, map()} | {:error, binary()}
  def inclusion_states(%IotaEx.Node{} = node, %{transactions: _, tips: _} = params) do
    IotaEx.send_command(node, "getInclusionStates", params)
  end

  @doc """
  Tip selection which returns trunkTransaction and branchTransaction.

  The input value depth determines how many milestones to go back to
  for finding the transactions to approve. The higher your depth value,
  the more work you have to do as you are confirming more transactions.
  If the depth is too large (usually above 15, it depends on the node's
  configuration) an error will be returned. The reference is an optional
  hash of a transaction you want to approve. If it can't be found at the
  specified depth then an error will be returned.

  ## Params
  - depth: required - number of bundles to go back to determine the transactions for approval.
  - reference: optional - hash of transaction to start random-walk from, used to make sure the
      tips returned reference a given transaction in their past.

  ## Examples

    iex> node = %IotaEx.Node{name: "Test", url: "localhost", port: "200"}
    iex> params = %{depth: 15, reference: "TKGDZ9GEI9CPNQGHEATIIS"}
    iex> IotaEx.Transactions.to_approve(node, params)
    {:ok, %{"trunkTransaction" => "TKGDZ9GEI9CPN",
            "branchTransaction" => "TKGDZ9GEI9CPNQ",
            "duration" => 936}
    }
  """
  @spec to_approve(IotaEx.Node.t(), map()) :: {:ok, map()} | {:error, binary()}
  def to_approve(%IotaEx.Node{} = node, %{depth: _} = params) do
    IotaEx.send_command(node, "getTransactionsToApprove", params)
  end

  @doc """
  Store transactions into the local storage.
  The trytes to be used for this call are returned by attachToTangle.

  ## Params
  - trytes: required - list of raw data of transactions to be rebroadcast

  ## Examples

    iex> node = %IotaEx.Node{name: "Test", url: "localhost", port: "200"}
    iex> params = %{trytes: ["ABCDEF"]}
    iex> IotaEx.Transactions.store(node, params)
    {:ok, %{}}

  """
  @spec broadcast(IotaEx.Node.t(), map()) :: {:ok, map()} | {:error, binary()}
  def broadcast(%IotaEx.Node{} = node, %{trytes: _} = params) do
    IotaEx.send_command(node, "broadcastTransactions", params)
  end

  @doc """
  Store transactions into the local storage.
  The trytes to be used for this call are returned by attachToTangle.

  ## Params
  - trytes: required - list of raw data of transactions to be stored

  ## Examples

    iex> node = %IotaEx.Node{name: "Test", url: "localhost", port: "200"}
    iex> params = %{trytes: ["ABCDEF"]}
    iex> IotaEx.Transactions.broadcast(node, params)
    {:ok, %{}}

  """
  @spec store(IotaEx.Node.t(), map()) :: {:ok, map()} | {:error, binary()}
  def store(%IotaEx.Node{} = node, %{trytes: _} = params) do
    IotaEx.send_command(node, "storeTransactions", params)
  end

  @doc """
  Attaches the specified transactions (trytes) to the Tangle by doing Proof of Work.

  You need to supply branchTransaction as well as trunkTransaction (basically the tips
  which you're going to validate and reference with this transaction) - both of which
  you'll get through the getTransactionsToApprove API call.

  The returned value is a different set of tryte values which you can input into
  broadcastTransactions and storeTransactions. The returned tryte value, the last
  243 trytes basically consist of the: trunkTransaction + branchTransaction + nonce.
  These are valid trytes which are then accepted by the network.

  ## Params

  - trunkTransaction: required - trunk transaction to approve
  - branchTransaction: required - branch transaction to approve
  - minWeightMagnitude: required - proof of work intensity, minimum value is 18
  - trytes: required - list of trytes to attach to the tangle

  ## Examples

    iex> node = %IotaEx.Node{name: "Test", url: "localhost", port: "200"}
    iex> params = %{trunkTransaction: "JVMTDGDPDFYHMZ",
    iex>            branchTransaction: "P9KFSJVGSPLXAEBJSH",
    iex>            minWeightMagnitude: 18,
    iex>            trytes: ["TRYTEVALUEHERE"]}
    iex> IotaEx.Transactions.attach_to_tangle(node, params)
    {:ok, %{"trytes" => ["TRYTEVALUEHERE"]}}
  """
  @spec attach_to_tangle(IotaEx.Node.t(), map()) :: {:ok, map()} | {:error, binary()}
  def attach_to_tangle(%IotaEx.Node{} = node, %{trunkTransaction: _, branchTransaction: _, minWeightMagnitude: _, trytes: _} = params) do
    IotaEx.send_command(node, "attachToTangle", params)
  end

  @doc """
  Interrupts and completely aborts the attachToTangle process.

  ## Examples

    iex> node = %IotaEx.Node{url: "localhost"}
    iex> IotaEx.Transactions.interrupt_attach_to_tangle(node)
    {:ok, %{}}
  """
  @spec interrupt_attach_to_tangle(IotaEx.Node.t()) :: {:ok, map()} | {:error, binary()}
  def interrupt_attach_to_tangle(%IotaEx.Node{} = node) do
    IotaEx.send_command(node, "interruptAttachingToTangle")
  end
end
