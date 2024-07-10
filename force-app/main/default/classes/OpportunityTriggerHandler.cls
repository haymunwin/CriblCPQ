public with sharing class OpportunityTriggerHandler {
  public static boolean firstRun = true;

  public void afterUpdate(
    List<Opportunity> newItems,
    Map<Id, Opportunity> oldItems
  ) {
    /*
     * Logic for after update
     */
    List<ClosedWon_Event__e> eventlist = new List<ClosedWon_Event__e>();
    for (Opportunity opp : newItems) {
      if (
        opp.StageName == 'Closed Won' &&
        oldItems.get(opp.Id).StageName != opp.StageName
      ) {
        ClosedWon_Event__e evt = new ClosedWon_Event__e(
          OpportunityId__c = opp.Id
        );
        eventlist.add(evt);
      }
    }

    //publishing events
    List<Database.SaveResult> results = EventBus.publish(eventlist);

    // error handling
    for (Database.SaveResult sr : results) {
      if (sr.isSuccess()) {
        System.debug('Successfully published event.');
      } else {
        for (Database.Error err : sr.getErrors()) {
          System.debug(
            'Error returned: ' + err.getStatusCode() + ' - ' + err.getMessage()
          );
        }
      }
    }
  }
}
