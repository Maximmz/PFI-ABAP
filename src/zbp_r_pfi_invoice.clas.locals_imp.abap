CLASS lhc_Invoice DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Invoice RESULT result.
    METHODS setInitialValues FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Invoice~setInitialValues.
ENDCLASS.

CLASS lhc_Invoice IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD setInitialValues.
    READ ENTITIES OF ZR_PFI_INVOICE IN LOCAL MODE
      ENTITY Invoice
        FIELDS ( PfiNumber Status PfiDate )
        WITH CORRESPONDING #( keys )
      RESULT DATA(invoices).

    DELETE invoices WHERE PfiNumber IS NOT INITIAL.
    CHECK invoices IS NOT INITIAL.

    DATA(lv_date) = cl_abap_context_info=>get_system_date( ).

    MODIFY ENTITIES OF ZR_PFI_INVOICE IN LOCAL MODE
      ENTITY Invoice
        UPDATE FIELDS ( Status PfiDate )
        WITH VALUE #( FOR inv IN invoices (
          %tky = inv-%tky
          Status = 'DRAFT'
          PfiDate = lv_date
        ) ).
  ENDMETHOD.
ENDCLASS.

CLASS lhc_InvoiceItem DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS calculatePricing FOR DETERMINE ON MODIFY
      IMPORTING keys FOR InvoiceItem~calculatePricing.
    METHODS deriveItemCode FOR DETERMINE ON MODIFY
      IMPORTING keys FOR InvoiceItem~deriveItemCode.
ENDCLASS.

CLASS lhc_InvoiceItem IMPLEMENTATION.
  METHOD calculatePricing.
    READ ENTITIES OF ZR_PFI_INVOICE IN LOCAL MODE
      ENTITY InvoiceItem
        FIELDS ( FobUnitPrice LocalizationCost FreightCost Discount Quantity )
        WITH CORRESPONDING #( keys )
      RESULT DATA(items).

    LOOP AT items ASSIGNING FIELD-SYMBOL(<item>).
      <item>-FinalFobRate = <item>-FobUnitPrice + <item>-LocalizationCost + <item>-FreightCost - <item>-Discount.
      <item>-TotalCfr = <item>-FinalFobRate * <item>-Quantity.
      <item>-TotalAmount = <item>-TotalCfr.
      IF <item>-FobUnitPrice > 0.
        <item>-LocalizationPct = ( <item>-LocalizationCost / <item>-FobUnitPrice ) * 100.
      ENDIF.
    ENDLOOP.

    MODIFY ENTITIES OF ZR_PFI_INVOICE IN LOCAL MODE
      ENTITY InvoiceItem
        UPDATE FIELDS ( FinalFobRate TotalCfr TotalAmount LocalizationPct )
        WITH VALUE #( FOR item IN items (
          %tky = item-%tky
          FinalFobRate = item-FinalFobRate
          TotalCfr = item-TotalCfr
          TotalAmount = item-TotalAmount
          LocalizationPct = item-LocalizationPct
        ) ).
  ENDMETHOD.

  METHOD deriveItemCode.
    READ ENTITIES OF ZR_PFI_INVOICE IN LOCAL MODE
      ENTITY InvoiceItem
        FIELDS ( ModelUUID )
        WITH CORRESPONDING #( keys )
      RESULT DATA(items).

    LOOP AT items ASSIGNING FIELD-SYMBOL(<item>) WHERE ModelUUID IS NOT INITIAL.
      SELECT SINGLE model_id FROM zpfi_models WHERE model_uuid = @<item>-ModelUUID INTO @DATA(lv_item_code).
      IF sy-subrc = 0.
        MODIFY ENTITIES OF ZR_PFI_INVOICE IN LOCAL MODE
          ENTITY InvoiceItem
            UPDATE FIELDS ( ItemCode )
            WITH VALUE #( ( %tky = <item>-%tky ItemCode = lv_item_code ) ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
