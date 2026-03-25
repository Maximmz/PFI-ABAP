@EndUserText.label: 'Quotations - Projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_PFI_QUOTATIONS
  as projection on ZR_PFI_QUOTATIONS
{
  key QuotationUUID,
      QuotationNo,
      SupplierUUID,
      QuotationDate,
      ValidUntil,
      Status
}
