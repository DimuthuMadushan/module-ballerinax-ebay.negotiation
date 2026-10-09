# Seller discount campaign

This example finds listings that have interested buyers and, when enabled, sends those buyers a percentage discount offer.

## Prerequisites

1. An eBay developer application with a user refresh token that includes the `https://api.ebay.com/oauth/api_scope/sell.inventory` scope.
2. Ballerina Swan Lake installed.

## Configuration

Create a `Config.toml` file in the example directory. Offers are only sent when `sendOffers` is `true`.

```toml
clientId = "<client-id>"
clientSecret = "<client-secret>"
refreshToken = "<refresh-token>"
refreshUrl = "<oauth-token-url>"
marketplaceId = "EBAY_US"
discountPercentage = "10"
offerDurationDays = 2
offerMessage = "<message-to-buyers>"
sendOffers = false
```

## Run the example

```bash
bal run
```
