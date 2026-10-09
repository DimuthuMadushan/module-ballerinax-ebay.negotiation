# Ballerina eBay Negotiation connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-ebay.negotiation/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-ebay.negotiation/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-ebay.negotiation.svg)](https://github.com/ballerina-platform/module-ballerinax-ebay.negotiation/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/ebay.negotiation.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%ebay.negotiation)

## Overview

[eBay](https://www.ebay.com) is a global online marketplace where businesses and individuals buy and sell goods. The Negotiation API lets sellers proactively send discount offers to buyers who have shown interest in their listings, for example by adding a listing to their watch list or abandoning a shopping cart.

This connector provides a Ballerina client for version 1 of the eBay Negotiation API. It lets you find the listings that have interested buyers and send those buyers percentage or fixed-price discount offers.

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

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`ebay.negotiation` package](https://central.ballerina.io/ballerinax/ebay.negotiation/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
