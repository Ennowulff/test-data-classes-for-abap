INTERFACE zif_tdc4abap
  PUBLIC.
  CONSTANTS c_order_id_any        TYPE ztdc4abap_order_id      VALUE '1'.
  CONSTANTS c_order_id_other      TYPE ztdc4abap_order_id      VALUE '2'.
  CONSTANTS c_order_id_further    TYPE ztdc4abap_order_id      VALUE '3'.
  CONSTANTS c_order_id_init       TYPE ztdc4abap_order_id      VALUE ' '.
  CONSTANTS c_order_id_unknown    TYPE ztdc4abap_order_id      VALUE '0'.

  CONSTANTS c_order_type_standard TYPE ztdc4abap_order_type    VALUE 'S'.
  CONSTANTS c_order_type_express  TYPE ztdc4abap_order_type    VALUE 'E'.

  CONSTANTS c_dlv_prio_high       TYPE ztdc4abap_delivery_prio VALUE 'H'.
  CONSTANTS c_dlv_prio_medium     TYPE ztdc4abap_delivery_prio VALUE 'M'.
  CONSTANTS c_dlv_prio_low        TYPE ztdc4abap_delivery_prio VALUE 'L'.
  CONSTANTS c_dlv_prio_any        TYPE ztdc4abap_delivery_prio VALUE ' '.
ENDINTERFACE.
