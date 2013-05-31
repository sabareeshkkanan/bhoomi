bhoomi
======



CALIFORNIA STATE UNIVERSITY SAN MARCOS
Computer Science Department



GPS and Compass Aided Augmented Campus Guide


Project Report for CS 698
by
Sabareesh Kannan Subramani
April 2013 
Abstract
Augmented Reality (AR) is a view of a physical, real-world environment in real-time in which some elements are augmented by computer-generated object such as sound, video, graphics or plain text. Early stages of AR primarily used head-mounted display that includes a helmet and a display screen. To support such display, people need to carry computers with them to process complex calculations. But as mobile devices started to house powerful processors as well as sensors such as GPS and compass, researchers are now able to use mobile devices for running AR applications. Computer vision has been commonly used in AR applications to track objects in the real world and determine what virtual objects should be augmented based on the tracking information from the real world. However, image recognition is an expensive process. The GPS and Compass Aided Augmented Campus Guide project proposes a method to identify a landmark without image recognition. The system is composed of two parts, backend database and a frontend iPad application. The database consists of GPS coordinates of landmarks and iPad application uses them to identify landmarks by comparing them with geo location and compass heading of the device. Landmark boxes are augmented to the user screen in real-time as they come into the camera view of the device. Events associated with a landmark are stored either in database or in the user’s calendar. The application adds them to the user view when the user is interested in a landmark. In addition, this application allows tagging of a 3d object at a location. These 3d objects are augmented to the user view when he/she approaches the location. The implementation of this project demonstrates greater understanding and integration of sensor GPS, compass, gyroscope with native iOS applications.
 
Table of Contents
1  Background	5
2	Project Overview	8
2.1	Project Scope	8
2.2	Web Interface for Collecting GPS Coordinates of Landmarks	15
3	Key Technology	17
3.1	iOS Apps	17
3.2	MongoDB	18
3.3	Apache Web Server	19
4	Project Design & Implementation	20
4.1	Database Design	20
4.1.1	Collection – landmarks	21
4.1.2	Collection – events	23
4.1.3	Collection- Media	24
4.1.4	Collection – threeD	24
4.2	Exchange between MongoDB and iPad App	25
4.3	IOS Application	27
4.3.1	Models	27
4.3.2	Locating Landmark	28
4.3.2.1	User inside a landmark	29
4.3.2.2	Camera viewing angle and Compass	29
4.3.2.3	Angle of a GPS coordinates against the user location	30
4.3.2.4	Determining whether a point is within camera viewing angle	32
4.3.2.5	Selecting Two Optimal Points in Landmark	33
4.3.2.6	Using landmark anchors to determine the location of landmark	34
4.3.2.7	Calculating box location of landmark	34
4.3.3	Views and their Controllers	35
5	Concluding Discussions	38
6	Acknowledgements	40
7	References	41



Table of Figures
Figure 1.1 ARMAR, an AR application from Columbia University	6
Figure 1.2 Word Lens – a Mediated Reality application from Quest Visual	6
Figure 1.3 Virtual reality in marine	7
Figure 1.4 Google glasses	7
Figure 1.5 AR Paris - an AR application based on GPS and compass	8
Figure 1.6 Wikitude	9
Figure 2.1 Permission to access current location and calendar	10
Figure 2.2 Application Home View	10
Figure 2.3 View when inside a landmark	11
Figure 2.4 Displays list of events and schedules at landmark	12
Figure 2.5 Sample Detail View of an event	13
Figure 2.6 Sample Detail view of the event with video	14
Figure 2.7 Augmented 3d Object	15
Figure 2.8 Select landmark type	16
Figure 2.9 Sample view shows adding new location	16
Figure 3.1 Viewing and editing a document in Rock Mongo	19
Figure 4.1 Overall designs	20
Figure 4.2 Relationship between collections	21
Figure 4.3 Class Hierarchies	25
Figure 4.4 Spatial Query	26
Figure 4.5 Sample response from the server	27
Figure 4.6 Checking if user is inside landmark	29
Figure 4.7 Viewing Angle	29
Figure 4.8 Calculating Angle between two points	30
Figure 4.9 Method used to find angle between two points	31
Figure 4.10 Quadrant adjustment	31
Figure 4.12 Choosing landmark anchors	33
Figure 4.13 Method calculateAngleBAC	34
Figure 4.14 Calculating button location	35
Figure 4.15 Arrangement of different views	35
Figure 4.16 Controllers	36
Figure 4.17 Method that initiates camera view	37
Figure 4.18 Event handler didSelectRowAtIndexPath	38
Background
Augmented Reality (AR) is a view of a physical, real-world environment in real-time in which some elements are augmented by computer-generated object such as sound, video, graphics or plain text [1]. These augmented objects may deliver some information about the objects in the real world. For example, Figure 1.1 shows an AR application called Augmented Reality for Maintenance and Repair (ARMAR) developed by Columbia University [2] that is used by U.S Marine Corps to train technicians. The application uses headgears to project an animated screwdriver as a 3-D computer graphics onto the equipment under repair, labeling parts and giving step-by-step guidance to technicians.
 
Figure 1.1 ARMAR, an AR application from Columbia University
AR is related to a more general concept called Mediated Reality. Mediated Reality can either add or remove an object from the real world but AR is more about adding new objects to the world. Figure 1.2 shows Word Lens, an application developed by Quest Visual [3] to identify text held up on a poster and replace the original text with the translated text in a user chosen language on the device viewer.
 
