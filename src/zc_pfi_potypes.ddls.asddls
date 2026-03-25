@EndUserText.label: 'PO Type - Projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_PFI_POTYPES
  as projection on ZR_PFI_POTYPES
{
  key POTypeCode,
      Description
}
