@EndUserText.label: 'Rate Type - Projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_PFI_RATETYPES
  as projection on ZR_PFI_RATETYPES
{
  key RateTypeCode,
      Description
}
