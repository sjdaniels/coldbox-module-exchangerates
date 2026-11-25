# ExchangeRates ColdBox Module

A ColdBox module for retrieving currency exchange rates through ExchangeRate-API.

## Installation

Install the module with CommandBox:

```bash
box install exchangerates
```

Configure your ExchangeRate-API key in the ColdBox `exchangerateapi` settings:

```cfc
exchangerateapi = {
    apiKey = "your-api-key"
};
```

## Usage

Inject the registered `ExchangeRates` model and call `exchange()`:

```cfc
var convertedAmount = exchangeRates.exchange(
    amount = 100,
    from   = "USD",
    to     = "EUR"
);
```

The method returns the numeric converted amount and throws an error when the API rejects the request or returns an invalid response.
