@EndUserText.label: 'Product Models - Projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_PFI_MODELS
  as projection on ZR_PFI_MODELS
{
  key ModelUUID,
      ModelID,
      Name,
      Description
}
