@EndUserText.label: 'Ports - Projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_PFI_PORTS
  as projection on ZR_PFI_PORTS
{
  key PortUUID,
      PortID,
      Name,
      Country
}