Figure 1.2 Word Lens – a Mediated Reality application from Quest Visual
AR enhances one’s current perception of reality by adding new objects to the real world. By contrast Virtual Reality replaces the real world with a simulated one.  Figure 1.3 shows a soldier wearing a head mounted display to navigate in a virtual battlefield where virtual avatars are added as the target for shooting [4]. 
 
Figure 1.3 Virtual reality in marine
In general there are two methods in which objects can be augmented into the real world. Figure 1.4 shows a pair of Google glasses [5] that are wearable and connected through Bluetooth to a mobile phone. This is a good example of the first method in which objects are projected into a semitransparent glass in order to add to the real world. In the second method, camera is used to capture the real world and the objects will be overlaid on the stream from the camera and displayed in a screen [5]. A good example for the second method is shown in Figure 1.2 where the translated text is displayed on the device screen.
 
Figure 1.4 Google glasses
Early stages of AR primarily used head-mounted display that includes a helmet and a display screen. To support such display, people need to carry computers with them to process complex calculations. But as mobile devices started to house powerful processors as well as sensors such as GPS and compass, researchers are now able to use mobile devices for running AR applications. Augmentation of objects can be invoked by different methods based on the nature of an application. Initially people used computer vision to track objects in the real world and determine what virtual objects should be augmented based on the tracking information from the real world. For example, in Figure 1.1, markers are placed on real world objects to identify the type of activity and object that need to be augmented.  Image processing is used to identify a marker and the augmented objects are positioned by the angle of the marker to accurately display them.
A paper [21] authored by Wei Guan, Suya You, Ulrich Neumann describes a user tracking and augmented reality system that works in extreme large-scale areas. To identify a building, their approach compares the image captured by a user’s device against an image collection in the database. By tagging each image in the database with location information, the number of images needs to be compared is constrained to particular location. However, image recognition still requires a lot of computational power. Image recognition is used to identify the building because GPS doesn’t give any information about the camera pose. Figure 1.5 is an AR application called AR Paris developed by Presselite [6] for iPhone. It uses GPS and compass information to locate a landmark from the user location and augments the user view with food services and subway stations near the user location. 
 
Figure 1.5 AR Paris - an AR application based on GPS and compass
Another application that uses similar approach is Wikitude [22], which uses GPS and Compass data at user location to identify landmarks. Wikitude maintains a database of landmarks with their location and from its mobile application it uses the user’s location and compass to identify a landmark. As shown in Figure 1.6, this application augments information about a landmark such as user reviews, facilities and information from Wikipedia. 
 
Figure 1.6 Wikitude
Project Overview
Project Scope
The scope of this GPS and Compass Aided Augmented Campus Guide is to provide people with a more visual guide of the campus by marking important campus features and augmenting event information based on a user’s location. Students and professors are the targeted audience for the application. When a user points his/her iPad at a landmark on campus, the application will mark all landmarks in current camera view. A landmark can be a statue, building, gathering area, playground etc. The application requires Internet connection to quickly acquire current GPS position and also to get information from a server based on the current location. If the user has moved away farther than 500 meters from the last location where it got data about the landmarks and 3d object tagged around the user location it will again poll the server to update the data about the new location.
This application requires permission from the user to access sensor data and calendar from the device. When the application is launched for the very first time it will prompt the user to grant permission to access calendar and GPS sensor. Figure 2.1 shows the application asking for permission. Once the permission is granted it will not prompt the user again in the future. When the application is launched, the initial view for the user will be the direct live view from the camera of the device without any augmented object. 
   
Figure 2.1 Permission to access current location and calendar
The application uses only the rear camera of the device. When a landmark is within the camera-viewing angle, a box will be augmented to the screen displaying the name of the landmark along with the straight-line distance from the user’s position to the landmark. Figure 2.2 shows an example of the home view, which is augmented by landmark boxes as the user is walking along the path from the Arts building toward Kellogg Library. When multiple landmarks are in the current view, the application displays the boxes from top to bottom based on the distance from the user’s location.  Closer landmarks are displayed on the top and farther ones at the bottom. These boxes will floats left and right based on the viewing angle of the landmark. 
 
Figure 2.2 Application Home View
The application also notifies the user if he/she is inside a building by displaying the landmark box on the top right corner showing “You are inside landmark name”. This box will not float but stay on the top right corner until the user moves out of the landmark. Figure 2.3 shows how the application displays a landmark box on the top right corner when the user is inside Parking Structure. The Parking Structure box will not float and will stay static at the position and it is distinguished from the other boxes by an orange outline in the box. However, other boxes will float.
 
Figure 2.3 View when inside a landmark
The user can click on a landmark box to display public events and personal meetings in the particular landmark that are scheduled within a week. Public events are retrieved from a database on the server. Personal meetings are grabbed from the user’s personal calendar. The selected landmark box will be highlighted with green color to differentiate from other landmarks. Figure 2.4 shows an example view when the user taps the Arts Building box. The application augments a list of events that are scheduled in the “Arts” building. The events are arranged based on their timestamps. The camera view background is dulled indicating that it is not accessible until the user goes back to the home screen.

 
Figure 2.4 Displays list of events and schedules at landmark
To get more details about a particular event, the user can touch the event on the list. The application will display a detail view of the event. The user can go back to the home screen either by double tapping anywhere in the camera view or by tapping the Home button at the top right corner. Figure 2.5 shows how an event will be displayed with detailed information when the user touched on the event from Figure 2.4. It displays the start and end time of the event along with the notes about the event. The detail view can also hold multimedia contents such as image and video. 
 
