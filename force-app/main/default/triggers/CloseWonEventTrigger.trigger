trigger CloseWonEventTrigger on ClosedWon_Event__e(after insert) {
    CloseWonEventTriggerHandler.afterInsert(Trigger.New);
}