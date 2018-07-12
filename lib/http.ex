defmodule IotaEx.Http do
  @moduledoc """
  This is our Http layer.

  It consists of a single POST function
  that accept a URL endpoint and body
  data. It takes care of setting up the
  headers.
  """

  @spec post(IotaEx.Node.t(), map()) :: {:ok, map()} | {:error, binary()}
  def post(%IotaEx.Node{} = node, %{command: "interruptAttachingToTangle"}) do
    IotaEx.Node.full_url(node)
    |> HTTPotion.post()
    |> handle_response()
  end
  def post(%IotaEx.Node{} = node, data) do
    IotaEx.Node.full_url(node)
    |> HTTPotion.post(
      body: Poison.encode!(data),
      headers: [
        "Content-Type": "application/json",
        "X-IOTA-API-VERSION": "1"
      ]
    )
    |> handle_response()
  end

  @spec handle_response(map()) :: {:ok, map()} | {:error, binary()}
  defp handle_response(%HTTPotion.ErrorResponse{} = response) do
    {:error, response.message}
  end
  defp handle_response(%HTTPotion.Response{} = response) do
    {:ok, Poison.decode!(response.body)}
  end

end
