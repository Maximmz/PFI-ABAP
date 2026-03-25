@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'PFIInvoiceItem'
@EndUserText.label: 'Invoice Item - Projection'
define view entity ZC_PFI_INV_ITEM
  as projection on ZR_PFI_INV_ITEM
{
  key ItemUUID,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZC_PFI_MODELS', element: 'ModelUUID' } }]
      ModelUUID,
      ItemCode,
      Description,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZC_PFI_HSCODES', element: 'HSCodeUUID' } }]
      HSCodeUUID,
      LotSize,
      Quantity,
      ListPrice,
      UnitPrice,
      NoOfPO,
      FobUnitPrice,
      LocalizationCost,
      LocalizationPct,
      FreightCost,
      Discount,
      FinalFobRate,
      TotalCfr,
      TotalAmount,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZC_PFI_POTYPES', element: 'POTypeCode' } }]
      POTypeCode,
      Currency,
      KitPerUnit,
      TbsPerUnit,
      TyrePerUnit,
      _Invoice,
      _Model,
      _HSCode,
      _POType
}
