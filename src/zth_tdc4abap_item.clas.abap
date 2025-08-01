CLASS zth_tdc4abap_item DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC
  GLOBAL FRIENDS zth_tdc4abap_item_list
                 zth_tdc4abap_order.

  PUBLIC SECTION.
    TYPES: BEGIN OF s_full_data,
             dummy_item TYPE c LENGTH 1,
           END OF s_full_data.

    CLASS-METHODS create_any
      RETURNING
        VALUE(ro_item) TYPE REF TO zth_tdc4abap_item.

    CLASS-METHODS create
      IMPORTING
        iv_dlv_prio    TYPE ztdc4abap_delivery_prio DEFAULT zif_tdc4abap=>c_dlv_prio_any
        iv_dlv_date    TYPE ztdc4abap_delivery_date OPTIONAL
      RETURNING
        VALUE(ro_item) TYPE REF TO zth_tdc4abap_item.

    CLASS-METHODS create_with_data
      IMPORTING
        is_data        TYPE zif_tdc4abap_order_dao=>s_data
      RETURNING
        VALUE(ro_item) TYPE REF TO zth_tdc4abap_item.

    METHODS get_key
      RETURNING
        VALUE(rs_key) TYPE zif_tdc4abap_order_dao=>s_item_key.

    METHODS get_data
      RETURNING
        VALUE(rs_data) TYPE zif_tdc4abap_order_dao=>s_data.

    METHODS get_full_data
      RETURNING
        VALUE(rt_full_data) TYPE zth_tdc4abap_order=>s_full_data.

    METHODS set
      IMPORTING
        iv_dlv_prio    TYPE ztdc4abap_delivery_prio OPTIONAL
        iv_dlv_date    TYPE ztdc4abap_delivery_date OPTIONAL
      RETURNING
        VALUE(ro_item) TYPE REF TO zth_tdc4abap_item.

    CLASS-METHODS get_dependency_list
      RETURNING
        VALUE(rt_dependency_list) TYPE zth_tdc4abap=>t_dependency_list.

    DATA ms_data  TYPE zif_tdc4abap_order_dao=>s_data.
    DATA mo_order TYPE REF TO zth_tdc4abap_order.

  PRIVATE SECTION.
    TYPES tab TYPE STANDARD TABLE OF REF TO zth_tdc4abap_item WITH EMPTY KEY.

    CLASS-DATA mv_last_item_id TYPE i.

    CONSTANTS c_db_table TYPE tablename VALUE 'ZTDC4ABAP_ORDITM'.

    CLASS-METHODS get_next_item_id
      RETURNING
        VALUE(rv_id) TYPE i.

    METHODS set_order
      IMPORTING
        io_order TYPE REF TO zth_tdc4abap_order.

    METHODS collect_data_fully
      CHANGING
        cs_full_data TYPE zth_tdc4abap_order=>s_full_data-sub_tree_item.

    DATA mo_item_list TYPE REF TO zth_tdc4abap_item_list.
ENDCLASS.


CLASS zth_tdc4abap_item IMPLEMENTATION.
  METHOD collect_data_fully.
  ENDMETHOD.

  METHOD create.
    ro_item = create_with_data( VALUE zif_tdc4abap_order_dao=>s_data(
                                          item_id       = get_next_item_id( )
                                          delivery_prio = iv_dlv_prio
                                          delivery_date = iv_dlv_date ) ).
  ENDMETHOD.

  METHOD create_any.
    ro_item = create( ).
  ENDMETHOD.

  METHOD create_with_data.
    ro_item = NEW zth_tdc4abap_item( ).
    ro_item->ms_data = is_data.
  ENDMETHOD.

  METHOD get_data.
  ENDMETHOD.

  METHOD get_full_data.
  ENDMETHOD.

  METHOD get_key.
  ENDMETHOD.

  METHOD get_next_item_id.
    mv_last_item_id = mv_last_item_id + 1.
    rv_id = mv_last_item_id.
  ENDMETHOD.

  METHOD set.
    IF iv_dlv_prio IS SUPPLIED.
      ms_data-delivery_prio = iv_dlv_prio.
    ENDIF.
    IF iv_dlv_date IS SUPPLIED.
      ms_data-delivery_date = iv_dlv_date.
    ENDIF.
    ro_item = me.
  ENDMETHOD.

  METHOD set_order.
    ms_data-order_key = io_order->get_key( ).
  ENDMETHOD.

  METHOD get_dependency_list.
    INSERT c_db_table INTO TABLE rt_dependency_list.
  ENDMETHOD.
ENDCLASS.
