@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: 'get material data'
}
define view entity ZC_MN_MATERIAL
  as select from ZMN_MATERIAL
  association [1..1] to ZMN_MATERIAL as _BaseEntity on $projection.BUSINESSPARTNER = _BaseEntity.BUSINESSPARTNER
{
  @Endusertext: {
    Label: 'Business Partner', 
    Quickinfo: 'Business Partner Number'
  }
  key BusinessPartner,
  BusinessPartnerFullName,
  @Endusertext: {
    Label: 'Central Block', 
    Quickinfo: 'Central Block for Business Partner'
  }
  BusinessPartnerIsBlocked,
  @Endusertext: {
    Label: 'BP Type', 
    Quickinfo: 'Business Partner Type'
  }
  BusinessPartnerType,
  _BaseEntity
}
