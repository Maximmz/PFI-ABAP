@EndUserText.label: 'Payment Terms - Projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_PFI_PAYTERMS
  as projection on ZR_PFI_PAYTERMS
{
  key PayTermCode,
      Description
}
