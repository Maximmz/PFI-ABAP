CLASS LHC_ZR_ASHOPCART_000 DEFINITION INHERITING FROM cl_abap_behavior_handler.
PRIVATE SECTION.
  CONSTANTS:
    BEGIN OF c_overall_status,
      new       TYPE string VALUE 'New / Composing',

      submitted TYPE string VALUE 'Submitted / Approved',
      cancelled TYPE string VALUE 'Cancelled',
    END OF c_overall_status.
  METHODS:
    get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING
      REQUEST requested_authorizations FOR ShoppingCart
      RESULT result,
    get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR ShoppingCart RESULT result.

  METHODS calculateTotalPrice FOR DETERMINE ON MODIFY
    IMPORTING keys FOR ShoppingCart~calculateTotalPrice.

  METHODS setInitialOrderValues FOR DETERMINE ON MODIFY
    IMPORTING keys FOR ShoppingCart~setInitialOrderValues.

  METHODS checkDeliveryDate FOR VALIDATE ON SAVE
    IMPORTING keys FOR ShoppingCart~checkDeliveryDate.

  METHODS checkOrderedQuantity FOR VALIDATE ON SAVE
    IMPORTING keys FOR ShoppingCart~checkOrderedQuantity.
ENDCLASS.

CLASS LHC_ZR_ASHOPCART_000 IMPLEMENTATION.
METHOD get_global_authorizations.
ENDMETHOD.
METHOD get_instance_features.

  " read relevant olineShop instance data
  READ ENTITIES OF ZR_ASHOPCART_000 IN LOCAL MODE
    ENTITY ShoppingCart
      FIELDS ( OverallStatus )
      WITH CORRESPONDING #( keys )
    RESULT DATA(OnlineOrders)
    FAILED failed.

  " evaluate condition, set operation state, and set result parameter
  " update and checkout shall not be allowed as soon as purchase requisition has been created
  result = VALUE #( FOR OnlineOrder IN OnlineOrders
                    ( %tky                   = OnlineOrder-%tky
                      %features-%update
                        = COND #( WHEN OnlineOrder-OverallStatus = c_overall_status-submitted  THEN if_abap_behv=>fc-o-disabled
                                  WHEN OnlineOrder-OverallStatus = c_overall_status-cancelled THEN if_abap_behv=>fc-o-disabled
                                  ELSE if_abap_behv=>fc-o-enabled   )
                      %action-Edit
                        = COND #( WHEN OnlineOrder-OverallStatus = c_overall_status-submitted THEN if_abap_behv=>fc-o-disabled
                                  WHEN OnlineOrder-OverallStatus = c_overall_status-cancelled THEN if_abap_behv=>fc-o-disabled
                                  ELSE if_abap_behv=>fc-o-enabled   )
                      ) ).
ENDMETHOD.

METHOD calculateTotalPrice.
  DATA total_price TYPE ZR_ASHOPCART_000-TotalPrice.

  " read transfered instances
  READ ENTITIES OF ZR_ASHOPCART_000 IN LOCAL MODE
    ENTITY ShoppingCart
      FIELDS ( OrderID TotalPrice )
      WITH CORRESPONDING #( keys )
    RESULT DATA(OnlineOrders).

  LOOP AT OnlineOrders ASSIGNING FIELD-SYMBOL(<OnlineOrder>).
    " calculate total value
    <OnlineOrder>-TotalPrice = <OnlineOrder>-Price * <OnlineOrder>-OrderQuantity.
  ENDLOOP.

  "update instances
  MODIFY ENTITIES OF ZR_ASHOPCART_000 IN LOCAL MODE
    ENTITY ShoppingCart
      UPDATE FIELDS ( TotalPrice )
      WITH VALUE #( FOR OnlineOrder IN OnlineOrders (
                        %tky       = OnlineOrder-%tky
                        TotalPrice = <OnlineOrder>-TotalPrice
                      ) ).
ENDMETHOD.

