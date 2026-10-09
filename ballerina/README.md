## Overview

[eBay](https://www.ebay.com) is a global online marketplace where businesses and individuals buy and sell goods. The Negotiation API lets sellers proactively send discount offers to buyers who have shown interest in their listings, for example by adding a listing to their watch list or abandoning a shopping cart.

This connector provides a Ballerina client for version 1 of the eBay Negotiation API. It lets you find the listings that have interested buyers and send those buyers percentage or fixed-price discount offers.

### Key features

- Find the listings that are eligible for a seller-initiated offer, with pagination
- Send discount offers to the buyers who are interested in your listings
- Set the offer message, duration and whether buyers may counter-offer
- Authenticate with an eBay OAuth 2.0 user token or a refresh token grant

## Setup guide

To use the connector you need an eBay developer account and an OAuth 2.0 user token that is authorized for the `https://api.ebay.com/oauth/api_scope/sell.inventory` scope.

1. Sign up at the [eBay Developers Program](https://developer.ebay.com/) and create an application keyset in the Application Keys page.

2. Note the **App ID (Client ID)** and **Cert ID (Client Secret)** of the production keyset.

3. Configure the OAuth redirect (RuNo) for your application under **User Tokens** and grant the `https://api.ebay.com/oauth/api_scope/sell.inventory` scope.

4. Complete the consent flow as the seller and exchange the authorization code at `https://api.ebay.com/identity/v1/oauth2/token` to obtain a refresh token.

5. Keep the client ID, client secret and refresh token available for the `Config.toml` file.

## Quickstart

To use the `ebay.negotiation` connector in your Ballerina application, update the `.bal` file as follows.

### Step 1: Import the module

```ballerina
import ballerinax/ebay.negotiation;
```

### Step 2: Instantiate a new connector

Create a `Config.toml` file with your credentials.

```toml
clientId = "<client-id>"
clientSecret = "<client-secret>"
refreshToken = "<refresh-token>"
```

Then create a `negotiation:Client` using them.

```ballerina
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;

negotiation:Client ebay = check new ({
    auth: {
        clientId,
        clientSecret,
        refreshToken
    }
});
```

### Step 3: Invoke the connector operation

Find the listings that are eligible for an offer.

```ballerina
public function main() returns error? {
    negotiation:PagedEligibleItemCollection? _ = check ebay->findEligibleItems({xEBAYCMARKETPLACEID: "EBAY_US"});
}
```

### Step 4: Run the Ballerina application

```bash
bal run
```

## Examples

The `eBay Negotiation` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-ebay.negotiation/tree/main/examples/), covering the following use cases:

1. [Eligible listings report](https://github.com/ballerina-platform/module-ballerinax-ebay.negotiation/tree/main/examples/eligible_listings_report) - Page through every listing that has interested buyers and print its ID.
2. [Seller discount campaign](https://github.com/ballerina-platform/module-ballerinax-ebay.negotiation/tree/main/examples/seller_discount_campaign) - Find eligible listings and optionally send their interested buyers a percentage discount offer.
