@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ports Master'
define view entity ZR_PFI_PORTS
  as select from ZPFI_PORTS
{
  key port_uuid as PortUUID,
      port_id   as PortID,
      name      as Name,
      country   as Country
}
