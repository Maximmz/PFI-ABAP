@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'Zashopcart_000'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_ASHOPCART_000
  provider contract transactional_query
  as projection on ZR_ASHOPCART_000
  association [1..1] to ZR_ASHOPCART_000 as _BaseEntity on $projection.OrderUUID = _BaseEntity.OrderUUID
{
  key OrderUUID,
  OrderID,
  
  @Consumption.valueHelpDefinition: [{ entity: 
             {name: 'ZI_PRODUCTS_000' , element: 'Product' },
             additionalBinding: [{ localElement: 'Price', element: 'Price', usage: #RESULT },
                                 { localElement: 'Currency', element: 'Currency', usage: #RESULT }
                                                                   ]
             }]  
               
  OrderedItem,
  @Semantics: {
    amount.currencyCode: 'Currency'
  }
  Price,
  @Semantics: {
    amount.currencyCode: 'Currency'
  }
  TotalPrice,
 
 @Consumption.valueHelpDefinition: [ { entity: { name: 'I_Currency', element: 'Currency' } } ]  
    
  Currency,
  OrderQuantity,
  DeliveryDate,
  OverallStatus,
  Notes,
  @Semantics: {
    user.createdBy: true
  }
  CreatedBy,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  CreatedAt,
  @Semantics: {
    user.lastChangedBy: true
  }
  LastChangedBy,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  LastChangedAt,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  
  LocalLastChangedAt,
  PurchaseRequisition,
  PrCreationDate,
  _BaseEntity
}
