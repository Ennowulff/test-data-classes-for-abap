CLASS zcl_tdc4abap_factory DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC
  GLOBAL FRIENDS zth_tdc4abap_injector
                 zif_tdc4abap_order_api.

  PUBLIC SECTION.
    CLASS-METHODS get_order_dao
      RETURNING
        VALUE(result) TYPE REF TO zif_tdc4abap_order_dao.

    CLASS-METHODS get_order_api
      IMPORTING
        io_msg_handler TYPE REF TO zif_tdc4abap_msg_handler
      RETURNING
        VALUE(result)  TYPE REF TO zif_tdc4abap_order_api.

    CLASS-METHODS create_message_handler
      RETURNING
        VALUE(ro_msg_handler) TYPE REF TO zif_tdc4abap_msg_handler.

  PRIVATE SECTION.
    CLASS-DATA so_order_dao TYPE REF TO zif_tdc4abap_order_dao.
    CLASS-DATA so_order_api TYPE REF TO zif_tdc4abap_order_api.
ENDCLASS.


CLASS zcl_tdc4abap_factory IMPLEMENTATION.
  METHOD get_order_dao.
    IF so_order_dao IS INITIAL.
      so_order_dao = NEW zcl_tdc4abap_order_dao( ).
    ENDIF.
    result = so_order_dao.
  ENDMETHOD.

  METHOD get_order_api.
    " TODO: parameter IO_MSG_HANDLER is never used (ABAP cleaner)

    IF so_order_api IS INITIAL.
      so_order_api = NEW zcl_tdc4abap_order_api( ).
    ENDIF.
    result = so_order_api.
  ENDMETHOD.

  METHOD create_message_handler.
  ENDMETHOD.
ENDCLASS.
