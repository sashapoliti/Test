@isTest
public with sharing class AnimalsCalloutsMock implements HttpCalloutMock {
    
    public HttpResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        Map <String, Object> mockMap = new Map<String, Object>{
            'animals' => new List<String>{'animale 1', 'animale 2', 'animale 3'}
        };
        response.setBody(JSON.serialize(mockMap));
        response.setStatusCode(200);
        return response;
    }
}