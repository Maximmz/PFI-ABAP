@EndUserText.label: 'Shipment Nature - Projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_PFI_SHIPNATURE
  as projection on ZR_PFI_SHIPNATURE
{
  key ShipNatureCode,
      Description
}
