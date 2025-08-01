INTERFACE zif_tdc4abap_msg_handler
  PUBLIC.
  TYPES: BEGIN OF ts_message,
           text TYPE string,
         END OF ts_message.
  TYPES tt_message TYPE STANDARD TABLE OF ts_message WITH EMPTY KEY.

  METHODS get_messages
    RETURNING
      VALUE(rt_message) TYPE tt_message.
ENDINTERFACE.
