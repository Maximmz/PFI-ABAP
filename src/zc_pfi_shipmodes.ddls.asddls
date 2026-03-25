@EndUserText.label: 'Shipment Mode - Projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_PFI_SHIPMODES
  as projection on ZR_PFI_SHIPMODES
{
  key ShipModeCode,
      Description
}
