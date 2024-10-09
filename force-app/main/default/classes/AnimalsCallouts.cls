public with sharing class AnimalsCallouts {

    /* classe wrapper */
    public class AnimalWrapper {
        public List<String> animals {get; set;}
    }

    
    /* metodo per chiamata get */    
    public static List<AnimalWrapper> makeGetCallout(){
        List<AnimalWrapper> result;
        String endpointUrl = 'https://th-apex-http-callout.herokuapp.com/animals';

        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpointUrl);
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/json');

        Http http = new Http();
        HttpResponse res = http.send(req);

        if (res.getStatusCode() == 200) {
            /* la risposta è un oggetto con una lista alla chiave animals, non una lista */
            AnimalWrapper resultWrapper = (AnimalWrapper) JSON.deserialize(res.getBody(), AnimalWrapper.class);
            result = new List<AnimalWrapper>();
            result.add(resultWrapper);
            /* sbagliato 
            result = (List<AnimalWrapper>) JSON.deserialize(res.getBody(), List<AnimalWrapper>.class); */
            System.debug(result);
            for (AnimalWrapper a : result) {
                for (String an : a.animals) {
                    System.System.debug(an);
                }
            }
        } else {
            System.debug('Error: ' + res.getStatusCode() + ' - ' + res.getStatus());
        }
        return result;
    }

    /* metodo per chiamata post */
    public static List<AnimalWrapper> makePostCallout(){
        List<AnimalWrapper> result;
        String endpointUrl = 'https://th-apex-http-callout.herokuapp.com/animals';

        /* creo la richiesta http */
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpointUrl);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');

        /* ci aggiungo i dati da mandare in post in json*/
        String body = '{"name":"mighty moose"}';
        req.setBody(body);

        /* invio la richiesta http */
        Http http = new Http();
        HttpResponse res = http.send(req);

        /* aggiungo 201 altrimenti non vedo risposta */
        if (res.getStatusCode() == 200 || res.getStatusCode() == 201) {
            /* la risposta è un oggetto con una lista alla chiave animals, non una lista */
            AnimalWrapper resultWrapper = (AnimalWrapper) JSON.deserialize(res.getBody(), AnimalWrapper.class);
            result = new List<AnimalWrapper>();
            result.add(resultWrapper);
            /* sbagliato 
            result = (List<AnimalWrapper>) JSON.deserialize(res.getBody(), List<AnimalWrapper>.class); */
            System.debug(result);
            for (AnimalWrapper a : result) {
                for (String an : a.animals) {
                    System.System.debug(an);
                }
            }
        } else {
            System.debug('Error: ' + res.getStatusCode() + ' - ' + res.getStatus());
        }
        return result;
    }
}