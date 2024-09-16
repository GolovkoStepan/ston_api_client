defmodule StonApiClient.Asset do
  defstruct balance: nil,
            blacklisted: false,
            community: false,
            contract_address: nil,
            decimals: nil,
            default_symbol: false,
            deprecated: false,
            dex_price_usd: nil,
            display_name: nil,
            image_url: nil,
            kind: nil,
            priority: nil,
            symbol: nil,
            third_party_price_usd: nil,
            wallet_address: nil
end
