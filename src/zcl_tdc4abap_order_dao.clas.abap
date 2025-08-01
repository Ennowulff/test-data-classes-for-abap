CLASS zcl_tdc4abap_order_dao DEFINITION
  PUBLIC FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_tdc4abap_factory.

  PUBLIC SECTION.
    INTERFACES zif_tdc4abap_order_dao.
ENDCLASS.



CLASS ZCL_TDC4ABAP_ORDER_DAO IMPLEMENTATION.


  METHOD zif_tdc4abap_order_dao~create_order.
  ENDMETHOD.


  METHOD zif_tdc4abap_order_dao~delete_order.
  ENDMETHOD.


  METHOD zif_tdc4abap_order_dao~read_order.
    SELECT SINGLE * FROM ztdc4abap_order
      INTO CORRESPONDING FIELDS OF @rs_dao_data-s_order
      WHERE order_id = @is_order_key-order_id.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_tdc4abap_order_dao
            MESSAGE e001(order_msg) WITH is_order_key-order_id.
    ENDIF.
  ENDMETHOD.


  METHOD zif_tdc4abap_order_dao~update_order.
  ENDMETHOD.
ENDCLASS.
