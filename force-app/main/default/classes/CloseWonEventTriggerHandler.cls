public with sharing class CloseWonEventTriggerHandler {
  @InvocableMethod
  public static void afterInsert(List<ClosedWon_Event__e> events) {
    for (ClosedWon_Event__e event : events) {
      try {
        HttpRequest req = new HttpRequest();
        // I would set up a namespace credential in real life for the following information. But I would skip for now for demo purpose

        req.setEndpoint('https://api.monday.com/v2');
        req.setMethod('POST');
        req.setHeader('Authorization', 'REPLACE_API_KEY');
        req.setHeader('Content-Type', 'application/json');
        req.setBody(JSON.serialize(event));

        Http http = new Http();
        HttpResponse res = http.send(req);

        // Handle response and log errors
        if (res.getStatusCode() == 200 || res.getStatusCode() == 201) {
          System.debug('HTTP Response: ' + res.getBody());
          // Handle successful response
        } else {
          String errorMessage =
            'Error occur with Status code: ' +
            res.getStatusCode() +
            ', Status: ' +
            res.getStatus();
          //In real life we can log this error in error logging custom object
          System.debug('errorMessage');
        }
      } catch (Exception e) {
        String errorMessage =
          'Exception during HTTP callout: ' + e.getMessage();
        //In real life we can log this error in error logging custom object
        System.debug('errorMessage');
      }
    }
  }
}
