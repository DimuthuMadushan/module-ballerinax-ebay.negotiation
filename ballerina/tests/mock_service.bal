// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;

listener http:Listener ep0 = new (9090);

@http:ServiceConfig {treatNilableAsOptional: true}
service / on ep0 {
    # Find eligible items for seller offers
    #
    # + 'limit - Maximum number of items to return on a page
    # + offset - Number of results to skip before returning the first result
    # + xEBAYCMARKETPLACEID - The eBay marketplace on which to search for eligible listings
    # + return - returns can be any of following types
    # http:Ok (Success)
    # http:NoContent (No Content)
    # http:BadRequest (Bad Request)
    # http:InternalServerError (Internal Server Error)
    resource function get find_eligible_items(string? 'limit, string? offset, @http:Header {name: "X-EBAY-C-MARKETPLACE-ID"} string xEBAYCMARKETPLACEID) returns PagedEligibleItemCollection|http:NoContent|http:BadRequest|http:InternalServerError {
        return {
            href: "https://api.ebay.com/sell/negotiation/v1/find_eligible_items?limit=10&offset=0",
            total: 2,
            offset: 0,
            'limit: 10,
            eligibleItems: [
                {listingId: "110123456789"},
                {listingId: "110987654321"}
            ]
        };
    }

    # Send offers to interested buyers
    #
    # + xEBAYCMARKETPLACEID - The eBay marketplace on which the listings appear
    # + contentType - Format of the request body
    # + payload - Send offer to eligible items request
    # + return - returns can be any of following types
    # http:Ok (Success)
    # http:BadRequest (Bad Request)
    # http:Conflict (Conflict)
    # http:InternalServerError (Internal Server Error)
    resource function post send_offer_to_interested_buyers(@http:Header {name: "X-EBAY-C-MARKETPLACE-ID"} string xEBAYCMARKETPLACEID, @http:Header {name: "Content-Type"} string contentType, @http:Payload SendOffersRequest payload) returns SendOffersResponse|http:BadRequest|http:Conflict|http:InternalServerError {
        OfferedItem[] items = payload.offeredItems ?: [];
        return {
            offers: [
                {
                    offerId: "5000000012345",
                    offerType: "SELLER_INITIATED",
                    offerStatus: "PENDING",
                    initiatedBy: "SELLER",
                    allowCounterOffer: payload.allowCounterOffer ?: false,
                    message: payload.message ?: "Special discount just for you",
                    creationDate: "2026-10-01T10:15:30.000Z",
                    lastModifiedDate: "2026-10-01T10:15:30.000Z",
                    revision: "1",
                    offeredItems: items,
                    offerDuration: payload.offerDuration ?: {unit: "DAY", value: 2},
                    buyer: {maskedUsername: "b***r"}
                }
            ]
        };
    }
}
