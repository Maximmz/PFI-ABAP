@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Currency Master'
define view entity ZR_PFI_CURRENCIES
  as select from ZPFI_CURRENCIES
{
  key currency_code as CurrencyCode,
      name          as Name
}
