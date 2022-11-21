# FVP_DVBI_conversion-

Before Running the LCN_Request.py

1- Generate a Timestamp and hash with the client certificate (Expired every 2days!):
- The certificate should be stored on ~/.TLS for Linux or .ssh/ for mac.

-> Open a terminal and run the following command: curl -x http://www-cache.rd.bbc.co.uk:8080 --cert /Local_PATH/AMASS_MDS.pem -I https://auth.freeviewplay.net

- That will return a new auth timestamp and hash pair:
    * x-auth-timestamp and x-auth-hash
- The request will also return the MDS baseurl that we will use to request the CLMconfig from the root of the MDS baseurl and the CLMassignment:
    * x-baseurl: http://api.freeviewplay.net


2- Construct the LCN request:
-First we need to construct the CLMconfig request from the root of the MDS baseurl retrieved from the last request:
    * https://api.freeviewplay.net/CLMconfig
   The parameters for the request are already set on the Lcn_request.py
- Then we request the CLMassignment using the baseurl :
    * https://api.freeviewplay.net/1.7/CLMassignment
  The url is of the form CLMbaseurl/mux-list-interactiveflag-accesstoken:
  The Mux list is a string of form xxxx.yyyy_xxxx.yyyy_xxxx.yyyy where xxxx is the network_id of the mux, and yyyy tsid of the mux.
  For this request, we are using London Muxes:
    * 3033.1044_3033.2005_3033.4084_3033.3006_3033.5040_3033.6040_3033.801f
    We will add -1- that means interactive scan, and no access token is needed since this is initial query.
     That mux-list should return a service-list.



SUMMARY:
# MDS_DVBI

Generate Pair
Run LCN_req
=> result CLMconfig
=> CLMassig.xml
Run xsltproc transf-CLMresp.xsl CLMassig.xml
Run London-services.py