Figure 2.5 Sample Detail View of an event
The detail view in Figure 2.5 is scrollable so that the contents can be more than one page. The detail view can display more than one image but hold only one video player. Figure 2.6 shows how a video is played in the detail view. Users can navigate back to view the event list associated with the landmark by tapping the navigation button at the top navigation bar in the left, which is captioned to the landmark name. From here user can double tap at any place other than the content displayed to go back to home view.
 
Figure 2.6 Sample Detail view of the event with video
The application allows tagging of a 3d object at any geo location.  These 3d objects are augmented onto the screen when the user is at a distance less than 50 meters to the tagged location and they are viewing at the tagged location in the camera. These objects float left and right as well as top and bottom based on the position of the device. Hovering left and right is based on whether the tagged location of the object is on the left or right side of the camera view. The vertical location of the object is based on the vertical angle of the device’s current view. Figure 2.7 shows two example views of a 3d airplane. The size of the model is scaled based on the distance between the tagged location and the user. The airplane in the right image is bigger than the one shown in the left image because the user is closer to the tagged location. Scaling of the 3d object is done to simulate the illusion that object appears smaller when it is farther. Models are also rotated based on the angle from which the user is viewing. For example, in the left image, the user is viewing the object from the angle of 80 degrees with respect to the geometric north while the view for the right image is captured when the user is almost at 340 degrees. 
  
Figure 2.7 Augmented 3d Object

Web Interface for Collecting GPS Coordinates of Landmarks
The application uses a database to store landmarks, events and reference to the media elements on the server. GPS coordinates are used to identify landmarks. For smaller landmarks such as a statue or a store, it is enough to use one GPS coordinates. However, for a large building, the application uses four GPS coordinates to increase the accuracy for the device to locate the building. In most cases these four coordinates identify the four corners of the building. A web interface has been created as part of the project for administrative purpose to add a new landmark to the server database. Please note that this web interface is designed to collect GPS coordinates for the landmarks used in the application. It does not support the collection of other data of the application such as information related to public or personal events. Nor does it support tagging of 3D objects to locations. Figure 2.8 shows the web interface. This webpage can be accessed through https://ar.seedspirit.com. It asks the user for permission to access the location of the user so that it can load the map that is around the user and the zoom level is set to give a bird’s eye view of the current location. If the user denies giving access then it loads the map of USA in a zoomed out view and then the user can select a location and zoom in to add new landmark. 
 
Figure 2.8 Select landmark type
As shown in Figure 2.8, the user can select the type of landmark they are adding to the database as either a single point or a quadrilateral. Figure 2.9 shows the view after the user selects Quadrilateral as the option where four coordinates identify a landmark. To specify a point in a quadrilateral location, the user first selects the radio button for the point and then clicks a spot on the map to place a marker. The corresponding latitude and longitude for the spot will be automatically displayed. The user can also enter other properties of the landmark such as the name of the landmark and alternate names. Alternate names are helpful in associating a landmark with location of events in case people use other names for the same location.
 
Figure 2.9 Sample view shows adding new location
Key Technology
iOS Apps
Xcode 4.6 is the primary development environment for building the iPad application for the project. Xcode is Apple's powerful Integrated Development Environment (IDE) for creating great apps for Mac, iPhone, and iPad. It includes an iOS Simulator, which was very helpful while working on loading the 3d objects to the screen, and the latest Mac OS X and iOS SDKs. Objective C is the primary language that is used to develop this project. Objective C is an object-oriented extension of C and Apple develops it. Xcode comes along with a modified GNU Compiler collection and gcc compiler.
Apple uses the Model View Controller (MVC) pattern a lot in the iOS SDK and it becomes a common practice to use this pattern in iOS development. While developing this application MVC pattern was very helpful in dividing application into modules. Models are created to represent landmark and event data. Controllers are created to handle models and display them using views. Most of iOS applications make use of Storyboard or .xid file to design their user interface. But in this application, the user’s view is fixed with the rear camera view. Additional UI components are programmatically augmented onto the camera view based on user location and sensor data. Each UI component such as a button, label etc. is a view in Objective-C and can also be added to the main view as a sub view. Buttons are used in the application to display landmarks. A Table View is used to display the list of events for a landmark because it is structured to support table cell objects so that each event can respond to user interaction. A Scroll View is used to display the detail view of an event because it has a built in horizontal and vertical scroll based on the size the scrolling area in relation to the size of the view. Each View can then be associated with a ViewController class that handles UI events based on the type of view it is controlling. For example, EventsViewController supports the cell selection and deselection events of a TableView. NavigationViewController is responsible for handling navigation between the detail view and the table view which displays list of events.
OpenGl (Open Graphics Library) [11] is a cross-language multiplatform API for rendering 2D and 3D computer graphics. The API is typically used to interact with a Graphics Processor Unit (GPU) to achieve hardware-accelerated rendering. There are several 3dengines that are developed on top of OpenGl such as cocos3d [12], unity3d [13] to reduce the complexity in interfacing and focus on development. This application only requires displaying of 3d objects and manipulating them with sensor data. It uses a 3rd party library called Wavefront Object Loader [14] that can load 3d objects to the camera view from the Wavefront object file [15]. This library uses OpenGLES1 to interact with GPU. This library is modified to fit the purpose of this application.
MongoDB
A MongoDB database is used for this project, which is housed on a dedicated secure server. MongoDB (from "humongous") is an open source document-oriented database system [9] developed and supported by 10genmongo [16]. It is part of the NoSQL [20] family of database systems. Instead of storing data in tables in a "classical" relational database, MongoDB stores structured data as JSON-like documents with dynamic schemas (MongoDB calls the format Binary JSON- BSON), making the integration of data easier and faster. Foursquare [17] uses MongoDB as the spatial database, Craigslist [18] use it for archiving the contents.
MongoDB databases are not relational databases. They are schema free, which provides a lot of freedom for this project to design its database. Each property in a document can be of any length and any type. In addition, the length and type of a property are mutable. Documents in a collection don’t need to follow a specific schema. They can differ from each other. MongoDB also supports the spatial feature, which allows this project to store latitude and longitude of a location as a 2d coordinates in the database. This feature allows us to query the database based on the device location to get all the available points in a given range, reducing lot of overheads in checking each point to find its distance from the desired point. 
The project uses Rock Mongo [19] to add events data including text notes and URLs for video and image files to its database. Rock Mongo is a web based admin console for managing MongoDB. It has following features 
	Database – Query, create, drop, repair, execute commands and JavaScript codes, export and import database.
	Collection – Query, insert, update, delete, duplicate and drop a collection. In addition, indices can be added to and dropped from collections.
