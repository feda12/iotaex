defmodule IotaEx do
  @moduledoc """
  Documentation for IotaEx.
  """

  @http Application.get_env(:iota_ex, :http_adapter)

  @doc """
  Calls the HTTP adapter with the node information and
  the command merged with parameters.

  ## Examples

      iex> node = %IotaEx.Node{name: "Test", url: "localhost", port: "200"}
      iex> IotaEx.send_command(node, "")
      {:error, "'command' parameter has not been specified"}

      iex> node = %IotaEx.Node{name: "Test", url: "localhost", port: "200"}
      iex> IotaEx.send_command(node, nil)
      {:error, "'command' parameter has not been specified"}

  """
  @spec send_command(IotaEx.Node.t(), map()) :: {:ok, map()} | {:error, map()}
  def send_command(%IotaEx.Node{} = node, command, params \\ %{}) do
    @http.post(node, Map.merge(params, %{command: command}))
  end
end
