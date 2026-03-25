@EndUserText.label: 'Currency - Projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_PFI_CURRENCIES
  as projection on ZR_PFI_CURRENCIES
{
  key CurrencyCode,
      Name
}
