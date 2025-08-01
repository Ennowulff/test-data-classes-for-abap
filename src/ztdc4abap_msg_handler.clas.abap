CLASS ztdc4abap_msg_handler DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS create
      RETURNING VALUE(ro_msg_handler) TYPE REF TO zif_tdc4abap_msg_handler.
  PROTECTED SECTION.
  PRIVATE SECTION.
    data mt_message type zif_tdc4abap_msg_handler=>tt_message.
ENDCLASS.



CLASS ztdc4abap_msg_handler IMPLEMENTATION.
  METHOD create.

  ENDMETHOD.

ENDCLASS.
