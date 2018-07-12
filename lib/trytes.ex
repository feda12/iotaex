defmodule IotaEx.Trytes do
  @moduledoc """
  This module implements multiple functions to deal
  with trytes, whether that's encoding/decoding.
  """

  @trytes String.graphemes("9ABCDEFGHIJKLMNOPQRSTUVWXYZ")

  @doc """
  Converts a string of ASCII characters into a string of trytes.

  ## Examples

       iex> Trytes.from_binary("Z")
       {:ok, "IC"}

       iex> Trytes.from_binary("hi")
       {:ok, "WCXC"}

       iex> Trytes.from_binary(123)
       {:error, "invalid-param"}

       iex> Trytes.from_binary("Säφę")
       {:error, "invalid-characters"}

       iex> Trytes.from_binary("雪หิ🌲☃")
       {:error, "invalid-characters"}

  """
  @spec from_binary(binary()) :: binary()
  def from_binary(bin) when is_binary(bin) do
    bin
    |> to_charlist()
    |> to_trytes()
    |> stringify()
  end
  def from_binary(_) do
    {:error, "invalid-param"}
  end

  @doc """
  Converts a list of strings to a string.

  Error message states "invalid-characters"
  should the list be nil.

  ## Examples

      iex> IotaEx.Trytes.stringify(nil)
      {:error, "invalid-characters"}

      iex> IotaEx.Trytes.stringify(["a", "b"])
      {:ok, "ab"}
  """
  @spec stringify(list() | nil) :: {:ok, binary()} | {:error, binary()}
  def stringify(nil) do
    {:error, "invalid-characters"}
  end
  def stringify(list) when is_list(list) do
    {:ok, Enum.join(list)}
  end


  @doc """
  Converts a string of trytes to an ASCII string.

  ## Examples

      iex> Trytes.to_binary("IC")
      {:ok, "Z"}

      iex> Trytes.to_binary("WCXC")
      {:ok, "hi"}

      iex> Trytes.to_binary(123)
      {:error, "invalid-param"}

  """
  @spec to_binary(binary()) :: binary()
  def to_binary(tryt) when is_binary(tryt) do
    if rem(String.length(tryt), 2) == 0 do
      tryt
      |> String.split("", trim: true)
      |> from_trytes()
    else
      {:error, "invalid-param"}
    end
  end
  def to_binary(_) do
    {:error, "invalid-param"}
  end

  @spec from_trytes(list()) :: binary()
  defp from_trytes(trytes) when is_list(trytes) do
    from_trytes(trytes, "")
  end

  defp from_trytes([], output) do
    {:ok, output}
  end
  defp from_trytes([head1, head2 | tail], output) do
    val1 = Enum.find_index(@trytes, &(&1 == head1))
    val2 = Enum.find_index(@trytes, &(&1 == head2))

    decimal_val = val1 + val2 * 27

    str_char = to_string([decimal_val])

    from_trytes(tail, output <> str_char)
  end

  @spec to_trytes(charlist()) :: (charlist())
  defp to_trytes(charlist) do
    to_trytes(charlist, [])
  end
  defp to_trytes([], trytes) do
    trytes
  end
  defp to_trytes([head | _], _trytes) when head > 255 do
    nil
  end
  defp to_trytes([head | tail], trytes) do
    val1 = rem(head, 27)
    val2 = Kernel.trunc((head - val1) / 27)

    tryte = Enum.at(@trytes, val1) <> Enum.at(@trytes, val2)

    to_trytes(tail, trytes ++ [tryte])
  end
end
