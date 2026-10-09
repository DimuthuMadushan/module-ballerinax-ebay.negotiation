// Finds listings with interested buyers and optionally sends them a percentage discount offer.

import ballerina/io;
import ballerinax/ebay.negotiation;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string refreshUrl = ?;
configurable string marketplaceId = "EBAY_US";
configurable string discountPercentage = "10";
configurable int offerDurationDays = 2;
configurable string offerMessage = ?;
configurable boolean sendOffers = false;

public function main() returns error? {
    if offerDurationDays <= 0 || offerDurationDays > int:SIGNED32_MAX_VALUE {
        return error(string `offerDurationDays must be a positive 32-bit integer, but was ${offerDurationDays}`);
    }
    negotiation:Client ebay = check new ({
        auth: {
            clientId,
            clientSecret,
            refreshToken,
            refreshUrl
        }
    });

    negotiation:PagedEligibleItemCollection? eligible = check ebay->findEligibleItems({xEBAYCMARKETPLACEID: marketplaceId});
    if eligible is () {
        io:println("No listings with interested buyers were found");
        return;
    }

    negotiation:OfferedItem[] offeredItems = [];
    foreach negotiation:EligibleItem item in eligible?.eligibleItems ?: [] {
        string? listingId = item?.listingId;
        if listingId is string {
            offeredItems.push({listingId, discountPercentage, quantity: 1});
        }
    }
    io:println(string `${offeredItems.length()} listing(s) are eligible for a ${discountPercentage}% offer`);

    if !sendOffers {
        io:println("sendOffers is false; no offers were sent");
        return;
    }
    if offeredItems.length() == 0 {
        return;
    }

    // The API accepts exactly one listing per request, so each offer is sent separately.
    foreach negotiation:OfferedItem offeredItem in offeredItems {
        negotiation:SendOffersResponse response = check ebay->sendOfferToInterestedBuyers(
            {xEBAYCMARKETPLACEID: marketplaceId, contentType: "application/json"},
            {
                allowCounterOffer: false,
                message: offerMessage,
                offerDuration: {unit: "DAY", value: <int:Signed32>offerDurationDays},
                offeredItems: [offeredItem]
            });
        foreach negotiation:Offer offer in response?.offers ?: [] {
            io:println(string `Offer ${offer?.offerId ?: "unknown"} status: ${offer?.offerStatus ?: "unknown"}`);
        }
    }
}