To create a new document, the user has to enter the document either in JSON or array format. While editing, the same format will be displayed and the user can modify a property or add a new property.  In Figure 3.1 the left image shows how a document is displayed in JSON format and right image shows how a document can be edited in Rock Mongo in array format. 
  
Figure 3.1 Viewing and editing a document in Rock Mongo

Apache Web Server
Apache webserver is used in the backend to service the application. The webserver uses a secure connection to connect with the application. It uses 256-bit encrypted SSL certificate for the communications. The SSL certificate is a self-signed certificate. PHP is used as the main back end language. A special driver called mongo-php-driver [10] is installed in the server for PHP scripts to communicate with MongoDB. The Web UI of the project sends JSON data that contains user location and other attributes to the server. It calls PHP scripts to add landmarks and their related GPS coordinates into the database. The iPad application sends a POST request to the server using SSL in a JSON format containing the location of the current device. A PHP script queries the database based on the location information and sends related information back.
Project Design & Implementation
 
Figure 4.1 Overall Design
 Figure 4.1 shows the main components of the system and their interaction. Data about landmarks, events, and URLs for images and videos are stored in a MongoDB database on a server. The actual images and videos can be stored anywhere on the web. The iPad application depends on a web server to retrieve data from the database. Hypertext Transfer Protocol Secure (Https) protocol is used to communicate between server and the IPad. JSON data format is used in the communication between them. The iPad application sends user location information to the server and the server returns landmarks within a range of 1 km and events associated with the landmarks.
Database Design
In MongoDB, data are organized by collections and there is no need of a specific schema. A collection holds a set of documents. A document is a set of key-value pairs, commonly referred to as fields or properties. Documents have dynamic schema which means documents in the same collection do not need to have the same set of properties or structure. Common fields among documents in a collection can hold different types of data. For example a phone field can be just a string in a document and an array of strings in a different document of the same collection. The following subsection describes the collections that are required for the application.
 
Figure 4.2 Relationship between collections
Figure 4.2 illustrates the relationship among the collections. Each landmark can be associated with multiple events and each event can be associated with multiple media. Collection Media is mapped to the collection Events with the help of the property Media in the collection events which is an array consisting of media ids from the collection Media. Similarly collection Events is mapped to the collection Landmark by the property Events that consist of ids from the collection Events.
Collection – landmarks
This collection is used to store landmark data. Each document in the collection holds information about a single landmark. Each document has following properties
	Location is used to store the GPS coordinates. It has a sub property Location => loc defined as a spatial index to hold the GPS coordinates of the landmark.
	LocationName stores the name of the landmark.
	LocationType is used to specify what type of landmark (Polygon, Point).
	AltName is used to store alternate names for the landmark, which will help in associating a landmark with an event location.
	 _id is the unique identifier for each document in this collection. 
	User is used to store which user created this landmark.
	events is an array of event ids from the collection events that are scheduled at this particular landmark.
In MongoDB only a point can be defined as a spatial index. Therefore, landmarks are represented as 4 points instead of a polygon for spatial queries. 
 Below is one sample document in this collection.