METHOD setInitialOrderValues.

  DATA delivery_date TYPE I_PurchaseReqnItemTP-DeliveryDate.
  DATA(creation_date) = cl_abap_context_info=>get_system_date(  ).
  "set delivery date proposal
  delivery_date = cl_abap_context_info=>get_system_date(  ) + 14.
  "read transfered instances
  READ ENTITIES OF ZR_ASHOPCART_000 IN LOCAL MODE
    ENTITY ShoppingCart
      FIELDS ( OrderID OverallStatus  DeliveryDate )
      WITH CORRESPONDING #( keys )
    RESULT DATA(OnlineOrders).

  "delete entries with assigned order ID
  DELETE OnlineOrders WHERE OrderID IS NOT INITIAL.
  CHECK OnlineOrders IS NOT INITIAL.

  " **Dummy logic to determine order IDs**
  " get max order ID from the relevant active and draft table entries
  SELECT MAX( order_id ) FROM zashopcart__000 INTO @DATA(max_order_id). "active table
  SELECT SINGLE FROM ZASHOPCART_000_D FIELDS MAX( orderid ) INTO @DATA(max_orderid_draft). "draft table
  IF max_orderid_draft > max_order_id.
    max_order_id = max_orderid_draft.
  ENDIF.

  "set initial values of new instances
  MODIFY ENTITIES OF ZR_ASHOPCART_000 IN LOCAL MODE
    ENTITY ShoppingCart
      UPDATE FIELDS ( OrderID OverallStatus  DeliveryDate Price  )
      WITH VALUE #( FOR order IN OnlineOrders INDEX INTO i (
                        %tky          = order-%tky
                        OrderID       = max_order_id + i
                        OverallStatus = c_overall_status-new  "'New / Composing'
                        DeliveryDate  = delivery_date
                        CreatedAt     = creation_date
                      ) ).
ENDMETHOD.

METHOD checkDeliveryDate.

*   " read transfered instances
  READ ENTITIES OF ZR_ASHOPCART_000 IN LOCAL MODE
    ENTITY ShoppingCart
      FIELDS ( DeliveryDate )
      WITH CORRESPONDING #( keys )
    RESULT DATA(OnlineOrders).

  DATA(creation_date) = cl_abap_context_info=>get_system_date(  ).


  "raise msg if delivery date is not ok
  LOOP AT OnlineOrders INTO DATA(online_order).
    APPEND VALUE #(  %tky           = Online_Order-%tky
                     %state_area    = 'VALIDATE_DELIVERYDATE'
                  ) TO reported-ShoppingCart.

    IF online_order-DeliveryDate IS INITIAL OR online_order-DeliveryDate = ' '.
      APPEND VALUE #( %tky = online_order-%tky ) TO failed-ShoppingCart.
      APPEND VALUE #( %tky         = online_order-%tky
                      %state_area   = 'VALIDATE_DELIVERYDATE'
                      %msg          = new_message_with_text(
                              severity = if_abap_behv_message=>severity-error
                              text     = 'Delivery Date cannot be initial' )
                      %element-deliverydate  = if_abap_behv=>mk-on
                    ) TO reported-ShoppingCart.

    ELSEIF  ( ( online_order-DeliveryDate ) - creation_date ) < 14.
      APPEND VALUE #(  %tky = online_order-%tky ) TO failed-ShoppingCart.
      APPEND VALUE #(  %tky          = online_order-%tky
                      %state_area   = 'VALIDATE_DELIVERYDATE'
                      %msg          = new_message_with_text(
                              severity = if_abap_behv_message=>severity-error
                              text     = 'Delivery Date should be at least 14 days after the creation date'  )
                      %element-deliverydate  = if_abap_behv=>mk-on
                    ) TO reported-ShoppingCart.
    ENDIF.
  ENDLOOP.
ENDMETHOD.

METHOD checkOrderedQuantity.

  "read relevant order instance data
  READ ENTITIES OF ZR_ASHOPCART_000 IN LOCAL MODE
  ENTITY ShoppingCart
  FIELDS ( OrderID OrderedItem OrderQuantity )
  WITH CORRESPONDING #( keys )
  RESULT DATA(OnlineOrders).

  "raise msg if 0 > qty <= 10
  LOOP AT OnlineOrders INTO DATA(OnlineOrder).
    APPEND VALUE #(  %tky           = OnlineOrder-%tky
                    %state_area    = 'VALIDATE_QUANTITY'
                  ) TO reported-ShoppingCart.


    IF OnlineOrder-OrderQuantity IS INITIAL OR OnlineOrder-OrderQuantity = ' '.
      APPEND VALUE #( %tky = OnlineOrder-%tky ) TO failed-ShoppingCart.
      APPEND VALUE #( %tky          = OnlineOrder-%tky
                      %state_area   = 'VALIDATE_QUANTITY'
                      %msg          = new_message_with_text(
                              severity = if_abap_behv_message=>severity-error
                              text     = 'Quantity cannot be empty' )
                      %element-orderquantity = if_abap_behv=>mk-on
                    ) TO reported-ShoppingCart.

    ELSEIF OnlineOrder-OrderQuantity > 10.
      APPEND VALUE #(  %tky = OnlineOrder-%tky ) TO failed-ShoppingCart.
      APPEND VALUE #(  %tky          = OnlineOrder-%tky
                      %state_area   = 'VALIDATE_QUANTITY'
                      %msg          = new_message_with_text(
                              severity = if_abap_behv_message=>severity-error
                              text     = 'Quantity should be below 10' )
                      %element-orderquantity  = if_abap_behv=>mk-on
                    ) TO reported-ShoppingCart.
      ENDIF.
    ENDLOOP.
    ENDMETHOD.
  ENDCLASS.
