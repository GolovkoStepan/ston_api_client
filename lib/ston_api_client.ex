defmodule StonApiClient do
  @moduledoc """
  A client for working with the API of a decentralized automated market maker Ston.fi
  """

  alias StonApiClient.Asset

  @base_url "https://api.ston.fi/v1"

  @doc """
  Getting information about all assets
  """
  def assets do
    with {:ok, data} <- "#{@base_url}/assets" |> make_request() |> parse_body(),
         {:ok, assets_list} <- Map.fetch(data, :asset_list) do
      {
        :ok,
        Enum.map(assets_list, &struct(Asset, &1))
      }
    end
  end

  defp make_request(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, reason: :not_found}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason: reason}
    end
  end

  defp parse_body({:ok, body}) do
    case Jason.decode(body, keys: :atoms!) do
      {:ok, data} ->
        {:ok, data}

      {:error, reason} ->
        {:error, reason: reason}
    end
  end

  defp parse_body({:error, reason: reason}), do: {:error, reason: reason}
end
