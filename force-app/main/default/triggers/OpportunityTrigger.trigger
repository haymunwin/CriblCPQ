trigger OpportunityTrigger on Opportunity(after update) {

  OpportunityTriggerHandler handler = new OpportunityTriggerHandler();
  handler.afterUpdate(Trigger.new, Trigger.oldMap);
  
}