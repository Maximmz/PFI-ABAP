@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Incoterms Master'
define view entity ZR_PFI_INCOTERMS
  as select from ZPFI_INCOTERMS
{
  key incoterm_code as IncoTermCode,
      description   as Description
}
