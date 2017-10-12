public class RESTLimitResource {
    
    public static String JSONtext {get;set;}

    @AuraEnabled
    public static  String getlimits(){
    
    return getLimitsResp().getBody();
    }
   
    public static HttpResponse getLimitsResp() {
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        req.setMethod('GET');
     
        String baseurl = System.URL.getSalesforceBaseURL().toExternalForm() ;
		String url = baseurl+'/services/data/v39.0/limits';
		PageReference newPage = page.sessionIdGenerator;
		string sessionId = getSessionIdFromVFPage(newPage);
        req.setHeader('Authorization', 'OAuth '+sessionId);//userinfo.getSessionId());
      
        //userinfo.getsessionId()
        req.setEndpoint(url);
        return  http.send(req);
    }
    
    
    public static String getSessionIdFromVFPage(PageReference visualforcePage){
        String content = visualforcePage.getContent().toString();
        Integer s = content.indexOf('Start_Of_Session_Id') + 'Start_Of_Session_Id'.length(),
                e = content.indexOf('End_Of_Session_Id');
        return content.substring(s, e);
    }
}