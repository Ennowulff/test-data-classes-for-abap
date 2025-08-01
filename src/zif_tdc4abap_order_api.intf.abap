INTERFACE zif_tdc4abap_order_api
  PUBLIC .
  TYPES:
    BEGIN OF s_item_data,
      order_id      TYPE ztdc4abap_order_id,
      item_id       TYPE ztdc4abap_item_id,
      delivery_prio TYPE ztdc4abap_delivery_prio,
      delivery_date TYPE ztdc4abap_delivery_date,
    END OF s_item_data.
  TYPES t_item_data TYPE STANDARD TABLE OF s_item_data WITH EMPTY KEY.
  METHODS read_items
    IMPORTING is_order_key        TYPE zif_tdc4abap_order_dao=>s_order_key
              iv_min_dlv_prio     TYPE ztdc4abap_delivery_prio OPTIONAL
    RETURNING VALUE(rt_item_data) TYPE t_item_data.
  METHODS update_item
    IMPORTING is_item_key TYPE zif_tdc4abap_order_dao=>s_item_key
              iv_dlv_prio TYPE ztdc4abap_delivery_prio.
ENDINTERFACE.
