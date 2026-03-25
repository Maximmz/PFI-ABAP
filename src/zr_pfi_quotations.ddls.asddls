@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Quotations Master'
define view entity ZR_PFI_QUOTATIONS
  as select from ZPFI_QUOTATIONS
{
  key quotation_uuid as QuotationUUID,
      quotation_no   as QuotationNo,
      supplier_uuid  as SupplierUUID,
      quotation_date as QuotationDate,
      valid_until    as ValidUntil,
      status         as Status
}
