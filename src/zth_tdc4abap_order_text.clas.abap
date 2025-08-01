CLASS zth_tdc4abap_order_text DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.
*  GLOBAL FRIENDS zth_tdc4abap_item_list.

  PUBLIC SECTION.
    TYPES: BEGIN OF s_full_data,
             dummy TYPE string,
           END OF s_full_data.

    CLASS-METHODS create_any
      RETURNING
        VALUE(ro_order_text) TYPE REF TO zth_tdc4abap_order_text.

    CLASS-METHODS create
*      IMPORTING
*        iv_text type string
      RETURNING
        VALUE(ro_order_text) TYPE REF TO zth_tdc4abap_order_text.

    CLASS-METHODS create_with_data
      IMPORTING
        is_data         TYPE zif_tdc4abap_order_dao=>s_data
      RETURNING
        VALUE(ro_order) TYPE REF TO zth_tdc4abap_order_text.

    METHODS get_key
      RETURNING
        VALUE(rs_key) TYPE zif_tdc4abap_order_dao=>s_order_key.

    CLASS-METHODS get_dependency_list
      RETURNING
        VALUE(rt_dependeny_list) TYPE zth_tdc4abap=>t_dependency_list.

    DATA ms_data TYPE zif_tdc4abap_order_dao=>s_data.

  PRIVATE SECTION.
    CONSTANTS c_db_table TYPE tablename VALUE 'ZTDC4ABAP_ORDTXT'.

    CLASS-DATA mv_last_item_id TYPE i.

    CLASS-METHODS get_next_item_id
      RETURNING
        VALUE(rv_id) TYPE i.
ENDCLASS.


CLASS zth_tdc4abap_order_text IMPLEMENTATION.
  METHOD create.
*    ro_order_text = create_with_data( VALUE zif_tdc4abap_order_dao=>s_data(
*                                          item_id       = get_next_item_id( )
*                                          delivery_prio = iv_dlv_prio
*                                          delivery_date = iv_dlv_date ) ).
  ENDMETHOD.

  METHOD create_any.
    ro_order_text = create( ).
  ENDMETHOD.

  METHOD create_with_data.
    ro_order = NEW zth_tdc4abap_order_text( ).
    ro_order->ms_data = is_data.
  ENDMETHOD.

  METHOD get_next_item_id.
    mv_last_item_id = mv_last_item_id + 1.
    rv_id = mv_last_item_id.
  ENDMETHOD.

  METHOD get_key.
  ENDMETHOD.

  METHOD get_dependency_list.
    INSERT c_db_table INTO TABLE rt_dependeny_list.
  ENDMETHOD.
ENDCLASS.