array (
  
  'Location' => 
  array (
    '0' => 
    array (
      'name' => 'point1',
      'loc' => 
      array (
        '0' => -117.1599572897,
        '1' => 33.128647691065,
      ),
    ),
    '1' => 
    array (
      'name' => 'point2',
      'loc' => 
      array (
        '0' => -117.15926527977,
        '1' => 33.128690368932,
      ),
    ),
    '2' => 
    array (
      'name' => 'point3',
      'loc' => 
      array (
        '0' => -117.15949863195,
        '1' => 33.129507982997,
      ),
    ),
    '3' => 
    array (
      'name' => 'point4',
      'loc' => 
      array (
        '0' => -117.16017186642,
        '1' => 33.129600076412,
      ),
    ),
  ),
  'LocationName' => 'Library',
  'LocationType' => 'Polygon',
  'AltName' => 
  array (
    '0' => 'library',
  ),
  '_id' => new MongoId("50ad52f2d79588d42b000002"),
  'events' => 
  array (
    '0' => '50aa72c8d79588f064000000',
  ),
  'user' => 'root',
)
Collection – events
This collection has the information about all public events. Each document in the collection has information about a single event. 
	_id uniquely identifies each event document in the collection.
	Description is used to store description about the event
	Media is an array of media ids from the media collection that are associated with this event. 
	Name is used to store the name of the event.
	Notes is used to store extra notes about the event.
	StartDate stores the starting time of the event.
	EndDate stores the end time of the event.
	User is used to store which user created this event.
A sample document in this collection looks as follows
{
   array (
  '_id' => new MongoId("51150038d79588ec3d000000"),
  'description' => 'Dr. Ching-Ming Cheng, Assistant Professor of Music at CSUSM, offers an encore performance of concert piano. The concert will feature works by Beethove [...]',
    'media' => 
  array ( '0' =>  array (
      'id' => '511500b1d79588b912000001',
      'type' => 'image',
    ),
  ),
  'name' => 'CHING-MING CHENG SOLO PIANO CONCERT',
  'notes' => 'TICKET PRICES: All attendees including students must bring their printed ticket. CSUSM Students: FREE CSUSM Faculty/Staff: $10 Community Members: $20  [...]',
  'startDate' => '2013-02-26 19: 30: 00',
 'endDate' => '2013-02-26 21: 30: 00',
  'user' => '232',)}
Collection- Media 
This collection is used to store media information in the database. Each document in the collection identifies one image or video.
array (
  '_id' => new MongoId("511500b1d79588b912000001"),
  'name' => 'Ching-Ming',
  'type' => 'Image',
  'url' => 'http://25livepub.collegenet.com/i/DgCoPr38ttlPLquBKYfEgmpb.jpg',
  'user' => 'root',
)

It has _id, which is the unique identifier for a multimedia document. Alt is used to store the alternate text to be displayed in case the media fails to load. Name specifies the name for the media. Type specifies whether the media is an image or video. Url stores the location of the media file. 
Collection – threeD
This collection is used to store data about 3d objects. Each document in the collection has the following properties.
	_id is the unique identifier for each document in this collection.
	Filename specifies the name of the wave front object file.
	Location property is defined as a spatial index to hold the GPS coordinates for this 3d object.
	name is caption for the 3d object.
	url property specifies the root folder location of the 3d object as a http url.
Sample document for this collection is shown below.
array (
  '_id' => new MongoId("50a17e00d795889462000002"),
  'filename' => 'plane3.obj',
  'location' => 
  array (
    '0' => -117.15842172503,
    '1' => 33.1302020505,
  ),
  'name' => 'Aeroplane',
  'url' => 'https://ar.seedspirit.com/d3/cessna/',
  'user' => '',
)

 Exchange between MongoDB and iPad App
The communication between the server and the iPad application is done through https request of type POST. When the iPad application acquires the location of the device, it sends a new request to the server in JSON format that contains the current location information. Below is a sample JSON data sent to the server. Range specifies the range to look for landmarks. uid is the unique identifier of the device. Location specifies the device location longitude, latitude.
{"range":"1000",
“uid“:"B42D5087-E137-4FAD-A00C-9F23BE33FBEE";
"Location":[-117.2178718768129,33.12933730345718]}
A PHP script query.php on the server receives the request and queries the database for all landmarks and 3d objects within the given range from the current location of the device. Figure 4.3 shows how query.php works with other classes to solve a query from the iPad. query.php first checks to make sure the request is a POST request. Once verified, the script decodes the content from the received JSON string to an Array object. It creates an object of the Landmarks class and uses its populatewithLandmarks method to query the database and populate the $cursor object with actual events and media contents for each landmark within the range. Landmark.php script calls upon Events.php to fill event information, which in terms, calls upon media.php to fill the associated media information.
           
Figure 4.3 Class Hierarchies
The runCommand method of MongoDB takes a string argument to query the database and returns the result as a JSON object. A sample spatial query is shown below, which searches for all spatial data near the [-74, 40.74] point, taking into consideration that the Earth is a sphere. In this query, geoNear [24] indicates the collection from which the spatial query is performed, near specifies querying location, and spherical property is set to true for the 3d object like Earth.
db.runCommand( { geoNear: "places", near: [ -74, 40.74 ],                  spherical: true }  )
Figure 4.4 shows how query.php submits its query to the database. In addition to the geoNear, near, and spherical arguments as mentioned above, the query also specifies the following key-value pairs:
	num is used to specify number of results to be returned
	maxDistance specifies the distance between the near and the points in the collection.
	includeLocs if it is set to true then query will return the location of the matching document in the result which is useful when there is multiple indexes in the document.
	uniqueDocs takes a Boolean input when specified true it returns only unique documents as there is a possibility of multiple indexes in a document.
 
