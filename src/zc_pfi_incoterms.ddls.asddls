@EndUserText.label: 'Incoterms - Projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_PFI_INCOTERMS
  as projection on ZR_PFI_INCOTERMS
{
  key IncoTermCode,
      Description
}
