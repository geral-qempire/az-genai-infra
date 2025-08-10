# Region Abbreviations Module

Exposes a canonical map of Azure region names to short abbreviations.

## Usage

```hcl
module "region_abbreviations" {
  source = "../region-abbreviations"
}

locals {
  region_abbr = lookup(module.region_abbreviations.regions, var.location, null)
}
```

## Outputs

- `regions`: map(string) of Azure location names (both canonical and display formats) to abbreviations.


