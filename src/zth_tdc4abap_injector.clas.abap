CLASS zth_tdc4abap_injector DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC
  FOR TESTING.

  PUBLIC SECTION.
    CLASS-METHODS clear_singletons.

    CLASS-METHODS inject_order_dao
      IMPORTING
        io_order_dao TYPE REF TO zif_tdc4abap_order_dao.

    CLASS-METHODS inject_order_api
      IMPORTING
        io_order_api TYPE REF TO zif_tdc4abap_order_api.
ENDCLASS.


CLASS zth_tdc4abap_injector IMPLEMENTATION.
  METHOD clear_singletons.
  ENDMETHOD.

  METHOD inject_order_dao.
  ENDMETHOD.

  METHOD inject_order_api.
  ENDMETHOD.
ENDCLASS.
