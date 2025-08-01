CLASS zth_tdc4abap_item_list DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC
  GLOBAL FRIENDS zth_tdc4abap_item
                 zth_tdc4abap_order.

  PUBLIC SECTION.
    TYPES tt_item_list TYPE STANDARD TABLE OF REF TO zth_tdc4abap_item.

    METHODS add_item
      IMPORTING
        io_item TYPE REF TO zth_tdc4abap_item.

    METHODS create
      IMPORTING
        it_items            TYPE tt_item_list
      RETURNING
        VALUE(ro_item_list) TYPE REF TO zth_tdc4abap_item_list.

    METHODS get_size
      RETURNING
        VALUE(rv_size) TYPE i.

    METHODS get_full_data
      RETURNING
        VALUE(rs_full_data) TYPE string.

    METHODS get_item_like
      IMPORTING
        io_item        TYPE REF TO zth_tdc4abap_item
      RETURNING
        VALUE(ro_item) TYPE REF TO zth_tdc4abap_item.

    METHODS remove_item_like
      IMPORTING
        io_item        TYPE REF TO zth_tdc4abap_item
      RETURNING
        VALUE(ro_item) TYPE REF TO zth_tdc4abap_item.

  PRIVATE SECTION.
    DATA mt_item TYPE tt_item_list.

    METHODS collect_data_fully
      CHANGING
        cs_full_data TYPE zth_tdc4abap_order=>s_full_data-sub_tree_item.

ENDCLASS.


CLASS zth_tdc4abap_item_list IMPLEMENTATION.
  METHOD add_item.
    APPEND io_item TO mt_item.
  ENDMETHOD.

  METHOD create.
  ENDMETHOD.

  METHOD get_size.
    rv_size = lines( mt_item ).
  ENDMETHOD.

  METHOD get_full_data.
  ENDMETHOD.

  METHOD get_item_like.
    LOOP AT mt_item INTO DATA(lo_item).
      IF lo_item->get_key( ) = io_item->get_key( ).
        ro_item = lo_item.
        RETURN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD collect_data_fully.
    LOOP AT mt_item INTO DATA(lo_item).
      lo_item->collect_data_fully( CHANGING cs_full_data = cs_full_data ).
    ENDLOOP.
  ENDMETHOD.

  METHOD remove_item_like.
    DELETE mt_item WHERE table_line = io_item.
  ENDMETHOD.
ENDCLASS.
