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
import ballerina/os;
import ballerina/test;

final boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
final string serviceUrl = isLiveServer ? "https://api.ebay.com/sell/negotiation/v1" : "http://localhost:9090";
final string clientId = isLiveServer ? os:getEnv("EBAY_CLIENT_ID") : "test_client_id";
final string clientSecret = isLiveServer ? os:getEnv("EBAY_CLIENT_SECRET") : "test_client_secret";
final string refreshToken = isLiveServer ? os:getEnv("EBAY_REFRESH_TOKEN") : "test_refresh_token";
final string marketplaceId = isLiveServer ? os:getEnv("EBAY_MARKETPLACE_ID") : "EBAY_US";

ConnectionConfig connectionConfig = isLiveServer ? {
    auth: {
        clientId,
        clientSecret,
        refreshToken
    }
} : {
    auth: {
        token: "test_token"
    },
    httpVersion: http:HTTP_1_1
};

final Client ebay = check new (connectionConfig, serviceUrl);

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testFindEligibleItems() returns error? {
    PagedEligibleItemCollection? response = check ebay->findEligibleItems({xEBAYCMARKETPLACEID: marketplaceId}, 'limit = "10", offset = "0");
    if response is () && isLiveServer {
        return;
    }
    test:assertTrue(response is PagedEligibleItemCollection && response?.eligibleItems !is ());
}

@test:Config {
    groups: ["mock_tests"],
    enable: !isLiveServer
}
isolated function testSendOfferToInterestedBuyers() returns error? {
    SendOffersRequest payload = {
        allowCounterOffer: true,
        message: "Special discount just for you",
        offerDuration: {unit: "DAY", value: 2},
        offeredItems: [{listingId: "110123456789", discountPercentage: "10", quantity: 1}]
    };
    SendOffersResponse response = check ebay->sendOfferToInterestedBuyers({xEBAYCMARKETPLACEID: marketplaceId, contentType: "application/json"}, payload);
    test:assertTrue(response?.offers !is ());
}
