defmodule IotaEx.Addresses do
  @doc """
  Returns the confirmed balance, as viewed by tips,
  in case tips is not supplied, the balance is
  based on the latest confirmed milestone.

  In addition to the balances, it also returns the
  referencing tips (or milestone), as well as the
  index with which the confirmed balance was determined.

  The balances is returned as a list in the same order
  as the addresses were provided as input.

  ## Params

  - addresses: required - list of addresses you want to get the confirmed balance from
  - threshold: required - confirmation threshold, should be set to 100.
  - tips: list of hashes, if present calculate the balance of addresses
      from the PoV of these transactions, can be used to chain bundles.

  ## Examples

      iex> node = %IotaEx.Node{name: "Test", url: "localhost", port: "200"}
      iex> params = %{addresses: ["HBBYKAKTILIPVUKFOTSLHGENPTXYBNKXZFQ"], threshold: 100}
      iex> IotaEx.Addresses.balances(node, params)
      {:ok, %{
          "balances" => [
            "114544444"
          ],
          "duration" => 30,
          "references" => ["INRTUYSZCWBHGFGGXXPWRWBZACYAFGVRRP9VYEQJOHYD9URMELKWAFYFMNTSP9MCHLXRGAFMBOZPZ9999"],
          "milestoneIndex" => 128
        }
      }
  """
  @spec balances(IotaEx.Node.t(), map()) :: {:ok, map()} | {:error, binary()}
  def balances(%IotaEx.Node{} = node, %{addresses: _, threshold: _} = params) do
    IotaEx.send_command(node, "getBalances", params)
  end

  @doc """
  Check if a list of addresses was ever spent from, in the current epoch, or in previous epochs.

  ## Params
  - addresses : required - list of addresses to check if they were ever spent from.

  ## Examples

      iex> node = %IotaEx.Node{name: "Test", url: "localhost", port: "200"}
      iex> params = %{addresses: ["ABCDEF"]}
      iex> IotaEx.Addresses.spent_from(node, params)
      {:ok, %{"states" => [true], "duration" => 1}}

  """
  @spec spent_from(IotaEx.Node.t(), map()) :: {:ok, map()} | {:error, binary()}
  def spent_from(%IotaEx.Node{} = node, %{addresses: _} = params) do
    IotaEx.send_command(node, "wereAddressesSpentFrom", params)
  end
end
