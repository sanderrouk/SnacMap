# SnacMap
A test assignment for a company called Applaud

### Languages used: 
* Swift 3

### Cocoapods used:
* GoogleMaps
* Alamofire (v4.0)

### Additional info:
I used GoogleMaps instead of the MapKit api because I just felt like trying it out, additionally I believe that Google has the superior mapping service but the same implementation could be completed using the MapKit as all directions and places are queried from the Google directions API and the Facebook Graph Api respectfully.

### What this project demonstrates:
My ability to understand the MVC workflow, ability to use external frameworks using cocoapods, ability to use JSON requests to aquire data, ability to construct views programmatically, ability to use mapping services.

### Task description:
The traveler wants to see the route from from Põlva, Estonia to Tallinn, Estonia. The traveler will want to have a lunch in the middle of his trip. Please, find 10 restaurants nearby the center of the route and display them on map. Tapping the marker should reveal number of Facebook likes that this place has.

## Additional comments:
I believe that instead of Facebook likes getting the rating from Google would be a better aproach. This is because Google's place API is more exact and knows about more locations than Facebook does. It is especially evident in Estonia because on some routes for example Jõgeva -> Tallinn the api has trouble finding restaurants near the center of the route. It works better on some routes such as Tartu -> Tallinn. The Google API would handle finding locations better, but since the task was to use Facebook likes the graph api was used to find nearby locations instead of the Google places one.

### Defining the midpoint:
The middle of the route is considered to be the midpoint of the journey on the road instead of the exact midpoint of the two locations.
