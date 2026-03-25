@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'PFIInvoiceItem'
@EndUserText.label: 'Invoice Item'
define view entity ZR_PFI_INV_ITEM
  as select from ZPFI_INV_ITEMS
  association to parent ZR_PFI_INVOICE as _Invoice on $projection.InvoiceUUID = _Invoice.InvoiceUUID
  association [0..1] to ZR_PFI_MODELS as _Model on $projection.ModelUUID = _Model.ModelUUID
  association [0..1] to ZR_PFI_HSCODES as _HSCode on $projection.HSCodeUUID = _HSCode.HSCodeUUID
  association [0..1] to ZR_PFI_POTYPES as _POType on $projection.POTypeCode = _POType.POTypeCode
{
  key item_uuid          as ItemUUID,
      invoice_uuid       as InvoiceUUID,
      model_uuid         as ModelUUID,
      item_code          as ItemCode,
      description        as Description,
      hscode_uuid        as HSCodeUUID,
      lot_size           as LotSize,
      quantity           as Quantity,
      @Semantics.amount.currencyCode: 'Currency'
      list_price         as ListPrice,
      @Semantics.amount.currencyCode: 'Currency'
      unit_price         as UnitPrice,
      no_of_po           as NoOfPO,
      @Semantics.amount.currencyCode: 'Currency'
      fob_unit_price     as FobUnitPrice,
      @Semantics.amount.currencyCode: 'Currency'
      localization_cost  as LocalizationCost,
      localization_pct   as LocalizationPct,
      @Semantics.amount.currencyCode: 'Currency'
      freight_cost       as FreightCost,
      @Semantics.amount.currencyCode: 'Currency'
      discount           as Discount,
      @Semantics.amount.currencyCode: 'Currency'
      final_fob_rate     as FinalFobRate,
      @Semantics.amount.currencyCode: 'Currency'
      total_cfr          as TotalCfr,
      @Semantics.amount.currencyCode: 'Currency'
      total_amount       as TotalAmount,
      potype_code        as POTypeCode,
      currency           as Currency,
      @Semantics.amount.currencyCode: 'Currency'
      kit_per_unit       as KitPerUnit,
      @Semantics.amount.currencyCode: 'Currency'
      tbs_per_unit       as TbsPerUnit,
      @Semantics.amount.currencyCode: 'Currency'
      tyre_per_unit      as TyrePerUnit,
      _Invoice,
      _Model,
      _HSCode,
      _POType
}
