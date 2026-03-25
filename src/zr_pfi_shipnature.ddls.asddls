@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Shipment Nature Master'
define view entity ZR_PFI_SHIPNATURE
  as select from ZPFI_SHIPNATURE
{
  key shipnature_code as ShipNatureCode,
      description     as Description
}
