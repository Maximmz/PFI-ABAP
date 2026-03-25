@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product Models Master'
define view entity ZR_PFI_MODELS
  as select from ZPFI_MODELS
{
  key model_uuid as ModelUUID,
      model_id   as ModelID,
      name       as Name,
      description as Description
}
