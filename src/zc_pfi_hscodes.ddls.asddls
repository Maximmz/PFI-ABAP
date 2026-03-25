@EndUserText.label: 'HS Codes - Projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_PFI_HSCODES
  as projection on ZR_PFI_HSCODES
{
  key HSCodeUUID,
      HSCode,
      Description
}
