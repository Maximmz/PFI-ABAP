@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'PFIInvoice'
@EndUserText.label: 'Performa Invoice - Projection'
define root view entity ZC_PFI_INVOICE
  provider contract transactional_query
  as projection on ZR_PFI_INVOICE
  association [1..1] to ZR_PFI_INVOICE as _BaseEntity on $projection.InvoiceUUID = _BaseEntity.InvoiceUUID
{
  key InvoiceUUID,
      PfiNumber,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZC_PFI_SUPPLIERS', element: 'SupplierUUID' } }]
      SupplierUUID,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZC_PFI_CURRENCIES', element: 'CurrencyCode' } }]
      CurrencyCode,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZC_PFI_QUOTATIONS', element: 'QuotationUUID' } }]
      QuotationUUID,
      Status,
      PfiDate,
      ValidityDate,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZC_PFI_RATETYPES', element: 'RateTypeCode' } }]
      RateTypeCode,
      ExchangeRate,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZC_PFI_PAYTERMS', element: 'PayTermCode' } }]
      PayTermCode,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZC_PFI_INCOTERMS', element: 'IncoTermCode' } }]
      IncoTermCode,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZC_PFI_SHIPMODES', element: 'ShipModeCode' } }]
      ShipModeCode,
      DepartureDate,
      ArrivalDate,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZC_PFI_PORTS', element: 'PortUUID' } }]
      PortLoading,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZC_PFI_PORTS', element: 'PortUUID' } }]
      PortDischarge,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZC_PFI_SHIPNATURE', element: 'ShipNatureCode' } }]
      ShipNatureCode,
      @Semantics.user.createdBy: true
      CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      CreatedAt,
      @Semantics.user.lastChangedBy: true
      LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChanged,
      _Items,
      _BaseEntity
}
