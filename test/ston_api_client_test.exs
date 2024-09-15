defmodule StonApiClientTest do
  use ExUnit.Case, async: false

  import Mock

  describe "assets" do
    @assets %{
      asset_list: [
        %{
          contract_address: "EQAvlWFDxGF2lXm67y4yzC17wYKD9A0guwPkMs1",
          decimals: 9,
          default_symbol: true,
          deprecated: true,
          kind: "kind",
          priority: 2,
          symbol: "GJKDG",
          blacklisted: false,
          community: true,
          balance: 2.3,
          dex_price_usd: 5.3,
          display_name: "Token",
          image_url: nil,
          third_party_price_usd: nil,
          wallet_address: nil
        }
      ]
    }

    @response_mock %HTTPoison.Response{status_code: 200, body: Jason.encode!(@assets)}

    test_with_mock "get assets", HTTPoison, get: fn _url -> {:ok, @response_mock} end do
      {:ok, assets_list} = StonApiClient.assets()
      asset_struct = List.first(assets_list)

      assert Map.from_struct(asset_struct) == @assets |> Map.fetch!(:asset_list) |> List.first()
    end
  end
end
