# Running Tests

## Prerequisites

None are required to run the mock tests. To run against the live eBay API, export the following variables and set `IS_LIVE_SERVER` to `true`:

```bash
export IS_LIVE_SERVER=true
export EBAY_CLIENT_ID=<client-id>
export EBAY_CLIENT_SECRET=<client-secret>
export EBAY_REFRESH_TOKEN=<refresh-token>
export EBAY_MARKETPLACE_ID=EBAY_US
```

## Test environments

By default the tests run against a mock service on `http://localhost:9090` that starts with `bal test`. With `IS_LIVE_SERVER=true` the tests that carry the `live_tests` group call `https://api.ebay.com/sell/negotiation/v1`. The offer-sending test only runs against the mock, because it would send real offers to buyers.

## Running the tests

```bash
bal test                          # mock tests
bal test --groups live_tests      # live tests
```

## Test coverage

- `findEligibleItems` - lists the listings that are eligible for a seller-initiated offer.
- `sendOfferToInterestedBuyers` - sends an offer to the buyers interested in a listing.
