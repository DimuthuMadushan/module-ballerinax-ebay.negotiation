_Author_:  @DimuthuMadushan \
_Created_: 2026/10/09 \
_Updated_: 2026/10/09 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from eBay Negotiation. 
The OpenAPI specification is obtained from [wso2/api-specs](https://github.com/wso2/api-specs/blob/main/openapi/ebay/negotiation/v1/openapi.json).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. Added missing operation summaries to the original spec (`docs/spec/openapi.json`), because the operations had none:
   - `GET /find_eligible_items` (`findEligibleItems`): "Find eligible items for seller offers"
   - `POST /send_offer_to_interested_buyers` (`sendOfferToInterestedBuyers`): "Send offers to interested buyers"

2. Renamed schemas through the generation skill's stable-name mapping (`docs/spec/ai-mappings.json`), applied to the aligned spec:
   - `CreateOffersRequest` to `SendOffersRequest`
   - `SendOfferToInterestedBuyersCollectionResponse` to `SendOffersResponse`

   The operation IDs `findEligibleItems` and `sendOfferToInterestedBuyers` are kept unchanged.

3. Replaced the generic `Success` description of the `200` responses in the original spec:
   - `GET /find_eligible_items`: "A page of listings that are eligible for a seller-initiated offer"
   - `POST /send_offer_to_interested_buyers`: "The offers that were sent to the interested buyers"

4. Replaced the templated server URL `https://api.ebay.com{basePath}` (variable `basePath`, default `/sell/negotiation/v1`) in the original spec with the concrete service root `https://api.ebay.com/sell/negotiation/v1`, and removed the `variables` block, so that the client's default `serviceUrl` matches the spec.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/aligned_ballerina_openapi.json -o ballerina --mode client --license docs/license.txt --client-methods remote
```

Note: The license year is hardcoded to 2026, change if necessary.
