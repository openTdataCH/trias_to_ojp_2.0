# trias_to_ojp_2.0
Draft of XSLT (and server associcated) to do a trias -> ojp 2.0 transform, which allows clients to use trias and to connect in the background to an OJP 2.0 service.  Currently only a draft for some request parts. PoC

# Supported functionality
If something is missing that you need, then we need to extend the xslt.

## Location Information Service
### Request

* InitialInput/Name
* InitialInput/GeoPosition
* InitialInput/GeoRestriction/Circle
* Params/NumberOfResults
* Params/Type
* Params/IncludePtModes


### Response
all TODO

## Stop Event Service
### Request

* Location/LocationRef/StopPointRef
* TODO: Location/LocationRef/StopPlaceRef
* Location/DepArrTime
* Params/NumberOfResults
* Params/StopEventType
* Params/IncludePreviousCalls
* Params/IncludeOnwardCalls
* Params/IncludeRealtimeData

### Response
all TODO

## Trip Service
### Request

* Origin/LocationRef/StopPointRef
* TODO: Origin/LocationRef/StopPlaceRef
* TODO: Origin/LocationRef/GeoPosition
* Origin/DepArrTime
* Destination/LocationRef/StopPointRef
* TODO: Destination/LocationRef/GeoPosition
* Destination/DepArrTime
* TODO Via/ViaPoint/StopPointRef
* TODO Via/ViaPoint/StopPlaceRef
* Params/NumberOfResults
* Params/IncludeTrackSections
* Params/IncludeLegProjection
* Params/IntermediateStops

### Response
all TODO

## Trip Info Service

### Request
* JourneyRef
* OperatingDayRef
* Params/UseTimetabledDataOnly
* Params/IncludeCalls
* Params/IncludePosition
* Params/IncludeService

### Response
all TODO

# XSLT 1.0
The core are two xslt:
* One transforms trias requests into ojp 2.0 requests: 'trias_to_ojp2.0_request.xslt'
* One transforms ojp 2.0 responses to trias responses: 'trias_to_ojp2.0_response.xlst'

Currently, a first draft of the first xslt is really done

We use mostly subtemplates for common elements and "functions".

# Programs
* server.py: the service
* test_client.py: a simple test client
* test_transform.py: the test program for the transforms

All are currently in a PoC state.

# TODO
* Requests: Placeref better
* Responses: Do a first draft

# Adminstrative stuff
## License
AGL 3.0

## Author
Matthias Günter

## Contact
opendata@sbb.ch
