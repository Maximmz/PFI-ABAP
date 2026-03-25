@AbapCatalog.sqlViewName: 'ZMN_MATERIAL1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'get material data'
@Metadata.ignorePropagatedAnnotations: true
define view zmn_material as select from I_BusinessPartner
{
  key BusinessPartner,
      BusinessPartnerFullName,
      BusinessPartnerIsBlocked,
      BusinessPartnerType
}
