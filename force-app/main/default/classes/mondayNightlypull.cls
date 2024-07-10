public with sharing class mondayNightlypull implements Schedulable {
  public void execute(SchedulableContext sc) {
    try {
      // Perform HTTP callout to Monday.com
      // I would create a named credential in real life, but i would skip for now for demo purpose
      HttpRequest req = new HttpRequest();
      req.setEndpoint('https://api.monday.com/v2');
      req.setMethod('GET');
      req.setHeader('Authorization', 'REPLACE_API_KEY');

      Http http = new Http();
      HttpResponse res = http.send(req);

      // Process response
      if (res.getStatusCode() == 200) {
        // assuming we get the opportunity data back
        List<Opportunity> nightlyOpps = parseOpp(res.getBody());
        upsert nightlyOpps;
      } else {
        // Log error
        String errorMessage =
            'Error occur with Status code: ' +
            res.getStatusCode() +
            ', Status: ' +
            res.getStatus();
          //In real life we can log this error in error logging custom object
          System.debug('errorMessage');
      }
    } catch (Exception e) {
      String errorMessage = 'Exception during HTTP callout: ' + e.getMessage();
      //In real life we can log this error in error logging custom object
      System.debug('errorMessage');
    }
  }

  private List<Opportunity> parseOpp(String responseBody) {
    // logic to pare the response body
    List<Opportunity> returnOpp = new List<Opportunity>();
    return returnOpp;
  }
}
