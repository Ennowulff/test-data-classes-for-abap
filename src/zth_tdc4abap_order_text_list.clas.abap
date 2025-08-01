CLASS zth_tdc4abap_order_text_list DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC
  GLOBAL FRIENDS zth_tdc4abap_order.

  PUBLIC SECTION.
    METHODS collect_data_fully
      CHANGING
        cs_full_data TYPE zth_tdc4abap_order_text=>s_full_data.
ENDCLASS.


CLASS zth_tdc4abap_order_text_list IMPLEMENTATION.
  METHOD collect_data_fully.
  ENDMETHOD.
ENDCLASS.
