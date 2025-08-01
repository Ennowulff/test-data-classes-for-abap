INTERFACE zif_tdc4abap_order_dao
  PUBLIC.

  CONSTANTS c_order_type_standard TYPE ztdc4abap_order_type    VALUE 'S'.
  CONSTANTS c_order_type_express  TYPE ztdc4abap_order_type    VALUE 'E'.
  CONSTANTS c_dlv_prio_high       TYPE ztdc4abap_delivery_prio VALUE 'H'.
  CONSTANTS c_dlv_prio_medium     TYPE ztdc4abap_delivery_prio VALUE 'M'.
  CONSTANTS c_dlv_prio_low        TYPE ztdc4abap_delivery_prio VALUE 'L'.

  TYPES:
    BEGIN OF s_order_key,
      order_id TYPE ztdc4abap_order_id,
    END OF s_order_key.
  TYPES:
    BEGIN OF s_order_data.
      INCLUDE TYPE s_order_key AS key.
    TYPES:
      order_type TYPE ztdc4abap_order_type,
    END OF s_order_data.
  TYPES:
    BEGIN OF s_order_text_key.
      INCLUDE TYPE s_order_key AS order_key. TYPES:
      language TYPE spras,
    END OF s_order_text_key,
    t_order_text_key TYPE STANDARD TABLE OF s_order_text_key WITH KEY order_id language.
  TYPES:
    BEGIN OF s_order_text_data.
      INCLUDE TYPE s_order_text_key AS key.
    TYPES:
      desacription TYPE ztdc4abap_description,
    END OF s_order_text_data,
    t_order_text_data TYPE STANDARD TABLE OF s_order_text_data WITH KEY order_id language.

  TYPES:
    BEGIN OF s_item_key.
      INCLUDE TYPE s_order_key AS order_key. TYPES:
      item_id TYPE ztdc4abap_item_id,
    END OF s_item_key.
  TYPES t_item_key TYPE STANDARD TABLE OF s_item_key WITH KEY order_id item_id.
  TYPES:
    BEGIN OF s_item_data.
      INCLUDE TYPE s_item_key AS key. TYPES:
      delivery_prio TYPE ztdc4abap_delivery_prio,
      delivery_date TYPE ztdc4abap_delivery_date,
    END OF s_item_data.
  TYPES t_item_data TYPE STANDARD TABLE OF s_item_data WITH KEY order_id item_id.

  TYPES:
    BEGIN OF s_data.
      INCLUDE TYPE s_item_key AS key. TYPES:
      delivery_prio TYPE ztdc4abap_delivery_prio,
      delivery_date TYPE ztdc4abap_delivery_date,
    END OF s_data,
    t_data TYPE SORTED TABLE OF s_data WITH UNIQUE KEY key.

  TYPES:
    BEGIN OF s_dao_data,
      s_order      TYPE s_order_data,
      t_order_text TYPE t_order_text_data,
      t_item       TYPE t_item_data,
    END OF s_dao_data.
  TYPES:
    BEGIN OF s_dao_update_data,
      s_order                TYPE s_order_data,
      t_order_text_to_create TYPE t_order_text_data,
      t_order_text_to_update TYPE t_order_text_data,
      t_order_text_to_delete TYPE t_order_text_key,
      t_item_to_create       TYPE t_item_data,
      t_item_to_update       TYPE t_item_data,
      t_item_to_delete       TYPE t_item_key,
    END OF s_dao_update_data.

  METHODS create_order
    IMPORTING
      is_dao_data TYPE s_dao_data.

  METHODS read_order
    IMPORTING
      is_order_key       TYPE s_order_key
    RETURNING
      VALUE(rs_dao_data) TYPE s_dao_data
    RAISING
      zcx_tdc4abap_order_Dao.

  METHODS update_order
    IMPORTING
      is_dao_update_data TYPE s_dao_update_data.

  METHODS delete_order
    IMPORTING
      is_order_key TYPE s_order_key.
ENDINTERFACE.