Figure 4.4 Spatial Query
Figure 4.5 shows a single landmark that is part of a sample response from the server when the application polls the server with its current location. This example shows that event ids in the events property of the landmarks collection are replaced by the corresponding event documents. Similarly media ids in the media property of the collection events are replaced by the corresponding media documents.
   
Figure 4.5 Sample response from the server
IOS Application
Models
This application applies the MVC design pattern extensively by creating model classes to hold key data items. 
	SensorData: This model class is used to store sensor information from various sensors, including the GPS, digital compass, gyroscope and accelerometer. This model is fed with data from the sensors and the value is updated whenever a request for the sensor data is requested. 
	AREvent: This model class is used to represent each event in a landmark. This model is directly instantiated by the Landmark class. An event could be a public event that is stored in the MongoDB database or a private event retrieved from the user’s calendar. Some of the properties of this model are alt, name, info, user, media (an array with multiple media elements) and event time. 
	Class Oracle is responsible to poll the server through ARCloud and create new landmark and 3d objects based on user location. It checks the current user location against the last polled location every 5 minutes; if the distance is greater than 500 meters then it polls the server for new data. ARCloud is capable of sending both POST and GET request using secure and non-secure connection. The main advantage of ARCloud is its asynchronous way of communication, which is made possible with the help of the delegate pattern. Delegates in objective –C is very similar to notifications in Java, which allows this class to callback a delegated method that requests data from the server. Following are the data handled by the Oracle class
	Array of Landmark objects for landmarks around the user.
	Array of 3d Objects tagged near the user location.
	Sensor data such as GPS location, compass heading, gyroscope and accelerometer.
	Landmark: Each landmark is represented using this model and the following are the key properties in this model.
	Locations –an array of Location objects each representing a GPS coordinates of the landmark.
	Events –an array of AREvents objects representing all of the events in the landmark. 
	Button –a UI box that represents a landmark in the User interface.
Locating Landmark
One of the important tasks for the iOS application is to identify whether a given landmark is within the camera view. The following subsections explain the technique used by the Landmark and Location classes to identify a landmark using its GPS coordinates and the geo location along with compass heading of the device. 
User inside a landmark
The application implements the Point Inclusion in Polygon Test (PnPoly) algorithm [25] to check whether the user is inside a landmark or not. The code snippet for implementing the algorithm is shown in Figure 4.6. Method pnpoly returns 0 if the user is not inside the landmark else value will be 1. 
 
Figure 4.6 Checking if user is inside landmark
Camera viewing angle and Compass
The rear camera of an iPad provides a viewing angle of 45 degree wide when the iPad is held up vertically. As shown in Figure 4.7, the arrow points to the direction of the compass, which divides the viewing angle into two equal sections of 22.5 degree.
 
Figure 4.7 Viewing Angle
Angle of a GPS coordinates against the user location
In this application, the angle of a landmark point against the user location is defined by the angle between the true north (geographic North Pole) and the line connecting the landmark point and the user location. In Figure 4.8, (x, y) is the location of the user and (x1, y1) is one of the points of a landmark. The plain is divided into four quadrants Q0 (Northeast), Q1 (Southeast), Q2 (Southwest) and Q3 (Northwest) based on geographic direction of (x1, y1) against (x, y). The angle of (x1, y1) in relation to (x,y) against the true north, Θ , is calculated by 
	Θ = 〖tan〗^(-1)  |x-x_1 |/(|y-y_1 |)
 
Figure 4.8 Calculating angle between two points
The code snippet in Figure 4.9 shows how Θ is calculated. In the code snippet the distance between two points is calculated by considering surface of the earth is curvature for better accuracy.
 
Figure 4.9 Method used to find angle between two points
The following algorithm converts the resulting angle into a 360-degree scale based on the quadrant on which the landmark coordinates fall. 
If (Quadrant is 0)
Angle=Angle
Else if (Quadrant is 1)
Angle= 180-Angle;
Else if (Quadrant is 2)
Angle=180+Angle
Else
Angle=360-Angle
The above algorithm is implemented by the code snippet in Figure 4.10. In this function point1 is the location of the user and point2 is one of the coordinates of the landmark. The latitude and longitude readings for the two points are compared to identify the appropriate quadrant. For example, point2 is in Q4 when its longitude is no more than that of point1 but its latitude is no smaller than that of point1.
 
Figure 4.10 Quadrant adjustment
Determining whether a point is within camera viewing angle 
Figure 4.11 Example viewing area with landmark points
Figure 4.11 shows different cases of a landmark coordinates in relation to the viewing angle of the camera. In the diagram,
	A is the location of the user and the dashed blue line is the compass heading. For illustration purpose it is assumed to be 135o from the geographic north.
	BAC defines the viewing angle of the camera, which is always 45o. Therefore, when the compass reading is at 135o from the North, B and C are at 112.5o and 157.5o respectively.
	Points x1, x2, x3, x4 are the sample locations of landmarks. The application calculates the difference between the compass heading and angles for each point. When the difference is within the range of -22.5o (x2) to 22.5o(x3), it means the point is within the viewing area. Otherwise, the point (x1 and x4) is outside the viewing area.
