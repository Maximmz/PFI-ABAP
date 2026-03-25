@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Shipment Mode Master'
define view entity ZR_PFI_SHIPMODES
  as select from ZPFI_SHIPMODES
{
  key shipmode_code as ShipModeCode,
      description   as Description
}
