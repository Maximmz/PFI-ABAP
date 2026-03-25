@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'PFIInvoice'
@EndUserText.label: 'Performa Invoice'
define root view entity ZR_PFI_INVOICE
  as select from ZPFI_INVOICES
  composition [0..*] of ZR_PFI_INV_ITEM as _Items
  association [0..1] to ZR_PFI_SUPPLIERS as _Supplier on $projection.SupplierUUID = _Supplier.SupplierUUID
  association [0..1] to ZR_PFI_CURRENCIES as _Currency on $projection.CurrencyCode = _Currency.CurrencyCode
  association [0..1] to ZR_PFI_QUOTATIONS as _Quotation on $projection.QuotationUUID = _Quotation.QuotationUUID
  association [0..1] to ZR_PFI_RATETYPES as _RateType on $projection.RateTypeCode = _RateType.RateTypeCode
  association [0..1] to ZR_PFI_PAYTERMS as _PayTerm on $projection.PayTermCode = _PayTerm.PayTermCode
  association [0..1] to ZR_PFI_INCOTERMS as _IncoTerm on $projection.IncoTermCode = _IncoTerm.IncoTermCode
  association [0..1] to ZR_PFI_SHIPMODES as _ShipMode on $projection.ShipModeCode = _ShipMode.ShipModeCode
  association [0..1] to ZR_PFI_PORTS as _PortLoading on $projection.PortLoading = _PortLoading.PortUUID
  association [0..1] to ZR_PFI_PORTS as _PortDischarge on $projection.PortDischarge = _PortDischarge.PortUUID
  association [0..1] to ZR_PFI_SHIPNATURE as _ShipNature on $projection.ShipNatureCode = _ShipNature.ShipNatureCode
{
  key invoice_uuid       as InvoiceUUID,
      pfi_number         as PfiNumber,
      supplier_uuid      as SupplierUUID,
      currency_code      as CurrencyCode,
      quotation_uuid     as QuotationUUID,
      status             as Status,
      pfi_date           as PfiDate,
      validity_date      as ValidityDate,
      ratetype_code      as RateTypeCode,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      exchange_rate      as ExchangeRate,
      payterm_code       as PayTermCode,
      incoterm_code      as IncoTermCode,
      shipmode_code      as ShipModeCode,
      departure_date     as DepartureDate,
      arrival_date       as ArrivalDate,
      port_loading       as PortLoading,
      port_discharge     as PortDischarge,
      shipnature_code    as ShipNatureCode,
      @Semantics.user.createdBy: true
      created_by         as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at         as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by    as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at    as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed as LocalLastChanged,
      _Items,
      _Supplier,
      _Currency,
      _Quotation,
      _RateType,
      _PayTerm,
      _IncoTerm,
      _ShipMode,
      _PortLoading,
      _PortDischarge,
      _ShipNature
}
