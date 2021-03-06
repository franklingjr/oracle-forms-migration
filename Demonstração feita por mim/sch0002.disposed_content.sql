ALL LINES DISPOSABLE: ALL LINES READ WERE CONSIDERED DISPOSABLE (BECAUSE ALL LINES ARE EITHER ORACLE FORMS PL/SQL ROUTINES OR CUSTOM ROUTINES), SO THE ROUTINE WAS DISCARDED.
ALL LINES DETECTED AS DISPOSABLE: ALL LINES READ WERE CONSIDERED DISPOSABLE BECAUSE THEY CALLED PROGRAM UNIT(S) DETECTED AS DISPOSABLE, SO THE ROUTINE WAS DISCARDED.
CUSTOM ORACLE FORMS DATA BLOCK: THIS BLOCK WAS MARKED AS DISPOSABLE UNDER CUSTOM CONFIGURATIONS.
CUSTOM BLOCK TRIGGER: THIS BLOCK TRIGGER WAS MARKED AS DISPOSABLE UNDER CUSTOM CONFIGURATIONS.
CUSTOM BLOCK.ITEM TRIGGER: THIS ITEM TRIGGER WAS MARKED AS DISPOSABLE UNDER CUSTOM CONFIGURATIONS.
CUSTOM FORM TRIGGER: THIS FORM TRIGGER WAS MARKED AS DISPOSABLE UNDER CUSTOM CONFIGURATIONS.
CUSTOM PROGRAM UNIT: THIS PROGRAM UNIT WAS MARKED AS DISPOSABLE UNDER CUSTOM CONFIGURATIONS.
INVALID TRIGGER NAME: THIS TRIGGER HAS AN UNRECOGNIZED NAME WHICH DOES NOT RUN UNDER ORACLE FORMS.

-- FN_WHEN_NEW_FORM_INSTAN_0000_B
-- SOURCE: "FORM TRIGGER" WHEN-NEW-FORM-INSTANCE
-- REASON: ALL LINES DISPOSABLE

BEGIN
   set_window_property ('W_SCHOOL_MEMBERS', window_state, maximize);
   go_block ('T_SCHOOL_MEMBERS');
   execute_query;
END;


-- FN_WHEN_BUTTON_PRESSED_0005_B
-- SOURCE: "BLOCK.ITEM TRIGGER" T_SCHOOL_MEMBERS.BT_LOV_SCH_ID.WHEN-BUTTON-PRESSED
-- REASON: ALL LINES DISPOSABLE

BEGIN
   go_item ('T_SCHOOL_MEMBERS.sch_me_sc_id');
   list_values;
END;


-- FN_WHEN_BUTTON_PRESSED_0007_B
-- SOURCE: "BLOCK.ITEM TRIGGER" T_SCHOOL_MEMBERS.BT_LOV_SCH_MT_ID.WHEN-BUTTON-PRESSED
-- REASON: ALL LINES DISPOSABLE

previous_item;
do_key ('list_values');


