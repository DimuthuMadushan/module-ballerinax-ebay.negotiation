# Eligible listings report

This example pages through every eBay listing that has interested buyers and prints the IDs of the listings eligible for a seller-initiated offer.

## Prerequisites

1. An eBay developer application with a user refresh token that includes the `https://api.ebay.com/oauth/api_scope/sell.inventory` scope.
2. Ballerina Swan Lake installed.

## Configuration

Create a `Config.toml` file in the example directory.

```toml
clientId = "<client-id>"
clientSecret = "<client-secret>"
refreshToken = "<refresh-token>"
refreshUrl = "<oauth-token-url>"
marketplaceId = "EBAY_US"
pageSize = 50
```

## Run the example

```bash
bal run
```