Selecting Two Optimal Points in Landmark
If a landmark constitutes only one geo-point, we can directly compare the angle of the point against the user location with the compass reading. However, if a landmark has 4 geo-coordinates, locating the landmark accurately needs a different approach. This approach involves selecting two coordinates called landmark anchors that makes the largest angle against the user location among all point pairs of the landmark. Figure 4.12 shows the importance of using different coordinate pairs as landmark anchors based on the user location. At user location 1, points P2 and P4 should be the anchors because they form the largest angle against the user location when compared to any other combination of points. When the user moves to location 2, points P1 and P2 will form the largest against the user location and therefore should be the new anchors because any other combination doesn’t make largest angle than P1 and P2. 
 
Figure 4.12 Choosing landmark anchors
The calculateAngleBAC function in Figure 4.13 is defined in the Landmark class to help identifying the largest angle (LargestAngle) along with the associated landmark anchors (Selected1 & Selected2). In this function, A refers to the user location while B and C mark the two points in the landmark. This function is called for all combinations of point pairs P1P2, P1P3, P1P4, P2P3, P2P4 and P3P4.
 
Figure 4.13 Method calculateAngleBAC
Using landmark anchors to determine the location of landmark
After choosing the landmark anchors, the application is ready to determine whether the landmark is within the camera viewing angle. Assuming that 
α = angle of the first anchor – compass heading 
β = angle of the second anchor – compass heading
The application considers the following cases:
	α and β are of the same sign, which means that the two anchors are on the same side of the compass heading. Therefore, the landmark is within the camera view if |α| and/or |β| is no more than 22.5 degree. The landmark is outside the camera view if both |α| and |β| are greater than 22.5 degree.
	α and B are of different signs, which means that the two points are on the opposite sides of the compass heading. When the points are in the same direction as the compass heading, i.e. the landmark is within the camera view, |α – β| will be the same as the largest angle calculated above. Otherwise, the landmark is in the opposite direction than the compass heading and not within the camera view.
Calculating box location of landmark
In the application, a button box is created for each landmark retrieved from the database. When a landmark is not within the camera view, the button is set to be hidden. Otherwise, the application determines the horizontal location of box based on the position of a landmark in the camera-viewing angle. Figure 4.14 shows the function that calculates the horizontal location of the box, buttonX, based on the largest angle that is formed by landmark anchors, a1 and a2. The calculation is performed only when the value of state is higher than 0, which means that the landmark is inside the viewing angle. The buttonX value is the horizontal pixel value for the left side of the landmark box. The smallest value for buttonX is –boxWidth to allow a landmark box to gradually appear/disappear from the left side of the screen. The highest value for button is the screen width to allow a landmark box to gradually appear/disappear from the right side of the screen. 
 
Figure 4.14 Calculating button location
Views and their Controllers
There are four important views of the application that are shown in Figure 4.15. CameraView is created to access the live view of the camera. Over CameraView, a transparent GlView is added to augment 3D objects. BoxView is used to display the button boxes that represent landmarks within the current viewing angle. Event list and event details share one view, EventsView/DetailView to list the events in a landmark and also to display the detailed view of an event.
 
Figure 4.15 Arrangement of different views
Various controller classes are used to support the population and manipulation of contents for the above views. Figure 4.16 illustrates the relationships among these controller classes. The ARViewController class is the root view controller that is invoked when the application is started. This class has two sub view controllers CameraViewController and LandmarkController.  CameraViewController is responsible for bringing CameraView.
 
Figure 4.16 Controllers
As shown in Figure 4.17, the SetCamera method in the ARViewController instantiates a CameraViewController object and sets the size of CameraView as full screen. The preview layer in the Figure 4.17 is the CameraView in Figure 4.15. 
 
Figure 4.17 Method that initiates camera view
The LandmarkController class manages the rest of the views: GlView, Box View, and Events View. Every 1/25 second, LandmarkController refreshes GlView and BoxView to reposition the 3D objects and landmark boxes respectively. Each 3d object contains geo location of the 3d Object and URL for the location of the Wavefront Object file. LandmarkController creates a thread for each 3d object and assigns the thread to the loader method in the GLViewController class to reconstruct the 3d object from the Wavefront file. Once the 3D object is reconstructed, its horizontal location is determined using the same method for determining whether a landmark is within the camera view as explained in the section 4.3.2.4. The vertical location is set based on gyroscope and accelerometer reading of the device. This allows the object to appear in the middle of the screen when the device is held up vertically. As the device tilts toward the ground, the object moves gradually upward.  Similarly, as the device tilts toward the sky, the object moves gradually downward on the screen.
When the user touches a landmark box, the onButtonTouch event triggers LandmarkController to pass the selected landmark object to EventsViewController, which displays the list of events in the landmark, arranged by event dates. If the user selects an event, the selected event object is passed to DetailViewController, which displays the text and media contents of the selected event. NavigationViewController handles the navigation between EventsViewController and DetailViewController.
EventsViewController is used to display the list of events in a landmark. When user selects a landmark box, the associated landmark object is sent as an attribute while creating an instance of the EventsViewController class. This instance uses the events property in landmark to list the events in the landmark. NavigationController is used to navigate to the detail view of an event when the user selects the event. The code snippet in Figure 4.21 shows the implementation of the event handler for didSelectRowAtIndexPath, which is invoked when the user selects an event. It creates a new instance of DetailViewController to display an event that is selected by the user and the view is navigated to the detail view with help of navigationController.
 
