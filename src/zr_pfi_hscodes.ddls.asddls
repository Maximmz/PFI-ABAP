@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'HS Codes Master'
define view entity ZR_PFI_HSCODES
  as select from ZPFI_HSCODES
{
  key hscode_uuid as HSCodeUUID,
      hscode      as HSCode,
      description as Description
}
