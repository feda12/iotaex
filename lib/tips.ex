defmodule IotaEx.Tips do
  @doc """
  Returns the list of tips.

  ## Examples

      iex> node = %IotaEx.Node{name: "Test", url: "localhost", port: "200"}
      iex> IotaEx.Tips.get(node)
      {:ok,
       %{
         "hashes" => [
           "YVXJOEOP9JEPRQUVBPJMB9MGIB9OMTIJJLIUYPM9YBIWXPZ9PQCCGXYSLKQWKHBRVA9AKKKXXMXF99999",
           "ZUMARCWKZOZRMJM9EEYJQCGXLHWXPRTMNWPBRCAGSGQNRHKGRUCIYQDAEUUEBRDBNBYHAQSSFZZQW9999",
           "QLQECHDVQBMXKD9YYLBMGQLLIQ9PSOVDRLYCLLFMS9O99XIKCUHWAFWSTARYNCPAVIQIBTVJROOYZ9999"
         ],
         "duration" => 4
       }}
  """
  @spec get(IotaEx.Node.t()) :: {:ok, map()} | {:error, binary()}
  def get(%IotaEx.Node{} = node) do
    IotaEx.send_command(node, "getTips")
  end
end
