CLASS zcl_tdc4abap_order_api DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC
  GLOBAL FRIENDS zcl_tdc4abap_factory
                 zif_tdc4abap_order_api.

  PUBLIC SECTION.
    INTERFACES zif_tdc4abap_order_api.

  PRIVATE SECTION.
    CLASS-DATA mo_order_dao TYPE REF TO zif_tdc4abap_order_dao.

    DATA mo_msg_handler TYPE REF TO zif_tdc4abap_msg_handler.

    CLASS-METHODS create
      RETURNING
        VALUE(result) TYPE REF TO zif_tdc4abap_order_dao.

    METHODS set_message_handler
      IMPORTING
        io_msg_handler TYPE REF TO zif_tdc4abap_msg_handler.

    METHODS is_delivery_prio_lower_than
      IMPORTING
        iv_dlv_prio_1      TYPE ztdc4abap_delivery_prio
        iv_dlv_prio_2      TYPE ztdc4abap_delivery_prio
      RETURNING
        VALUE(rv_is_lower) TYPE abap_bool.
ENDCLASS.


CLASS zcl_tdc4abap_order_api IMPLEMENTATION.
  METHOD zif_tdc4abap_order_api~read_items.
*    CLEAR: et_item_data, et_message.
*    TRY.
*        DATA(ls_dao_data) = mo_order_dao->read_order( is_order_key ).
*      CATCH cx_order_dao INTO DATA(lx_order_dao).
*        DATA(ls_message) = VALUE symsg(
*        msgid = lx_order_dao->if_t100_message~t100key-msgid
*        msgno = lx_order_dao->if_t100_message~t100key-msgno
*        msgty = lx_order_dao->if_t100_dyn_msg~msgty
*        msgv1 = lx_order_dao->if_t100_dyn_msg~msgv1
*        ...
*        ).
*        INSERT ls_message INTO TABLE et_message.
*        RETURN.
*    ENDTRY.
  ENDMETHOD.

  METHOD zif_tdc4abap_order_api~update_item.
    DATA ls_dao_change_data TYPE zif_tdc4abap_order_dao=>s_dao_update_data.

    DATA(ls_dao_data) = mo_order_dao->read_order( is_item_key-order_key ).
    ASSIGN ls_dao_data-t_item[ order_id = is_item_key-order_id
                               item_id  = is_item_key-item_id ] TO FIELD-SYMBOL(<s_item_data>).
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    <s_item_data>-delivery_prio = iv_dlv_prio.
    CASE iv_dlv_prio.
      WHEN zif_tdc4abap_order_dao=>c_dlv_prio_high.
        <s_item_data>-delivery_date = CONV ztdc4abap_delivery_date( sy-datum + 1 ).
      WHEN zif_tdc4abap_order_dao=>c_dlv_prio_medium.
        <s_item_data>-delivery_date = CONV ztdc4abap_delivery_date( sy-datum + 3 ).
      WHEN zif_tdc4abap_order_dao=>c_dlv_prio_low.
        <s_item_data>-delivery_date = CONV ztdc4abap_delivery_date( sy-datum + 7 ).
    ENDCASE.
    INSERT <s_item_data> INTO TABLE ls_dao_change_data-t_item_to_update.
    mo_order_dao->update_order( ls_dao_change_data ).
  ENDMETHOD.

  METHOD create.
    IF mo_order_dao IS INITIAL.
      mo_order_dao = zcl_tdc4abap_factory=>get_order_dao( ).
    ENDIF.
    result = mo_order_dao.
  ENDMETHOD.

  METHOD is_delivery_prio_lower_than.
  ENDMETHOD.

  METHOD set_message_handler.
    mo_msg_handler = io_msg_handler.
  ENDMETHOD.
ENDCLASS.
