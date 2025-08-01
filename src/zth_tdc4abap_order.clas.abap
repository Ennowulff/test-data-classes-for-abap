CLASS zth_tdc4abap_order DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC
  GLOBAL FRIENDS zth_tdc4abap_item_list
                 zth_tdc4abap_item.

  PUBLIC SECTION.
    TYPES:
      BEGIN OF s_full_data,
        t_order TYPE zif_tdc4abap_order_dao=>t_data.
        INCLUDE TYPE zth_tdc4abap_order_text=>s_full_data AS sub_tree_order_text.
        INCLUDE TYPE zth_tdc4abap_item=>s_full_data AS sub_tree_item. TYPES:
      END OF s_full_data.

    CLASS-METHODS create_any
      RETURNING
        VALUE(ro_order) TYPE REF TO zth_tdc4abap_order.

    CLASS-METHODS create
      IMPORTING
        iv_dlv_prio     TYPE ztdc4abap_delivery_prio DEFAULT zif_tdc4abap=>c_dlv_prio_any
        iv_dlv_date     TYPE ztdc4abap_delivery_date OPTIONAL
      RETURNING
        VALUE(ro_order) TYPE REF TO zth_tdc4abap_order.

    CLASS-METHODS create_with_data
      IMPORTING
        is_data         TYPE zif_tdc4abap_order_dao=>s_data
      RETURNING
        VALUE(ro_order) TYPE REF TO zth_tdc4abap_order.

    METHODS get_key
      RETURNING
        VALUE(rs_key) TYPE zif_tdc4abap_order_dao=>s_order_key.

    METHODS get_data
      RETURNING
        VALUE(rs_data) TYPE zif_tdc4abap_order_dao=>s_data.

    METHODS get_item_like
      EXPORTING
        io_item        TYPE REF TO zth_tdc4abap_item
      RETURNING
        VALUE(ro_item) TYPE REF TO zth_tdc4abap_item.

    METHODS get_full_data
      RETURNING
        VALUE(rs_full_data) TYPE zth_tdc4abap_order=>s_full_data.

    METHODS set
      IMPORTING
        iv_order_type   TYPE ztdc4abap_order_type
      RETURNING
        VALUE(ro_order) TYPE REF TO zth_tdc4abap_order.

    METHODS add_item
      IMPORTING
        io_item TYPE REF TO zth_tdc4abap_item.

    CLASS-METHODS get_dependency_list
      RETURNING
        VALUE(rt_dependency_list) TYPE zth_tdc4abap=>t_dependency_list.

    METHODS inject_into_osql_fully
      IMPORTING
        io_environment TYPE string " ref to if_osql_test_environment
        is_full_data   TYPE zth_tdc4abap_order=>s_full_data.

    DATA ms_data TYPE zif_tdc4abap_order_dao=>s_data.

  PRIVATE SECTION.
    CLASS-DATA mv_last_item_id TYPE i.

    CONSTANTS c_db_table TYPE tablename VALUE 'ZTDC4ABAP_ORDER'.

    DATA mo_item_list       TYPE REF TO zth_tdc4abap_item_list.
    DATA mo_order_text_list TYPE REF TO zth_tdc4abap_order_text_list.

    CLASS-METHODS get_next_item_id
      RETURNING
        VALUE(rv_id) TYPE i.

    METHODS collect_data_fully
      CHANGING
        cs_full_data TYPE zth_tdc4abap_order=>s_full_data.

    CLASS-METHODS inject_data_into_osql_fully
      IMPORTING
        io_environment TYPE string " ref to if_osql_test_environment
        is_data        TYPE zif_tdc4abap_order_dao=>s_data.
ENDCLASS.


CLASS zth_tdc4abap_order IMPLEMENTATION.
  METHOD create.
    ro_order = create_with_data( VALUE zif_tdc4abap_order_dao=>s_data(
                                           item_id       = get_next_item_id( )
                                           delivery_prio = iv_dlv_prio
                                           delivery_date = iv_dlv_date ) ).
  ENDMETHOD.

  METHOD create_any.
    ro_order = create( ).
  ENDMETHOD.

  METHOD create_with_data.
    ro_order = NEW zth_tdc4abap_order( ).
    ro_order->ms_data = is_data.
  ENDMETHOD.

  METHOD get_next_item_id.
    mv_last_item_id = mv_last_item_id + 1.
    rv_id = mv_last_item_id.
  ENDMETHOD.

  METHOD get_key.
  ENDMETHOD.

  METHOD get_data.
  ENDMETHOD.

  METHOD get_item_like.
    " TODO: parameter IO_ITEM is never cleared or assigned (ABAP cleaner)

    ro_item = mo_item_list->get_item_like( io_item ).
  ENDMETHOD.

  METHOD collect_data_fully.
    INSERT ms_data INTO TABLE cs_full_data-t_order.
    mo_order_text_list->collect_data_fully(
      CHANGING cs_full_data = cs_full_data-sub_tree_order_text ).
    mo_item_list->collect_data_fully(
      CHANGING cs_full_data = cs_full_data-sub_tree_item ).
  ENDMETHOD.

  METHOD get_full_data.
    collect_data_fully( CHANGING cs_full_data = rs_full_data ).
  ENDMETHOD.

  METHOD set.
*  ms_data-order_key = iv_order_type.
  ENDMETHOD.

  METHOD add_item.
    io_item->set_order( me ).
    mo_item_list->add_item( io_item ).
  ENDMETHOD.

  METHOD get_dependency_list.
    INSERT c_db_table INTO TABLE rt_dependency_list.
    INSERT LINES OF zth_tdc4abap_order_text=>get_dependency_list( )
           INTO TABLE rt_dependency_list.
    INSERT LINES OF zth_tdc4abap_item=>get_dependency_list( )
           INTO TABLE rt_dependency_list.
  ENDMETHOD.

  METHOD inject_data_into_osql_fully.
  ENDMETHOD.

  METHOD inject_into_osql_fully.
  ENDMETHOD.
ENDCLASS.