Figure 4.18 Event handler didSelectRowAtIndexPath
DetailViewController makes use of the model AREvents to display information about the event in the detail view. Event details are populated in the detail view by setting the title of the navigation bar as the event name. Event date is displayed first, followed by the event location, description, notes and media elements. Medial elements are loaded based on the order they appear in the database. The detail view here is actually a scroll view which allows the user to scroll down and view the contents. It also gets help from ARCloud to load the images asynchronously. A video is played with the help of the MediaPlayer framework. 
Concluding Discussions
This project, GPS and Compass Aided Augmented Campus Guide proposes a method to identify a landmark without image recognition. This approach is similar to the methods used by applications such as AR Paris and Wikitude. However the exact implementation of their applications is not clear. This project also introduces a concept called Landmark Anchors, which helps locating a landmark more accurately than just using single coordinate for a landmark. The implementation of this project demonstrates greater understanding and integration of sensor GPS, compass, gyroscope with native iOS applications. This project also takes advantage of NoSQL database MongoDB for flexible design of the database and its spatial features. The system is composed of two parts, backend database and a frontend iPad application. The database consists of GPS coordinates of landmarks and iPad application uses them to identify landmarks by comparing them with geo location and compass heading of the device. Landmark boxes are augmented to the user screen in real-time as they come into the camera view of the device. Events associated with a landmark are stored either in database or in the user’s calendar. The application adds them to the user view when the user is interested in a landmark. In addition, this application allows tagging of a 3d object at a location. These 3d objects are augmented to the user view when he/she approaches the location. 
There exist different options of future work to extend this project. For example, user authentication can be added to support retrieval of data from a private server. Alternatively, a public server can be set up to crowd source landmark information along with their associated events. Social networks can be tapped in to gain information such as class reviews, must do activities, and even friends attending the same events.
This application is developed to provide campus members an augmented reality experience as they walk through the campus with their iPad. 
However, it can be very easily extended to other locations for various purposes. For example, theme parks can adapt this application to provide visitors with augmented guide of activities and events at different attractions throughout their parks. Such augmented guides can also assist visitors in navigating the park by giving direction and distance to attractions in real-time. In addition, this project can be easily modified to be an augmented reality game such as Ingress [27], which is a location-based strategy game, by adding game strategies and activity model into this application.
This application is designed and developed to work on iPad. In order for the app to work on iPhones, one will need to set new deployment settings in Xcode, which will create a new storyboard dimension suitable for iPhone. In addition, landmark box size and view of events will need to be changed because the number of dpi varies in lower iPhone models. Porting this application to Android or Windows platform would require re-implementing the iPad application due to language difference for Android and Window app development. However, the algorithms for using related sensor data to locate landmarks could remain the same. In addition, there will be no need to change the backend database or php scripts because both Java for Android and c# for Windows support https requests and JSON data processing.
Acknowledgements
I would like to thank my advisor Dr. Youwen Ouyang for her cooperation and interest in this phase of my graduate studies. It would not have been possible without her support and I am very grateful for that.


















References
	Augmented Reality. Wikipedia. (2002, September 15). Retrieved November 1, 2012 from http://en.wikipedia.org/wiki/Augmented_reality
	Columbia University http://graphics.cs.columbia.edu/projects/oc/henderson_feiner_oc_vrst08.pdf
	Quest Visual http://questvisual.com/us/
	National Defense Magazinehttp://www.nationaldefensemagazine.org/archive/2012/February/Pages/AvatarsInvadeMilitaryTrainingSystems.aspx
	Project Glass by Google https://www.google.com/+projectglass
	Presselite http://www.presselite.com/iphone/metroparis/index_en.html
	Google Maps Api https://developers.google.com/maps/
	XCode 4. (2012 Apple, Inc). Retrieved June 27, 2012, From Apple Developer Website: https://developer.apple.com/xcode/ 
	MongoDB http://www.mongodb.org/
	MongoDB PHP driver http://docs.mongodb.org/ecosystem/drivers/php/
	OpenGl http://www.opengl.org/about/
	Cocos3d http://brenwill.com/cocos3d/
	Unity3d http://unity3d.com
	Wavefront Object Loader https://github.com/jlamarche/iOS-OpenGLES-Stuff/tree/master/Wavefront%20OBJ%20Loader
	Wavefront Object http://en.wikipedia.org/wiki/Wavefront_.obj_file
	10Gen http://www.10gen.com/
	Foursquare https://foursquare.com/
	Craigslist http://craigslist.com
	RockMongo http://rockmongo.com
	NoSQL http://nosql-database.org/

	W. Guan, S. You, and U. Neumann, GPS-aided recognition-based user tracking system with augmented reality in extreme large-scale areas. In Proceedings of RFID Explained. 2011 
	Wikitude http://www.wikitude.com/app
	Database commands http://docs.mongodb.org/manual/reference/commands/
	geoNear http://docs.mongodb.org/manual/reference/command/geoNear/#geoNear
	PnPoly http://www.ecse.rpi.edu/Homepages/wrf/Research/Short_Notes/pnpoly.html
	Jordan Curve theorem http://en.wikipedia.org/wiki/Jordan_curve_theorem
	Ingress http://www.ingress.com/










