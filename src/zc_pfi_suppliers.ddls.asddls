@EndUserText.label: 'Supplier - Projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_PFI_SUPPLIERS
  as projection on ZR_PFI_SUPPLIERS
{
  key SupplierUUID,
      Name,
      Country
}
