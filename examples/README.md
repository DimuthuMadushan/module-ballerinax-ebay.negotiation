# Examples

The `ballerinax/ebay.negotiation` connector provides practical examples illustrating usage in various scenarios.

1. [Eligible listings report](./eligible_listings_report/eligible_listings_report.md) - Page through every listing that has interested buyers and print its ID.
2. [Seller discount campaign](./seller_discount_campaign/seller_discount_campaign.md) - Find eligible listings and optionally send their interested buyers a percentage discount offer.

## Prerequisites

1. Create an eBay developer application and obtain the client ID, client secret and a refresh token authorized for the `https://api.ebay.com/oauth/api_scope/sell.inventory` scope.

2. For each example, create a `Config.toml` file in the example directory with the values documented in the example's own README.

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
