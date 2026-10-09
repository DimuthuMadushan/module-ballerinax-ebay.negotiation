// Lists every eBay listing that has interested buyers and is eligible for a seller-initiated offer.

import ballerina/io;
import ballerinax/ebay.negotiation;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string refreshUrl = ?;
configurable string marketplaceId = "EBAY_US";
configurable int pageSize = 50;

public function main() returns error? {
    if pageSize < 1 || pageSize > 200 {
        return error(string `pageSize must be between 1 and 200, but was ${pageSize}`);
    }
    negotiation:Client ebay = check new ({
        auth: {
            clientId,
            clientSecret,
            refreshToken,
            refreshUrl
        }
    });

    string[] listingIds = [];
    int offset = 0;
    while true {
        negotiation:PagedEligibleItemCollection? page = check ebay->findEligibleItems(
            {xEBAYCMARKETPLACEID: marketplaceId}, 'limit = pageSize.toString(), offset = offset.toString());
        if page is () {
            break;
        }
        negotiation:EligibleItem[] items = page?.eligibleItems ?: [];
        foreach negotiation:EligibleItem item in items {
            string? listingId = item?.listingId;
            if listingId is string {
                listingIds.push(listingId);
            }
        }
        if items.length() < pageSize {
            break;
        }
        offset += pageSize;
    }

    io:println(string `Found ${listingIds.length()} eligible listing(s) on ${marketplaceId}`);
    foreach string listingId in listingIds {
        io:println("Eligible listing: ", listingId);
    }
}
