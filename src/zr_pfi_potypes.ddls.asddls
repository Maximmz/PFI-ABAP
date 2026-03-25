@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PO Type Master'
define view entity ZR_PFI_POTYPES
  as select from ZPFI_POTYPES
{
  key potype_code as POTypeCode,
      description as Description
}
