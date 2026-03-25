@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Payment Terms Master'
define view entity ZR_PFI_PAYTERMS
  as select from ZPFI_PAYTERMS
{
  key payterm_code as PayTermCode,
      description  as Description
}
