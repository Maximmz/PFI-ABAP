@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Rate Type Master'
define view entity ZR_PFI_RATETYPES
  as select from ZPFI_RATETYPES
{
  key ratetype_code as RateTypeCode,
      description   as Description
}
