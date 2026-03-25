@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Supplier Master'
define view entity ZR_PFI_SUPPLIERS
  as select from ZPFI_SUPPLIERS
{
  key supplier_uuid as SupplierUUID,
      name          as Name,
      country       as Country
}
